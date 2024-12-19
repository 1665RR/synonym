import 'package:flutter/material.dart';

import '../component/input_field.dart';

class AddSynonymScreen extends StatefulWidget {
  const AddSynonymScreen({
    super.key,
    required this.onAddSynonym,
  });

  final Function(String word, List<String> synonym) onAddSynonym;

  @override
  State<AddSynonymScreen> createState() => _AddSynonymScreenState();
}

class _AddSynonymScreenState extends State<AddSynonymScreen> {
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _synonymController = TextEditingController();

  List<String> _synonymList = [];

  void _addSynonymToList() {
    String synonym = _synonymController.text.trim().toLowerCase();
    if (synonym.isNotEmpty && !_synonymList.contains(synonym)) {
      setState(() {
        _synonymList.add(synonym);
      });
      _synonymController.clear();
    }
  }

  void _removeSynonymFromList(String synonym) {
    setState(() {
      _synonymList.remove(synonym);
    });
  }

  void _onSubmit() {
    String input = _inputController.text.trim().toLowerCase();
    if (input.isNotEmpty && _synonymList.isNotEmpty) {
      widget.onAddSynonym(input, _synonymList);
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please provide a word and at least one synonym.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Synonym'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          elevation: 18.0,
          shadowColor: Colors.red.withOpacity(0.6),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                InputField(
                  controller: _inputController,
                  labelText: 'Enter main word',
                  icon: Icons.text_fields,
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: InputField(
                        controller: _synonymController,
                        labelText: 'Enter synonym',
                        icon: Icons.add,
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: _addSynonymToList,
                      child: const Text(
                        'Add',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                if (_synonymList.isNotEmpty)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Synonyms:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ..._synonymList.map((synonym) => ListTile(
                              leading: const Icon(Icons.circle,
                                  size: 12, color: Colors.grey),
                              title: Text(
                                synonym,
                                style: const TextStyle(fontSize: 18),
                              ),
                              trailing: IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () =>
                                    _removeSynonymFromList(synonym),
                              ),
                            )),
                      ],
                    ),
                  ),
                const SizedBox(height: 32),
                FloatingActionButton.extended(
                  onPressed: _onSubmit,
                  label: const Text(
                    'Save Synonyms',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
