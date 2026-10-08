import 'package:flutter/material.dart';
import 'package:h1/features/roster/widgets/charactercard.dart';
import 'package:h1/features/roster/widgets/emptystate.dart';
import 'package:h1/features/roster/widgets/filterbar.dart';
import 'package:h1/features/roster/widgets/searchbar.dart';

class RosterScreen extends StatefulWidget {
  final VoidCallback? onToggleTheme;
  final bool isDarkMode;

  const RosterScreen({
    super.key,
    this.onToggleTheme,
    this.isDarkMode = true,
  });

  @override
  State<RosterScreen> createState() => _RosterScreenState();
}

class _RosterScreenState extends State<RosterScreen> {
  String _searchQuery = '';
  String _selectedElement = 'All';
  final List<String> _elements = ['All', 'Fire', 'Water', 'Lightning', 'Dark'];

  final List<Map<String, String>> _allCharacters = [
    {'name': 'Kaelen', 'element': 'Fire', 'role': 'DPS', 'imageUrl': 'assets/charactercard/Kaelan.jpg'},
    {'name': 'Aria', 'element': 'Water', 'role': 'Support', 'imageUrl': 'assets/charactercard/water.jpg'},
    {'name': 'Sol', 'element': 'Fire', 'role': 'Striker', 'imageUrl': 'assets/charactercard/fireboy.jpg'},
    {'name': 'Nyx', 'element': 'Dark', 'role': 'Assassin', 'imageUrl': 'assets/charactercard/Nyx.jpg'},
  ];

  List<Map<String, String>> get _filteredCharacters {
    return _allCharacters.where((char) {
      final matchesSearch = char['name']!.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesElement = _selectedElement == 'All' || char['element'] == _selectedElement;
      return matchesSearch && matchesElement;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredCharacters;
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth > 600 ? 4 : 2;

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.shield_outlined, size: 24),
            SizedBox(width: 8),
            Text('Character Index'),
          ],
        ),
        actions: [
          if (widget.onToggleTheme != null)
            IconButton(
              icon: Icon(
                widget.isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
              ),
              tooltip: 'Toggle Theme',
              onPressed: widget.onToggleTheme,
            ),
        ],
      ),
      body: Column(
        children: [
          CharacterSearchBar(
            query: _searchQuery,
            onChanged: (value) => setState(() => _searchQuery = value),
          ),
          const SizedBox(height: 4),
          ElementFilterBar(
            elements: _elements,
            selectedElement: _selectedElement,
            onSelected: (element) => setState(() => _selectedElement = element),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: filtered.isEmpty
                ? RosterEmptyState(
                    onReset: () => setState(() {
                      _searchQuery = '';
                      _selectedElement = 'All';
                    }),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      return CharacterCard(
                        character: filtered[index],
                        onTap: () {},
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
