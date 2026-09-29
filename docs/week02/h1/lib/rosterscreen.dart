import 'package:flutter/material.dart';
import 'package:h1/features/roster/widgets/CharacterCard.dart';
import 'package:h1/features/roster/widgets/emptystate.dart';
import 'package:h1/features/roster/widgets/filterbar.dart';
import 'package:h1/features/roster/widgets/searchbar.dart';

class RosterScreen extends StatefulWidget {
  const RosterScreen({super.key});

  @override
  State<RosterScreen> createState() => _RosterScreenState();
}

class _RosterScreenState extends State<RosterScreen> {
  String _searchQuery = '';
  String _selectedElement = 'All';
  final List<String> _elements = ['All', 'Fire', 'Water', 'Lightning', 'Dark'];


  final List<Map<String, String>> _allCharacters = [
    {'name': 'Kaelen', 'element': 'Fire', 'role': 'DPS', 'imageUrl': 'assets/charactercard/Kaelan.jpg'},
    {'name': 'Aria', 'element': 'Water', 'role': 'Support', 'imageUrl':'assets/charactercard/water.jpg'},
    {'name': 'Sol', 'element': 'Fire', 'role': 'Striker', 'imageUrl':'assets/charactercard/fireboy.jpg'},
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

    return Scaffold(
      appBar: AppBar(title: const Text('Character Index')),
      body: Column(
        children: [
          CharacterSearchBar(
            query: _searchQuery,
            onChanged: (value) => setState(() => _searchQuery = value),
          ),

          ElementFilterBar(
            elements: _elements,
            selectedElement: _selectedElement,
            onSelected: (element) => setState(() => _selectedElement = element),
          ),

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
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      return CharacterCard(
                        character: filtered[index],
                        onTap: () {
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}