import 'package:flutter/material.dart';

class CharacterCard extends StatelessWidget {
  final Map<String, String> character;
  final VoidCallback onTap;

  const CharacterCard({
    super.key,
    required this.character,
    required this.onTap,
  });

  IconData _getElementIcon(String element) {
    switch (element.toLowerCase()) {
      case 'fire':
        return Icons.local_fire_department_rounded;
      case 'water':
        return Icons.water_drop_rounded;
      case 'lightning':
        return Icons.bolt_rounded;
      case 'dark':
        return Icons.dark_mode_rounded;
      default:
        return Icons.auto_awesome_rounded;
    }
  }

  Color _getElementColor(String element, bool isDark) {
    switch (element.toLowerCase()) {
      case 'fire':
        return isDark ? const Color(0xFFEF4444) : const Color(0xFFDC2626);
      case 'water':
        return isDark ? const Color(0xFF38BDF8) : const Color(0xFF0284C7);
      case 'lightning':
        return isDark ? const Color(0xFFFBBF24) : const Color(0xFFD97706);
      case 'dark':
        return isDark ? const Color(0xFFA855F7) : const Color(0xFF7E22CE);
      default:
        return isDark ? const Color(0xFFA78BFA) : const Color(0xFF6D28D9);
    }
  }

  Color _getElementBgColor(String element, bool isDark) {
    switch (element.toLowerCase()) {
      case 'fire':
        return isDark ? const Color(0xFF450A0A) : const Color(0xFFFEE2E2);
      case 'water':
        return isDark ? const Color(0xFF0C4A6E) : const Color(0xFFE0F2FE);
      case 'lightning':
        return isDark ? const Color(0xFF451A03) : const Color(0xFFFEF3C7);
      case 'dark':
        return isDark ? const Color(0xFF3B0764) : const Color(0xFFF3E8FF);
      default:
        return isDark ? const Color(0xFF2E1065) : const Color(0xFFEDE9FE);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final element = character['element'] ?? '';
    final role = character['role'] ?? '';
    final name = character['name'] ?? '';

    final elementColor = _getElementColor(element, isDark);
    final elementBg = _getElementBgColor(element, isDark);
    final elementIcon = _getElementIcon(element);

    return Card(
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isDark
              ? Colors.white.withOpacity(0.08)
              : Colors.black.withOpacity(0.05),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    character['imageUrl'] ?? '',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: theme.colorScheme.surfaceContainerHigh,
                      child: Icon(
                        Icons.person,
                        size: 48,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  // Gradient Overlay
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.1),
                            Colors.black.withOpacity(0.6),
                          ],
                          stops: const [0.5, 0.8, 1.0],
                        ),
                      ),
                    ),
                  ),
                  // Element badge on image
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.55),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: elementColor.withOpacity(0.6),
                          width: 1.5,
                        ),
                      ),
                      child: Icon(
                        elementIcon,
                        size: 16,
                        color: elementColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // AFTER STATE: Nama karakter diperbesar dan dipertegas (titleMedium + FontWeight.bold) sehingga dominan secara visual
                  Text(
                    name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.2,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  // Elemental Badge with Icon
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: elementBg,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: elementColor.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          elementIcon,
                          size: 13,
                          color: elementColor,
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            '$element • $role',
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: elementColor,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
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
