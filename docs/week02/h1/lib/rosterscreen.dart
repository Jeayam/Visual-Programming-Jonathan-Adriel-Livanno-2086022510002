import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:h1/features/roster/widgets/charactercard.dart';
import 'package:h1/features/roster/widgets/emptystate.dart';

enum TestDatasetMode { standard, longList, longText, empty }

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
  TestDatasetMode _datasetMode = TestDatasetMode.standard;

  final List<String> _elements = ['All', 'Fire', 'Water', 'Lightning', 'Dark'];

  final List<Map<String, String>> _standardCharacters = [
    {'name': 'Kaelen', 'element': 'Fire', 'role': 'DPS', 'imageUrl': 'assets/charactercard/Kaelan.jpg'},
    {'name': 'Aria', 'element': 'Water', 'role': 'Support', 'imageUrl': 'assets/charactercard/water.jpg'},
    {'name': 'Sol', 'element': 'Fire', 'role': 'Striker', 'imageUrl': 'assets/charactercard/fireboy.jpg'},
    {'name': 'Nyx', 'element': 'Dark', 'role': 'Assassin', 'imageUrl': 'assets/charactercard/Nyx.jpg'},
  ];

  late final List<Map<String, String>> _500Characters = List.generate(500, (index) {
    final elementsList = ['Fire', 'Water', 'Lightning', 'Dark'];
    final rolesList = ['DPS', 'Support', 'Striker', 'Assassin', 'Mage', 'Tank'];
    final imagesList = [
      'assets/charactercard/Kaelan.jpg',
      'assets/charactercard/water.jpg',
      'assets/charactercard/fireboy.jpg',
      'assets/charactercard/Nyx.jpg',
    ];
    final elem = elementsList[index % elementsList.length];
    final role = rolesList[index % rolesList.length];
    final img = imagesList[index % imagesList.length];
    return {
      'name': 'Hero #${index + 1} - Vanguard Specialist of the Order',
      'element': elem,
      'role': role,
      'imageUrl': img,
    };
  });

  final List<Map<String, String>> _longTextCharacters = [
    {
      'name': 'Archmage Valerius Ignis Highflame the Third Commander of the Elemental Citadel and Guardian of the Eternal Sacred Spark of Eldoria',
      'element': 'Fire',
      'role': 'Grand Mage DPS',
      'imageUrl': 'assets/charactercard/fireboy.jpg'
    },
    {
      'name': 'Princess Aurelia Hydroina Tidecaller Empress of the Seven Oceanic Realm Waters and Protector of Abyssal Sanctuary Depths',
      'element': 'Water',
      'role': 'Supreme Support',
      'imageUrl': 'assets/charactercard/water.jpg'
    },
    {
      'name': 'Lord Kaelen Stormbringer Thunderbolt Master of High Voltage Lightning and Harbinger of Tempestuous Cataclysms',
      'element': 'Lightning',
      'role': 'Striker Vanguard',
      'imageUrl': 'assets/charactercard/Kaelan.jpg'
    },
    {
      'name': 'Shadowblade Nyx Umbra Soulreaper Sovereign of Nightfall Realm and Whisperer of Void Darkness',
      'element': 'Dark',
      'role': 'Shadow Assassin',
      'imageUrl': 'assets/charactercard/Nyx.jpg'
    },
  ];

  List<Map<String, String>> get _activeSourceList {
    switch (_datasetMode) {
      case TestDatasetMode.standard:
        return _standardCharacters;
      case TestDatasetMode.longList:
        return _500Characters;
      case TestDatasetMode.longText:
        return _longTextCharacters;
      case TestDatasetMode.empty:
        return const [];
    }
  }

  List<Map<String, String>> get _filteredCharacters {
    return _activeSourceList.where((char) {
      final matchesSearch = char['name']!.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesElement = _selectedElement == 'All' || char['element'] == _selectedElement;
      return matchesSearch && matchesElement;
    }).toList();
  }

  Color _getElementColor(String element) {
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
        return const Color(0xFFEAB308);
    }
  }

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
        return Icons.grid_view_rounded;
    }
  }

  void _showCharacterDetail(Map<String, String> char) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final element = char['element'] ?? 'Fire';
    final role = char['role'] ?? 'Hero';
    final name = char['name'] ?? '';
    final elementColor = _getElementColor(element);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? const Color(0xFF0F172A) : Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: elementColor.withOpacity(0.5), width: 1.5),
        ),
        contentPadding: EdgeInsets.zero,
        content: SizedBox(
          width: 420,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                        child: Image.asset(
                          char['imageUrl'] ?? '',
                          fit: BoxFit.cover,
                          cacheWidth: 600,
                          errorBuilder: (_, __, ___) => Container(
                            color: elementColor.withOpacity(0.2),
                            child: Icon(Icons.shield, size: 64, color: elementColor),
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.85),
                            ],
                            stops: const [0.4, 1.0],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFD97706), Color(0xFFFBBF24)],
                          ),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [BoxShadow(color: Colors.black45, blurRadius: 4)],
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star, size: 12, color: Colors.white),
                            SizedBox(width: 4),
                            Text(
                              'MYTHIC ★★★★★',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 12,
                      left: 16,
                      right: 16,
                      child: Text(
                        name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: elementColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: elementColor, width: 1),
                            ),
                            child: Text(
                              'ELEMENT: ${element.toUpperCase()}',
                              style: TextStyle(
                                color: elementColor,
                                fontWeight: FontWeight.w800,
                                fontSize: 11,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isDark ? const Color(0xFF334155) : const Color(0xFFCBD5E1),
                              ),
                            ),
                            child: Text(
                              'ROLE: ${role.toUpperCase()}',
                              style: TextStyle(
                                color: isDark ? const Color(0xFFCBD5E1) : const Color(0xFF334155),
                                fontWeight: FontWeight.w800,
                                fontSize: 11,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'COMBAT STATS ARCHIVE',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                          color: isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8),
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _buildStatBar('ATK POWER', 0.88, const Color(0xFFEF4444), isDark),
                      const SizedBox(height: 8),
                      _buildStatBar('MAX HEALTH', 0.76, const Color(0xFF22C55E), isDark),
                      const SizedBox(height: 8),
                      _buildStatBar('CRIT RATE', 0.65, const Color(0xFFEAB308), isDark),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0, bottom: 12.0),
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFFEAB308),
              ),
              child: const Text('CLOSE ARCHIVE', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatBar(String label, double value, Color color, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
              ),
            ),
            Text(
              '${(value * 100).toInt()}%',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w900,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: value,
            minHeight: 6,
            backgroundColor: isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, bool isSelected, bool isDark, VoidCallback onTap) {
    const activeColor = Color(0xFFEAB308);
    return Material(
      color: Colors.transparent,
      child: ListTile(
        onTap: onTap,
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        tileColor: isSelected ? activeColor.withOpacity(0.2) : Colors.transparent,
        leading: Icon(icon, size: 20, color: isSelected ? activeColor : (isDark ? Colors.white70 : Colors.black87)),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w900 : FontWeight.w600,
            color: isSelected ? activeColor : (isDark ? Colors.white : Colors.black87),
          ),
        ),
      ),
    );
  }

  Widget _buildSmallDrawerItem(IconData icon, String title, bool isDark, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        onTap: onTap,
        dense: true,
        visualDensity: VisualDensity.compact,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        leading: Icon(icon, size: 16, color: isDark ? Colors.white54 : Colors.black54),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white60 : Colors.black54,
          ),
        ),
      ),
    );
  }

  Widget _buildDatasetSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SegmentedButton<TestDatasetMode>(
          style: ButtonStyle(
            visualDensity: VisualDensity.compact,
            side: WidgetStateProperty.all(
              const BorderSide(color: Color(0xFFEAB308), width: 1),
            ),
          ),
          segments: const [
            ButtonSegment(
              value: TestDatasetMode.standard,
              label: Text('Std (4)', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
              icon: Icon(Icons.shield, size: 12),
            ),
            ButtonSegment(
              value: TestDatasetMode.longList,
              label: Text('500 Items', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
              icon: Icon(Icons.format_list_numbered, size: 12),
            ),
            ButtonSegment(
              value: TestDatasetMode.longText,
              label: Text('Long Text', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
              icon: Icon(Icons.text_fields, size: 12),
            ),
            ButtonSegment(
              value: TestDatasetMode.empty,
              label: Text('Empty (0)', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
              icon: Icon(Icons.search_off, size: 12),
            ),
          ],
          selected: {_datasetMode},
          onSelectionChanged: (newSelection) {
            setState(() {
              _datasetMode = newSelection.first;
            });
          },
        ),
      ),
    );
  }

  final String _bgImagePath = 'assets/charactercard/background.jpg';

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredCharacters;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final activeElementColor = _getElementColor(_selectedElement);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.shield_rounded, size: 22, color: Color(0xFFEAB308)),
            SizedBox(width: 10),
            Text(
              'HERO CODEX',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                letterSpacing: 1.8,
                fontSize: 18,
              ),
            ),
          ],
        ),
        actions: [
          if (widget.onToggleTheme != null)
            IconButton(
              icon: Icon(
                widget.isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                color: const Color(0xFFEAB308),
              ),
              tooltip: 'Toggle Theme',
              onPressed: widget.onToggleTheme,
            ),
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu_rounded, color: Color(0xFFEAB308), size: 26),
              tooltip: 'Menu Sidebar',
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
      ),
      // Right Sliding Sidebar (Drawer) with Frosted Glass Blur Background
      endDrawer: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Drawer(
          width: 280,
          backgroundColor: isDark
              ? const Color(0xFF0F172A).withOpacity(0.85)
              : Colors.white.withOpacity(0.88),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(24)),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Header: Logo + Character Codex Title
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEAB308).withOpacity(0.2),
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFFEAB308), width: 1.5),
                        ),
                        child: const Icon(Icons.shield_rounded, size: 24, color: Color(0xFFEAB308)),
                      ),
                      const SizedBox(width: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CHARACTER CODEX',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.2,
                              color: Color(0xFFEAB308),
                            ),
                          ),
                          Text(
                            'ARCHIVES & DATABASE',
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Divider(color: (isDark ? Colors.white24 : Colors.black12), thickness: 1),
                  const SizedBox(height: 12),
                  // Main Navigation Items: Home, Trending, Updates, Saved, History
                  _buildDrawerItem(Icons.home_rounded, 'Home', true, isDark, () => Navigator.pop(context)),
                  _buildDrawerItem(Icons.whatshot_rounded, 'Trending', false, isDark, () => Navigator.pop(context)),
                  _buildDrawerItem(Icons.bolt_rounded, 'Updates', false, isDark, () => Navigator.pop(context)),
                  _buildDrawerItem(Icons.bookmark_rounded, 'Saved', false, isDark, () => Navigator.pop(context)),
                  _buildDrawerItem(Icons.history_rounded, 'History', false, isDark, () => Navigator.pop(context)),
                  
                  const Spacer(),
                  
                  Divider(color: (isDark ? Colors.white24 : Colors.black12), thickness: 1),
                  const SizedBox(height: 8),
                  // Bottom Smaller Items: Settings & More
                  _buildSmallDrawerItem(Icons.settings_rounded, 'Settings', isDark, () => Navigator.pop(context)),
                  _buildSmallDrawerItem(Icons.info_outline_rounded, 'More', isDark, () => Navigator.pop(context)),
                  const SizedBox(height: 12),
                  Center(
                    child: Text(
                      'v2.4.0 • RPG Codex Edition',
                      style: TextStyle(
                        fontSize: 10,
                        color: isDark ? Colors.white38 : Colors.black38,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              _bgImagePath,
              fit: BoxFit.cover,
              alignment: Alignment.center,
              errorBuilder: (_, __, ___) => const SizedBox.shrink(),
            ),
          ),
          Positioned.fill(
            child: Container(
              color: isDark
                  ? const Color(0xFF090C15).withOpacity(0.45)
                  : const Color(0xFFF6F3EC).withOpacity(0.50),
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Custom Header Section: Title, SearchBar & Filter Button side-by-side
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF101726).withOpacity(0.92) : Colors.white.withOpacity(0.92),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isDark ? const Color(0xFF26334D) : const Color(0xFFE2E8F0),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: isDark ? Colors.black.withOpacity(0.3) : Colors.black.withOpacity(0.06),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'CHARACTER ARCHIVES',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFFEAB308),
                              letterSpacing: 1.2,
                            ),
                          ),
                          Text(
                            '${filtered.length} HEROES',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // ROW: SearchBar on Left + Filter Button on Right
                      Row(
                        children: [
                          // Search Input Field
                          Expanded(
                            child: TextField(
                              controller: TextEditingController(text: _searchQuery)
                                ..selection = TextSelection.fromPosition(
                                  TextPosition(offset: _searchQuery.length),
                                ),
                              onChanged: (val) => setState(() => _searchQuery = val),
                              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                              decoration: InputDecoration(
                                hintText: 'Search hero name or class...',
                                hintStyle: TextStyle(
                                  fontSize: 12,
                                  color: isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8),
                                ),
                                prefixIcon: const Icon(
                                  Icons.search_rounded,
                                  color: Color(0xFFEAB308),
                                  size: 18,
                                ),
                                suffixIcon: _searchQuery.isNotEmpty
                                    ? IconButton(
                                        icon: const Icon(Icons.cancel_rounded, size: 16),
                                        onPressed: () => setState(() => _searchQuery = ''),
                                      )
                                    : null,
                                isDense: true,
                                filled: true,
                                fillColor: isDark ? const Color(0xFF1B2436) : const Color(0xFFF8FAFC),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: isDark ? const Color(0xFF334155) : const Color(0xFFCBD5E1),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Color(0xFFEAB308),
                                    width: 1.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Filter Menu Button beside SearchBar (Pops open Filter Choices)
                          Material(
                            color: Colors.transparent,
                            child: PopupMenuButton<String>(
                              onSelected: (element) {
                                setState(() {
                                  _selectedElement = element;
                                });
                              },
                              tooltip: 'Filter Element',
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                                side: BorderSide(color: activeElementColor, width: 1.5),
                              ),
                              color: isDark ? const Color(0xFF0F172A) : Colors.white,
                              elevation: 8,
                              itemBuilder: (context) {
                                return _elements.map((element) {
                                  final isSelected = element == _selectedElement;
                                  final elemColor = _getElementColor(element);
                                  final elemIcon = _getElementIcon(element);

                                  return PopupMenuItem<String>(
                                    value: element,
                                    child: Row(
                                      children: [
                                        Icon(elemIcon, size: 18, color: elemColor),
                                        const SizedBox(width: 10),
                                        Text(
                                          element.toUpperCase(),
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: isSelected ? FontWeight.w900 : FontWeight.w600,
                                            color: isSelected ? elemColor : (isDark ? Colors.white : Colors.black87),
                                          ),
                                        ),
                                        if (isSelected) ...[
                                          const Spacer(),
                                          Icon(Icons.check_circle_rounded, size: 16, color: elemColor),
                                        ],
                                      ],
                                    ),
                                  );
                                }).toList();
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 180),
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                decoration: BoxDecoration(
                                  color: activeElementColor.withOpacity(isDark ? 0.25 : 0.15),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: activeElementColor, width: 1.5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: activeElementColor.withOpacity(0.25),
                                      blurRadius: 6,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(_getElementIcon(_selectedElement), size: 16, color: activeElementColor),
                                    const SizedBox(width: 6),
                                    Text(
                                      _selectedElement.toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w900,
                                        color: activeElementColor,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Icon(Icons.arrow_drop_down_rounded, size: 18, color: activeElementColor),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Dataset Mode Selector Pill Row
                _buildDatasetSelector(),
                const SizedBox(height: 4),
                // Main Hero Grid Area taking center stage!
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final width = constraints.maxWidth;
                      final crossAxisCount = width < 360
                          ? 1
                          : (width < 600
                              ? 2
                              : (width < 900 ? 3 : (width < 1200 ? 4 : 5)));
                      final childAspectRatio = width < 360 ? 0.90 : 0.78;

                      return filtered.isEmpty
                          ? RosterEmptyState(
                              onReset: () => setState(() {
                                _searchQuery = '';
                                _selectedElement = 'All';
                                _datasetMode = TestDatasetMode.standard;
                              }),
                            )
                          : GridView.builder(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                childAspectRatio: childAspectRatio,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 20,
                              ),
                              itemCount: filtered.length,
                              itemBuilder: (context, index) {
                                // Efek Abstrak RPG Codex: Asimetris Staggered Offset & Kemiringan Kartu
                                final isOdd = index % 2 == 1;
                                final tiltAngle = (index % 4 == 0)
                                    ? -0.025
                                    : ((index % 4 == 1)
                                        ? 0.020
                                        : ((index % 4 == 2) ? -0.015 : 0.025));
                                final verticalOffset = isOdd ? 10.0 : -6.0;

                                return Transform(
                                  alignment: Alignment.center,
                                  transform: Matrix4.identity()
                                    ..translate(0.0, verticalOffset)
                                    ..rotateZ(tiltAngle),
                                  child: CharacterCard(
                                    character: filtered[index],
                                    onTap: () => _showCharacterDetail(filtered[index]),
                                  ),
                                );
                              },
                            );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
