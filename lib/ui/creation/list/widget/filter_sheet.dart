import 'package:flutter/material.dart';
import 'package:vesti_art/core/models/creation.dart';
import 'package:vesti_art/core/services/authentication_service.dart';
import 'package:vesti_art/networking/api_creation.dart';

class FilterSheet extends StatefulWidget {
  final ReferenceType currentReferenceType;
  final Sort? currentSort;
  final Function(ReferenceType) changeReferenceType;
  final Function(Sort) changeSort;

  const FilterSheet({
    super.key,
    required this.currentReferenceType,
    required this.currentSort,
    required this.changeReferenceType,
    required this.changeSort,
  });

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  late ReferenceType _selectedReferenceType;
  late Sort _selectedSort;
  late bool _showMineOnly;
  
  // Variables pour suivre quelle section est active
  bool _isCategoryActive = false;
  bool _isMineActive = false;
  bool _isSortActive = false;

  @override
  void initState() {
    super.initState();
    _selectedReferenceType = widget.currentReferenceType;
    _selectedSort = widget.currentSort ?? Sort.dateCreate;
    _showMineOnly = widget.currentSort == Sort.mine;
    
    // Initialiser l'état actif en fonction des valeurs actuelles
    _isCategoryActive = _selectedReferenceType != ReferenceType.all;
    _isMineActive = _showMineOnly;
    _isSortActive = !_isCategoryActive && !_isMineActive && _selectedSort != Sort.dateCreate;
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final theme = Theme.of(context);
    
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildHandle(theme),
              _buildHeader(context),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16 + bottomInset),
                  children: [
                    Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: _buildReferenceTypeSection(context),
                      ),
                    ),
                    if (AuthenticationService.instance.isAuthenticated)
                      Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: _buildMyCreationsSection(context),
                        ),
                      ),
                    Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: _buildSortSection(context),
                      ),
                    ),
                  ],
                ),
              ),
              _buildApplyButton(context),
            ],
          ),
        );
      },
    );
  }
  
  Widget _buildHandle(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: theme.colorScheme.onSurface.withOpacity(0.2),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Filtrer et trier',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  // Détermine si la section catégorie doit être désactivée
  bool get _isCategoryDisabled => _isMineActive || _isSortActive;
  
  // Détermine si la section Mes créations doit être désactivée
  bool get _isMineDisabled => _isCategoryActive || _isSortActive;
  
  // Détermine si la section tri doit être désactivée
  bool get _isSortDisabled => _isCategoryActive || _isMineActive;
  
  Widget _buildReferenceTypeSection(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.category, color: theme.colorScheme.primary, size: 20),
            const SizedBox(width: 8),
            Text(
              'Catégorie',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: ReferenceType.values.map((type) => _buildReferenceChip(type)).toList(),
        ),
      ],
    );
  }

  Widget _buildReferenceChip(ReferenceType type) {
    final isSelected = _selectedReferenceType == type;
    final theme = Theme.of(context);

    return ChoiceChip(
      label: Text(
        type.label,
        style: TextStyle(
          color: isSelected
              ? theme.colorScheme.onPrimary
              : _isCategoryDisabled 
                ? theme.colorScheme.onSurface.withOpacity(0.4)
                : theme.colorScheme.onSurface,
          fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      backgroundColor: Colors.transparent,
      selectedColor: theme.colorScheme.primary,
      side: BorderSide(
        color: isSelected
            ? theme.colorScheme.primary
            : theme.colorScheme.onSurface.withOpacity(0.2),
      ),
      onSelected: _isCategoryDisabled ? null : (selected) {
        setState(() {
          if (selected) {
            _selectedReferenceType = type;
            _isCategoryActive = type != ReferenceType.all;
            // Réinitialiser les autres filtres si nécessaire
            if (_isCategoryActive) {
              _showMineOnly = false;
              _isMineActive = false;
              _selectedSort = Sort.dateCreate;
              _isSortActive = false;
            }
          } else if (_selectedReferenceType == type) {
            _selectedReferenceType = ReferenceType.all;
            _isCategoryActive = false;
          }
        });
      },
    );
  }

  Widget _buildSortSection(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDisabled = _isSortDisabled;    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.sort, 
              color: isDisabled 
                ? theme.colorScheme.onSurface.withOpacity(0.4)
                : theme.colorScheme.primary, 
              size: 20
            ),
            const SizedBox(width: 8),
            Text(
              'Trier par',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: isDisabled
                  ? theme.colorScheme.onSurface.withOpacity(0.6)
                  : null,
              ),
            ),
            if (isDisabled) ...[              
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '(Désactivé lors du filtrage par catégorie)',
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontStyle: FontStyle.italic,
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 8),
        ..._buildSortOptions(isDisabled),
      ],
    );
  }

  List<Widget> _buildSortOptions(bool isDisabled) {
    final sortOptions = Sort.values.where((sort) => sort != Sort.mine).toList();
    final theme = Theme.of(context);
    
    final List<Widget> options = sortOptions.map((sort) {
      final isSelected = _selectedSort == sort;
      
      return Material(
        color: Colors.transparent,
        child: RadioListTile<Sort>(
          title: Text(
            sort.label,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              color: isDisabled 
                ? theme.colorScheme.onSurface.withOpacity(0.4)
                : null,
            ),
          ),
          value: sort,
          groupValue: _selectedSort,
          activeColor: theme.colorScheme.primary,
          contentPadding: const EdgeInsets.symmetric(horizontal: 4),
          dense: true,
          onChanged: isDisabled ? null : (value) {
            if (value != null) {
              setState(() {
                _selectedSort = value;
                _isSortActive = value != Sort.dateCreate;
                
                if (_isSortActive) {
                  // Désactiver les autres options
                  _selectedReferenceType = ReferenceType.all;
                  _isCategoryActive = false;
                  _showMineOnly = false;
                  _isMineActive = false;
                }
                
                if (_showMineOnly) {
                  _showMineOnly = false;
                }
              });
            }
          },
        ),
      );
    }).toList();

    // Suppression de la partie 'Mes créations uniquement' qui est maintenant dans sa propre section

    return options;
  }

  Widget _buildMyCreationsSection(BuildContext context) {
    final theme = Theme.of(context);
    final isDisabled = _isMineDisabled;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Icon(
              Icons.person,
              size: 18,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(width: 8),
            Text(
              'Mes créations',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: isDisabled 
                  ? theme.colorScheme.primary.withOpacity(0.5)
                  : theme.colorScheme.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Material(
          color: Colors.transparent,
          child: CheckboxListTile(
            title: Text(
              'Afficher uniquement mes créations',
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: _showMineOnly ? FontWeight.w600 : FontWeight.normal,
                color: isDisabled
                  ? theme.colorScheme.onSurface.withOpacity(0.4)
                  : null,
              ),
            ),
            value: _showMineOnly,
            activeColor: theme.colorScheme.primary,
            contentPadding: const EdgeInsets.symmetric(horizontal: 4),
            dense: true,
            onChanged: isDisabled ? null : (value) {
              setState(() {
                _showMineOnly = value ?? false;
                _isMineActive = _showMineOnly;
                
                if (_showMineOnly) {
                  _selectedSort = Sort.mine;
                  // Désactiver les autres sections
                  _selectedReferenceType = ReferenceType.all;
                  _isCategoryActive = false;
                  _isSortActive = false;
                } else {
                  _selectedSort = Sort.dateCreate;
                }
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildApplyButton(BuildContext context) {
    final theme = Theme.of(context);
    
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: theme.colorScheme.onPrimary,
              backgroundColor: theme.colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24),
            ),
            onPressed: () {
              widget.changeReferenceType(_selectedReferenceType);
              widget.changeSort(_selectedSort);
              Navigator.of(context).pop();
            },
            child: const Text(
              'Appliquer',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
