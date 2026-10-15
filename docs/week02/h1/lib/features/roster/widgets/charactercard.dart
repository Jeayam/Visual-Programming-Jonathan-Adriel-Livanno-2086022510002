import 'package:flutter/material.dart';

class CharacterCard extends StatefulWidget {
  final Map<String, String> character;
  final VoidCallback onTap;

  const CharacterCard({
    super.key,
    required this.character,
    required this.onTap,
  });

  @override
  State<CharacterCard> createState() => _CharacterCardState();
}

class _CharacterCardState extends State<CharacterCard> {
  bool _isHovered = false;

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
        return const Color(0xFFEF4444);
      case 'water':
        return const Color(0xFF38BDF8);
      case 'lightning':
        return const Color(0xFFFBBF24);
      case 'dark':
        return const Color(0xFFA855F7);
      default:
        return const Color(0xFFA78BFA);
    }
  }

  List<Color> _getElementGradient(String element, bool isDark) {
    switch (element.toLowerCase()) {
      case 'fire':
        return [const Color(0xFF7F1D1D), const Color(0xFFDC2626)];
      case 'water':
        return [const Color(0xFF0C4A6E), const Color(0xFF0284C7)];
      case 'lightning':
        return [const Color(0xFF78350F), const Color(0xFFD97706)];
      case 'dark':
        return [const Color(0xFF4C1D95), const Color(0xFF7E22CE)];
      default:
        return [const Color(0xFF312E81), const Color(0xFF4F46E5)];
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final element = widget.character['element'] ?? '';
    final role = widget.character['role'] ?? '';
    final name = widget.character['name'] ?? '';

    final dpr = MediaQuery.of(context).devicePixelRatio;
    final dynamicCacheWidth = (350 * dpr).round().clamp(600, 1200);

    final elementColor = _getElementColor(element, isDark);
    final elementGradient = _getElementGradient(element, isDark);
    final elementIcon = _getElementIcon(element);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        transform: _isHovered ? (Matrix4.identity()..scale(1.04)..translate(0, -6, 0)) : Matrix4.identity(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? elementColor.withOpacity(0.5)
                  : (isDark ? Colors.black.withOpacity(0.4) : Colors.black.withOpacity(0.08)),
              blurRadius: _isHovered ? 20 : 8,
              offset: Offset(0, _isHovered ? 8 : 4),
            ),
          ],
        ),
        child: Card(
          elevation: _isHovered ? 8 : 3,
          margin: EdgeInsets.zero,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: _isHovered
                  ? elementColor
                  : (isDark ? const Color(0xFF2A344B) : const Color(0xFFE2D9C5)),
              width: _isHovered ? 2 : 1.2,
            ),
          ),
          child: InkWell(
            onTap: widget.onTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Top Image Area with Rarity & Element Header
                Expanded(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Character Artwork
                      Image.asset(
                        widget.character['imageUrl'] ?? '',
                        fit: BoxFit.cover,
                        cacheWidth: dynamicCacheWidth,
                        errorBuilder: (context, error, stackTrace) => Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: elementGradient,
                            ),
                          ),
                          child: const Icon(
                            Icons.shield,
                            size: 48,
                            color: Colors.white60,
                          ),
                        ),
                      ),
                      // Vignette Darkening Overlay
                      Positioned.fill(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.2),
                                Colors.transparent,
                                Colors.black.withOpacity(0.85),
                              ],
                              stops: const [0.0, 0.4, 1.0],
                            ),
                          ),
                        ),
                      ),
                      // Top Left: 5-Star Mythic Rating Badge
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFD97706), Color(0xFFFBBF24)],
                            ),
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.4),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.star, size: 10, color: Colors.white),
                              SizedBox(width: 2),
                              Text(
                                '5★',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Top Right: Elemental Icon Badge with Metallic Border
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0F172A).withOpacity(0.85),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: elementColor,
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: elementColor.withOpacity(0.4),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: Icon(
                            elementIcon,
                            size: 14,
                            color: elementColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Bottom Card Information Section
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF131927) : const Color(0xFFFAFAFA),
                    border: Border(
                      top: BorderSide(
                        color: elementColor.withOpacity(0.3),
                        width: 1.5,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Character Name
                      Text(
                        name,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                          letterSpacing: 0.2,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      // Element & Role Pill
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              elementGradient[0].withOpacity(isDark ? 0.6 : 0.15),
                              elementGradient[1].withOpacity(isDark ? 0.4 : 0.10),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: elementColor.withOpacity(0.4),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(elementIcon, size: 12, color: elementColor),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                '${element.toUpperCase()} • $role',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  color: isDark ? elementColor : elementGradient[0],
                                  letterSpacing: 0.5,
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
        ),
      ),
    );
  }
}
