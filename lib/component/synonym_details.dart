import 'package:flutter/material.dart';

import '../themes/theme.dart';

class SynonymDetailsCard extends StatelessWidget {
  const SynonymDetailsCard({super.key, required this.result});
  final Map<String, List<String>> result;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: result.entries.map((entry) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: AppSpacing.medium),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 12.0,
          shadowColor: Colors.purple,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.large, vertical: AppSpacing.medium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.key,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                const SizedBox(height: AppSpacing.medium),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: entry.value.map((syn) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.medium,
                          vertical: AppSpacing.small),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border:
                            Border.all(color: Colors.deepPurple, width: 1.5),
                      ),
                      child: Text(
                        syn,
                        style: const TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                          color: Colors.deepPurple,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
