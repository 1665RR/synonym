import 'package:flutter/material.dart';
import 'package:synou/screens/add_synonym_screen.dart';

import '../component/input_field.dart';
import '../component/synonym_details.dart';
import '../themes/theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  Map<String, List<String>> synonyms = {
    'happy': ['joyful', 'content', 'cheerful'],
    'sad': ['unhappy', 'downcast', 'miserable'],
    'difficult': ['challenging', 'hard'],
  };

  Map<String, List<String>> _synonymResults = {};
  List<String> _suggestions = [];

  // create suggestion from search input
  void _searchSuggestions(String input) {
    setState(() {
      _suggestions.clear();

      if (input.length >= 3) {
        synonyms.forEach((key, value) {
          if (key.toLowerCase().contains(input.toLowerCase()) ||
              value.any(
                  (syn) => syn.toLowerCase().contains(input.toLowerCase()))) {
            if (!_suggestions.contains(key)) {
              _suggestions.add(key);
            }
            for (var synonym in value) {
              if (synonym.toLowerCase().contains(input.toLowerCase()) &&
                  !_suggestions.contains(synonym)) {
                _suggestions.add(synonym);
              }
            }
          }
        });
      }
    });
  }

  // search through synonyms
  void _searchSynonym(String word) {
    setState(() {
      if (word.isNotEmpty) {
        Map<String, List<String>> results = {};

        if (synonyms.containsKey(word)) {
          results[word] = synonyms[word]!;
        }

        synonyms.forEach((key, value) {
          if (value.contains(word)) {
            results[key] = value;
          }
        });

        _synonymResults = results;
      }
    });
  }

  void _handleAddSynonym(String word, List<String> synonymsToAdd) {
    setState(() {
      if (synonyms.containsKey(word)) {
        synonyms[word]?.addAll(synonymsToAdd);
      } else {
        synonyms[word] = synonymsToAdd;
      }
    });
  }

  void _navigateToAddSynonymPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddSynonymScreen(onAddSynonym: _handleAddSynonym),
      ),
    );
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _synonymResults = {};
      _suggestions.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.medium),
          child: Row(
            children: [
              const Icon(Icons.sort_by_alpha, size: 30, color: Colors.white),
              const SizedBox(width: AppSpacing.medium),
              Text(
                'Synonymous',
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: AppSpacing.medium),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: InputField(
              controller: _searchController,
              labelText: 'Enter word to search for synonyms',
              icon: Icons.search,
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: _clearSearch,
                    )
                  : null,
              onChanged: (text) {
                _searchSuggestions(text);
              },
            ),
          ),
          if (_suggestions.isNotEmpty)
            Container(
              margin: const EdgeInsets.all(AppSpacing.medium),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
              ),
              child: Column(
                children: _suggestions.map((suggestion) {
                  final synonymsForSuggestion = synonyms[suggestion] ?? [];
                  return ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          suggestion,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        if (synonymsForSuggestion.isNotEmpty)
                          Padding(
                            padding:
                                const EdgeInsets.only(top: AppSpacing.small),
                            child: Text(
                              synonymsForSuggestion.join(', '),
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                      ],
                    ),
                    onTap: () {
                      _searchController.text = suggestion;
                      _searchSynonym(suggestion);
                      setState(() {
                        _suggestions.clear();
                      });
                    },
                  );
                }).toList(),
              ),
            ),
          if (_synonymResults.isNotEmpty)
            SynonymDetailsCard(result: _synonymResults),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: AppSpacing.large, horizontal: AppSpacing.small),
            child: Center(
              child: Column(
                children: [
                  const Text(
                    'Welcome to Synonymous!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.small),
                  Text(
                    'Discover and add synonyms effortlessly. Start by adding a few words below or using search above.',
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: AppSpacing.extraLarge),
            child: FloatingActionButton.extended(
              onPressed: _navigateToAddSynonymPage,
              label: const Text(
                'Add Synonym',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              icon: const Icon(Icons.add),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      resizeToAvoidBottomInset: false,
    );
  }
}
