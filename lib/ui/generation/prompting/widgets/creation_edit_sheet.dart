import 'package:flutter/material.dart';
import 'package:vesti_art/core/models/reference_type.dart';
import '../../../../core/models/creation_draft.dart';

class CreationEditSheet extends StatefulWidget {
  final CreationDraft draft;
  final Function(CreationDraft) onSave;

  const CreationEditSheet({
    super.key,
    required this.draft,
    required this.onSave,
  });

  @override
  State<CreationEditSheet> createState() => _CreationEditSheetState();
}

class _CreationEditSheetState extends State<CreationEditSheet> {
  late String _name;
  late String _promptText;
  late String _reference;
  late ReferenceType _referenceType;
  bool _attemptedSave = false;

  @override
  void initState() {
    super.initState();
    _name = widget.draft.name;
    _promptText = widget.draft.promptText;
    _reference = widget.draft.reference;
    _referenceType = widget.draft.referenceType;
  }

  bool get _isNameValid => _name.isNotEmpty;
  bool get _isPromptValid => _promptText.isNotEmpty;
  bool get _isReferenceValid => _reference.isNotEmpty;
  bool get _isFormValid => _isNameValid && _isPromptValid && _isReferenceValid;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.edit, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Brouillon de création',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context, false),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Ce brouillon sera enregistré uniquement si vous cliquez sur "Enregistrer"',
              style: TextStyle(
                fontSize: 12,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Nom de la création',
              hint: 'Entrez un nom descriptif',
              initialValue: _name,
              onChanged: (value) {
                setState(() {
                  _name = value;
                });
              },
              maxLines: 1,
              icon: Icons.title,
              showError: _attemptedSave && !_isNameValid,
              errorText: 'Veuillez entrer un nom',
              tooltip: 'Entrez un nom pour identifier votre création',
            ),
            const SizedBox(height: 12),
            _buildTextField(
              label: 'Prompt',
              hint: 'Décrivez votre création en détail',
              initialValue: _promptText,
              onChanged: (value) {
                setState(() {
                  _promptText = value;
                });
              },
              maxLines: 3,
              icon: Icons.description,
              showError: _attemptedSave && !_isPromptValid,
              errorText: 'Veuillez entrer un prompt',
              tooltip:
                  'Décrivez votre création avec suffisamment de détails pour guider la génération',
            ),
            const SizedBox(height: 12),
            _buildReferenceTypeDropdown(),
            const SizedBox(height: 12),
            _buildTextField(
              label: 'Référence',
              hint: 'Ex: Les carnets de l\'apoticaire',
              initialValue: _reference,
              onChanged: (value) {
                setState(() {
                  _reference = value;
                });
              },
              maxLines: 1,
              icon: Icons.bookmark,
              showError: _attemptedSave && !_isReferenceValid,
              errorText: 'Veuillez indiquer une référence',
              tooltip:
                  'Indiquez le titre de l\'œuvre qui servira de référence pour le style',
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Annuler'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _attemptedSave = true;
                      });

                      if (_isFormValid) {
                        final updatedDraft = CreationDraft(
                          uuid: widget.draft.uuid,
                          name: _name,
                          promptText: _promptText,
                          reference: _reference,
                          referenceType: _referenceType,
                        );
                        widget.onSave(updatedDraft);
                        Navigator.pop(context, true);
                      }
                    },
                    icon: const Icon(Icons.save),
                    label: const Text('Enregistrer'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildReferenceTypeDropdown() {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.category, size: 18, color: theme.colorScheme.primary),
            const SizedBox(width: 8),
            Text(
              'Type de référence',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(width: 8),
            InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Sélectionnez la catégorie à laquelle appartient votre référence (anime, manga, etc.)',
                    ),
                    duration: const Duration(seconds: 3),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              child: Icon(
                Icons.info_outline,
                size: 16,
                color: theme.colorScheme.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: theme.colorScheme.outline, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<ReferenceType>(
              value: _referenceType,
              isExpanded: true,
              hint: const Text('Sélectionnez un type'),
              items:
                  ReferenceType.all.map((type) {
                    return DropdownMenuItem<ReferenceType>(
                      value: type,
                      child: Text(type.displayName),
                    );
                  }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _referenceType = value;
                  });
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required String initialValue,
    required Function(String) onChanged,
    required int maxLines,
    required IconData icon,
    required bool showError,
    required String errorText,
    required String tooltip,
  }) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: theme.colorScheme.primary),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(width: 8),
            InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(tooltip),
                    duration: const Duration(seconds: 3),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              child: Icon(
                Icons.info_outline,
                size: 16,
                color: theme.colorScheme.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: initialValue,
          onChanged: onChanged,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            errorText: showError ? errorText : null,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }
}
