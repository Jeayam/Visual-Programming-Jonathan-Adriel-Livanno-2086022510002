import 'package:flutter/material.dart';

class RosterEmptyState extends StatelessWidget {
  final VoidCallback onReset;

  const RosterEmptyState({super.key, required this.onReset});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.person_search, size: 64, color: Colors.grey),
          const SizedBox(height: 12),
          const Text('Karakter tidak ditemukan'),
          TextButton(
            onPressed: onReset,
            child: const Text('Reset Filter'),
          )
        ],
      ),
    );
  }
}