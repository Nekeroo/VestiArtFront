import 'package:flutter/material.dart';
import '../prompting_viewmodel.dart';

class CreationEditSheet extends StatefulWidget {
  final CreationDraft draft;
  final Function(String) onNameChanged;
  final Function(String) onPromptChanged;
  final VoidCallback onSave;
  
  const CreationEditSheet({
    super.key,
    required this.draft,
    required this.onNameChanged,
    required this.onPromptChanged,
    required this.onSave,
  });

  @override
  State<CreationEditSheet> createState() => _CreationEditSheetState();
}

class _CreationEditSheetState extends State<CreationEditSheet> {
  String _name = '';
  String _promptText = '';
  bool _attemptedSave = false;
  
  @override
  void initState() {
    super.initState();
    _name = widget.draft.name;
    _promptText = widget.draft.promptText;
  }
  
  bool get _isNameValid => _name.isNotEmpty;
  bool get _isPromptValid => _promptText.isNotEmpty;
  bool get _isFormValid => _isNameValid && _isPromptValid;
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.edit,
                color: theme.colorScheme.primary,
              ),
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
          ),
          const SizedBox(height: 12),
          _buildTextField(
            label: 'Description',
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
            errorText: 'Veuillez entrer une description',
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
                      widget.onNameChanged(_name);
                      widget.onPromptChanged(_promptText);
                      widget.onSave();
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
    );
  }
  
  Widget _buildTextField({
    required String label,
    required String hint,
    required String initialValue,
    required Function(String) onChanged,
    required IconData icon,
    int maxLines = 1,
    bool showError = false,
    String errorText = '',
  }) {
    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        errorText: showError ? errorText : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        prefixIcon: Icon(icon),
      ),
      textInputAction: maxLines > 1 ? TextInputAction.newline : TextInputAction.next,
    );
  }
}
