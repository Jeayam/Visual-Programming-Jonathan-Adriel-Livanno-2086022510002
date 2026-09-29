import 'package:flutter/material.dart';

class ElementFilterBar extends StatelessWidget {
  final List<String> elements;
  final String selectedElement;
  final ValueChanged<String> onSelected;

  const ElementFilterBar({
    super.key,
    required this.elements,
    required this.selectedElement,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: elements.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final element = elements[index];
          final isSelected = element == selectedElement;
          return ChoiceChip(
            label: Text(element),
            selected: isSelected,
            onSelected: (_) => onSelected(element),
          );
        },
      ),
    );
  }
}