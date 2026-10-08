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

  IconData? _getElementIcon(String element) {
    switch (element.toLowerCase()) {
      case 'fire':
        return Icons.local_fire_department_rounded;
      case 'water':
        return Icons.water_drop_rounded;
      case 'lightning':
        return Icons.bolt_rounded;
      case 'dark':
        return Icons.dark_mode_rounded;
      case 'all':
        return Icons.grid_view_rounded;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: elements.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final element = elements[index];
          final isSelected = element == selectedElement;
          final icon = _getElementIcon(element);

          return FilterChip(
            avatar: icon != null
                ? Icon(
                    icon,
                    size: 16,
                    color: isSelected
                        ? Theme.of(context).colorScheme.onPrimaryContainer
                        : Theme.of(context).colorScheme.primary,
                  )
                : null,
            label: Text(element),
            selected: isSelected,
            onSelected: (_) => onSelected(element),
            showCheckmark: false,
          );
        },
      ),
    );
  }
}
