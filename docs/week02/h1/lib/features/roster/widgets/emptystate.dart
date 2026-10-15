import 'package:flutter/material.dart';

class RosterEmptyState extends StatelessWidget {
  final VoidCallback onReset;

  const RosterEmptyState({super.key, required this.onReset});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDark ? const Color(0xFF131A29) : const Color(0xFFFEF3C7),
                border: Border.all(
                  color: const Color(0xFFEAB308).withOpacity(0.5),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFEAB308).withOpacity(0.25),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: const Icon(
                Icons.shield_moon_outlined,
                size: 64,
                color: Color(0xFFEAB308),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'NO HEROES FOUND IN ARCHIVE',
              style: theme.textTheme.titleMedium?.copyWith(
                color: isDark ? const Color(0xFFF1F5F9) : const Color(0xFF1E293B),
                fontWeight: FontWeight.w900,
                letterSpacing: 1.0,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'No hero profile matches your search keyword or selected elemental affinity.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                fontSize: 13,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: onReset,
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFFEAB308),
                foregroundColor: const Color(0xFF0F172A),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
              ),
              icon: const Icon(Icons.refresh_rounded, size: 18),
              label: const Text(
                'RESET ARCHIVE FILTERS',
                style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
