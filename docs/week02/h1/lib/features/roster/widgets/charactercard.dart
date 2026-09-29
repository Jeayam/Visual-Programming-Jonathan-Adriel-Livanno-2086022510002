import 'package:flutter/material.dart';

class CharacterCard extends StatelessWidget {
  final Map<String, String> character;
  final VoidCallback onTap;

  const CharacterCard({
    super.key,
    required this.character,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image.asset(
                character['imageUrl'] ?? '',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.person, size: 48, color: Colors.grey),
                ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    character['name']!,
                    style: Theme.of(context).textTheme.titleSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Chip(
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    labelStyle: const TextStyle(fontSize: 10),
                    label: Text('${character['element']} • ${character['role']}'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}