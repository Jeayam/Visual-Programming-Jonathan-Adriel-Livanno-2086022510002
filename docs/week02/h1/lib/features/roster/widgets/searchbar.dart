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
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: SearchBar(
        hintText: 'Search character name...',
        leading: const Icon(Icons.search),
        trailing: query.isNotEmpty
            ? [
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => onChanged(''),
                ),
              ]
            : null,
        onChanged: onChanged,
        elevation: WidgetStateProperty.all(1.0),
      ),
    );
  }
}
