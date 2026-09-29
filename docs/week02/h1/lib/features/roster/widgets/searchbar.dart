import 'package:flutter/material.dart';

class CharacterSearchBar extends StatelessWidget {
  final String query;
  final ValueChanged<String> onChanged;

  const CharacterSearchBar({
    super.key,
    required this.query,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Character name...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}