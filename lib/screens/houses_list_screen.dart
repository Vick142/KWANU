import 'package:flutter/material.dart';
import '../models/house.dart';
import 'house_detail_screen.dart';
import 'more_screen.dart';
import 'map_screen.dart';
import 'edit_profile_screen.dart';

class HousesListScreen extends StatefulWidget {
  const HousesListScreen({super.key});

  @override
  State<HousesListScreen> createState() => _HousesListScreenState();
}

class _HousesListScreenState extends State<HousesListScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  String _searchQuery = '';

  final List<String> _categories = const [
    'All',
    'Apartments',
    'Houses',
    'Studios',
    'Rooms',
    'Luxury',
  ];

  String _selectedCategory = 'All';

  // Expanded static dummy data for Malawi rentals, using real asset filenames
  late List<House> _houses = [
    const House(
      id: 'house_1',
      title: 'Modern 3 Bedroom House',
      city: 'Lilongwe',
      area: 'Area 47',
      latitude: -13.9894,
      longitude: 33.7826,
      priceMwk: 450000,
      bedrooms: 3,
      bathrooms: 2,
      sizeM2: 180,
      images: [
        'assets/images/houses/house 1.jpg',
        'assets/images/houses/house1a.jpg',
        'assets/images/houses/house1b.jpg',
      ],
    ),
    const House(
      id: 'house_2',
      title: 'Cozy 2 Bedroom Apartment',
      city: 'Lilongwe',
      area: 'Area 4',
      latitude: -13.9650,
      longitude: 33.7879,
      priceMwk: 280000,
      bedrooms: 2,
      bathrooms: 1,
      sizeM2: 95,
      images: [
        'assets/images/houses/house 2.jpg.jpg',
        'assets/images/houses/house2a.jpg',
      ],
    ),
    const House(
      id: 'house_3',
      title: 'Family House with Yard',
      city: 'Blantyre',
      area: 'Chilomoni',
      latitude: -15.7862,
      longitude: 35.0082,
      priceMwk: 320000,
      bedrooms: 3,
      bathrooms: 2,
      sizeM2: 160,
      images: [
        'assets/images/houses/house5.jpg',
        'assets/images/houses/house5a.jpg',
        'assets/images/houses/house5b.jpg',
      ],
    ),
    const House(
      id: 'house_4',
      title: 'Student Studio near Campus',
      city: 'Mzuzu',
      area: 'Area 4',
      latitude: -11.4593,
      longitude: 34.0200,
      priceMwk: 120000,
      bedrooms: 1,
      bathrooms: 1,
      sizeM2: 40,
      images: [
        'assets/images/houses/house15.jpg',
        'assets/images/houses/house15a.jpg',
        'assets/images/houses/house15b.jpg',
        'assets/images/houses/house15c.jpg',
      ],
    ),
    const House(
      id: 'house_5',
      title: '3 Bedroom Townhouse',
      city: 'Lilongwe',
      area: 'Area 49',
      latitude: -14.0130,
      longitude: 33.7630,
      priceMwk: 380000,
      bedrooms: 3,
      bathrooms: 2,
      sizeM2: 170,
      images: [
        'assets/images/houses/house 3.jpg.jpg',
        'assets/images/houses/house 3a.jpg',
      ],
    ),
    const House(
      id: 'house_6',
      title: 'Modern Flat',
      city: 'Mzuzu',
      area: 'Luwinga',
      latitude: -11.4365,
      longitude: 34.0209,
      priceMwk: 220000,
      bedrooms: 2,
      bathrooms: 1,
      sizeM2: 85,
      images: [
        'assets/images/houses/house6.jpg',
        'assets/images/houses/house6a.jpg',
      ],
    ),
    const House(
      id: 'house_7',
      title: 'Compact 1 Bedroom Apartment',
      city: 'Blantyre',
      area: 'Soche',
      latitude: -15.7873,
      longitude: 35.0209,
      priceMwk: 180000,
      bedrooms: 1,
      bathrooms: 1,
      sizeM2: 55,
      images: [
        'assets/images/houses/house7.jpg',
        'assets/images/houses/house7a.jpg',
      ],
    ),
    const House(
      id: 'house_8',
      title: 'Spacious 4 Bedroom House',
      city: 'Lilongwe',
      area: 'Area 49',
      latitude: -14.0130,
      longitude: 33.7630,
      priceMwk: 520000,
      bedrooms: 4,
      bathrooms: 3,
      sizeM2: 230,
      images: [
        'assets/images/houses/house8.jpg',
        'assets/images/houses/house8a.jpg',
        'assets/images/houses/house8b.jpg',
      ],
    ),
    const House(
      id: 'house_9',
      title: '2 Bedroom Apartment',
      city: 'Lilongwe',
      area: 'Kawale',
      latitude: -13.9487,
      longitude: 33.7763,
      priceMwk: 210000,
      bedrooms: 2,
      bathrooms: 1,
      sizeM2: 80,
      images: [
        'assets/images/houses/house9.jpg',
        'assets/images/houses/house9a.jpg',
      ],
    ),
    const House(
      id: 'house_10',
      title: 'Family Home with Garden',
      city: 'Blantyre',
      area: 'Nyambadwe',
      latitude: -15.8070,
      longitude: 35.0302,
      priceMwk: 360000,
      bedrooms: 3,
      bathrooms: 2,
      sizeM2: 150,
      images: [
        'assets/images/houses/house10.jpg',
        'assets/images/houses/house10b.jpg',
        'assets/images/houses/house10c.jpg',
      ],
    ),
    const House(
      id: 'house_11',
      title: 'Studio Room in Shared House',
      city: 'Mzuzu',
      area: 'Chibavi',
      latitude: -11.4482,
      longitude: 34.0112,
      priceMwk: 90000,
      bedrooms: 1,
      bathrooms: 1,
      sizeM2: 30,
      images: [
        'assets/images/houses/house11a.jpg',
        'assets/images/houses/house 11.jpg.png',
      ],
    ),
    const House(
      id: 'house_12',
      title: 'High-end 3 Bedroom Apartment',
      city: 'Blantyre',
      area: 'Namiwawa',
      latitude: -15.7933,
      longitude: 35.0181,
      priceMwk: 650000,
      bedrooms: 3,
      bathrooms: 3,
      sizeM2: 200,
      images: [
        'assets/images/houses/house13.jpg',
        'assets/images/houses/house13a.jpg',
        'assets/images/houses/house13b.jpg',
        'assets/images/houses/house13c.jpg',
        'assets/images/houses/house13d.jpg',
      ],
    ),
  ];

  // Track current page index per house for dots
  final Map<String, int> _imagePageIndex = {};

  // Bottom nav indices:
  // 0 = Feed, 1 = Favourites, 2 = Messages, 3 = Profile
  int _currentBottomIndex = 0; // start on Feed

  bool get _isFavoritesTab => _currentBottomIndex == 1;
  bool get _isMessagesTab => _currentBottomIndex == 2;
  bool get _isProfileTab => _currentBottomIndex == 3;

  List<House> get _favoriteHouses =>
      _houses.where((h) => h.isFavorite).toList();


  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  List<House> get _filteredHouses {
    final q = _searchQuery.trim().toLowerCase();

    // Category filtering is kept lightweight and based on title keywords
    // to avoid changing the House model context.
    bool matchesCategory(House h) {
      if (_selectedCategory == 'All') return true;
      final t = h.title.toLowerCase();
      switch (_selectedCategory) {
        case 'Apartments':
          return t.contains('apartment') || t.contains('flat');
        case 'Houses':
          return t.contains('house');
        case 'Studios':
          return t.contains('studio');
        case 'Rooms':
          return t.contains('room');
        case 'Luxury':
          return t.contains('lux');
        default:
          return true;
      }
    }

    bool matchesQuery(House h) {
      if (q.isEmpty) return true;
      return h.title.toLowerCase().contains(q) ||
          h.city.toLowerCase().contains(q) ||
          h.area.toLowerCase().contains(q);
    }

    return _houses.where((h) => matchesCategory(h) && matchesQuery(h)).toList();
  }

  void _openMapSearch({String? queryOverride}) {
    // Ensure keyboard is dismissed before navigation.
    FocusManager.instance.primaryFocus?.unfocus();

    if (queryOverride != null && queryOverride.trim().isNotEmpty) {
      _searchController.text = queryOverride;
      _searchController.selection = TextSelection.fromPosition(
        TextPosition(offset: _searchController.text.length),
      );
      _searchQuery = queryOverride;
    }

    final houses = _filteredHouses;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MapScreen(houses: houses),
      ),
    );
  }

  void _toggleFavorite(House house) {
    setState(() {
      _houses = _houses.map((h) {
        if (h.id == house.id) {
          return h.copyWith(isFavorite: !h.isFavorite);
        }
        return h;
      }).toList();
    });

    final message = !house.isFavorite
        ? 'Added to favorites'
        : 'Removed from favorites';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _onStartSearching() {
    setState(() {
      _currentBottomIndex = 1; // switch to Search tab
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = const Color(0xFFE67E22); // from logo
    // Slightly darker neutral text for a more grey, professional look
    final grayText = Colors.grey[700];

    final bool hasFavorites = _favoriteHouses.isNotEmpty;

    Widget body;
    PreferredSizeWidget appBar;

    if (_isFavoritesTab) {
      appBar = _buildFavoritesAppBar(theme, hasFavorites);
      body = hasFavorites
          ? _buildFavoritesListBody(primaryColor, grayText)
          : _buildFavoritesEmptyBody(context);
    } else if (_isMessagesTab) {
      appBar = _buildMessagesAppBar(theme);
      body = _buildMessagesEmptyBody(theme);
    } else if (_isProfileTab) {
      appBar = _buildProfileAppBar(theme);
      body = _buildProfileBody(theme, primaryColor, grayText);
    } else {
      appBar = _buildDefaultAppBar(theme, grayText);
      body = _buildDefaultBody(primaryColor, grayText);
    }

    return Scaffold(
      // Slightly deeper neutral background so white cards sit cleanly on it
      backgroundColor: Colors.grey[100],
      appBar: appBar,
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentBottomIndex,
        onTap: (index) {
          setState(() {
            _currentBottomIndex = index;
          });
        },
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          // Index 0: Feed
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Feed',
          ),
          // Index 1: Favourites
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite),
            label: 'Favourites',
          ),
          // Index 2: Messages
          BottomNavigationBarItem(
            icon: Icon(Icons.message_outlined),
            activeIcon: Icon(Icons.message),
            label: 'Messages',
          ),
          // Index 3: Profile
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildFavoritesAppBar(
      ThemeData theme, bool hasFavorites) {
    return AppBar(
      backgroundColor: Colors.grey[100],
      elevation: 0,
      titleSpacing: 16,
      title: Text(
        'Favourites',
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        TextButton(
          onPressed: hasFavorites
              ? () {
                  // TODO: implement compare behaviour
                }
              : null,
          child: const Text('Compare'),
        ),
      ],
    );
  }

  PreferredSizeWidget _buildMessagesAppBar(ThemeData theme) {
    return AppBar(
      backgroundColor: Colors.grey[100],
      elevation: 0,
      titleSpacing: 16,
      title: Text(
        'Messages',
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  PreferredSizeWidget _buildProfileAppBar(ThemeData theme) {
    return AppBar(
      backgroundColor: Colors.grey[100],
      elevation: 0,
      titleSpacing: 16,
      title: Text(
        'Profile',
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  PreferredSizeWidget _buildDefaultAppBar(
      ThemeData theme, Color? grayText) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(72),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              // Logo
              Image.asset(
                'assets/logo/logo.png',
                height: 32,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Kwanu',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 16,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Lilongwe, Malawi',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: grayText,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  // Navigate to the dedicated More screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MoreScreen(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDefaultBody(Color primaryColor, Color? grayText) {
    return Column(
      children: [
        // Search bar (flat, no shadow)
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: Container(
            decoration: BoxDecoration(
              // very light grey instead of pure white to soften the UI
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(24),
            ),
            child: TextField(
              controller: _searchController,
              focusNode: _searchFocusNode,
              onChanged: (value) {
                setState(() => _searchQuery = value);
              },
              textInputAction: TextInputAction.search,
              onSubmitted: (_) {
                // If a user presses search on the keyboard, take them to the map
                // showing results around them / the filtered set.
                _openMapSearch();
              },
              decoration: InputDecoration(
                hintText:
                    'Search rentals in Lilongwe, Blantyre, Mzuzu',
                hintStyle: TextStyle(color: Colors.grey[500]),
                border: InputBorder.none,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.trim().isEmpty
                    ? IconButton(
                        tooltip: 'Map',
                        onPressed: _openMapSearch,
                        icon: const Icon(Icons.map_outlined),
                      )
                    : IconButton(
                        tooltip: 'Clear',
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                        icon: const Icon(Icons.close),
                      ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
          ),
        ),

        // Search mode actions (show after the search bar)
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _openMapSearch,
                  icon: const Icon(Icons.map_outlined, size: 18),
                  label: const Text('Map'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: primaryColor,
                    side: BorderSide(color: primaryColor.withValues(alpha: 0.6)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton.icon(
                  onPressed: () {
                    // "Search" keeps the user in text-search mode (list filtering).
                    // If keyboard isn't open yet, focus the search field.
                    _searchFocusNode.requestFocus();
                  },
                  icon: const Icon(Icons.search, size: 18),
                  label: const Text('Search'),
                  style: FilledButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Category chips
        SizedBox(
          height: 48,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final cat = _categories[index];
              final isSelected = cat == _selectedCategory;
              return ChoiceChip(
                label: Text(cat),
                selected: isSelected,
                onSelected: (_) {
                  setState(() => _selectedCategory = cat);
                },
                 selectedColor: primaryColor.withValues(alpha: 0.10),
                labelStyle: TextStyle(
                  color: isSelected ? primaryColor : grayText,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: isSelected
                        ? primaryColor.withValues(alpha: 0.4)
                        : Colors.grey.shade300,
                  ),
                ),
                 backgroundColor: Colors.grey[50],
                elevation: 0,
              );
            },
          ),
        ),

        const SizedBox(height: 8),

        // Property feed (filtered by category + query)
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            physics: const BouncingScrollPhysics(),
            itemCount: _filteredHouses.length,
            itemBuilder: (context, index) {
              final house = _filteredHouses[index];
              final pageIndex = _imagePageIndex[house.id] ?? 0;

              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _buildPropertyCard(
                  context: context,
                  house: house,
                  primaryColor: primaryColor,
                  grayText: grayText,
                  pageIndex: pageIndex,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFavoritesListBody(Color primaryColor, Color? grayText) {
    // This body is used when there ARE favourites
    return Column(
      children: [
        // Controls row: Sort / Filter (active when favourites exist)
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    // TODO: implement sort behaviour
                  },
                  icon: const Icon(Icons.sort, size: 18),
                  label: const Text('Sort'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    // TODO: implement filter behaviour
                  },
                  icon: const Icon(Icons.filter_list, size: 18),
                  label: const Text('Filter'),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Favourites list (no search bar or category chips)
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            physics: const BouncingScrollPhysics(),
            itemCount: _favoriteHouses.length,
            itemBuilder: (context, index) {
              final house = _favoriteHouses[index];
              final pageIndex = _imagePageIndex[house.id] ?? 0;

              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _buildPropertyCard(
                  context: context,
                  house: house,
                  primaryColor: primaryColor,
                  grayText: grayText,
                  pageIndex: pageIndex,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProfileBody(
    ThemeData theme,
    Color primaryColor,
    Color? grayText,
  ) {
    // Profile tab: just show the profile details card for now
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfileCard(theme, primaryColor, grayText),
        ],
      ),
    );
  }

  Widget _buildProfileCard(
    ThemeData theme,
    Color primaryColor,
    Color? grayText,
  ) {
    return Material(
      // Slightly off-white to sit better on grey background
      color: Colors.grey[50],
      elevation: 0, // flat profile card, no shadow
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const EditProfileScreen(
                fullName: 'Guest User',
                email: 'guest@kwanu.app',
                location: 'Lilongwe, Malawi',
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 24,
                backgroundColor: Color(0xFFE0E0E0),
                child: Icon(
                  Icons.person_outline,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Guest User',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Manage your account',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: grayText,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              FilledButton.tonal(
                style: FilledButton.styleFrom(
                  backgroundColor: primaryColor.withValues(alpha: 0.08),
                  foregroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  textStyle: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const EditProfileScreen(
                        fullName: 'Guest User',
                        email: 'guest@kwanu.app',
                        location: 'Lilongwe, Malawi',
                      ),
                    ),
                  );
                },
                child: const Text('Edit Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMoreActionsGrid(
    ThemeData theme,
    Color primaryColor,
    Color? grayText,
  ) {
    final items = [
      MoreAction(
        icon: Icons.chat_bubble_outline,
        label: 'Customer Support',
        onTap: () {
          // TODO: open support/help screen
        },
      ),
      MoreAction(
        icon: Icons.settings_outlined,
        label: 'Settings',
        onTap: () {
          // TODO: open settings screen
        },
      ),
      MoreAction(
        icon: Icons.visibility_off_outlined,
        label: 'Hidden Homes',
        onTap: () {
          // TODO: show hidden listings
        },
      ),
      MoreAction(
        icon: Icons.saved_search_outlined,
        label: 'Saved Searches',
        onTap: () {
          // TODO: show saved searches
        },
      ),
      MoreAction(
        icon: Icons.history,
        label: 'Recently Viewed',
        onTap: () {
          // TODO: show viewed listings
        },
      ),
      MoreAction(
        icon: Icons.add_home_outlined,
        label: 'Post a Rental Listing',
        onTap: () {
          // TODO: open listing creation flow
        },
      ),
      MoreAction(
        icon: Icons.attach_money,
        label: 'Rent vs Buy Calculator',
        onTap: () {
          // TODO: open calculator tool
        },
      ),
    ];

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.1,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return _MoreActionItem(
          action: item,
          primaryColor: primaryColor,
          grayText: grayText,
        );
      },
    );
  }

  Widget _buildFavoritesEmptyBody(BuildContext context) {
    final theme = Theme.of(context);
    final Color primaryColor = const Color(0xFFE67E22);
    final Color? grayText = Colors.grey[600];

    return Column(
      children: [
        // Controls row: Sort / Filter
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: null, // inactive in empty state
                  icon: const Icon(Icons.sort, size: 18),
                  label: const Text('Sort'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: null, // inactive in empty state
                  icon: const Icon(Icons.filter_list, size: 18),
                  label: const Text('Filter'),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Illustration using icons
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.home_rounded,
                        size: 80,
                        color: Colors.orange.shade100,
                      ),
                      Positioned(
                        left: 0,
                        child: Icon(
                          Icons.home_rounded,
                          size: 52,
                          color: Colors.teal.shade100,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: Icon(
                          Icons.home_rounded,
                          size: 52,
                          color: Colors.blue.shade100,
                        ),
                      ),
                      Positioned(
                        top: 8,
                        child: Icon(
                          Icons.favorite,
                          size: 32,
                          color: Colors.pinkAccent,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Favourites',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap the heart on a home and it will appear here.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: grayText,
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                        ),
                      ),
                      onPressed: _onStartSearching,
                      child: const Text(
                        'Start Searching',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMessagesEmptyBody(ThemeData theme) {
    final Color? grayText = Colors.grey[500];

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Text(
          "You don't have any messages yet.",
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: grayText,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _buildPropertyCard({
    required BuildContext context,
    required House house,
    required Color primaryColor,
    required Color? grayText,
    required int pageIndex,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => HouseDetailScreen(house: house),
          ),
        );
      },
      child: Material(
        elevation: 0, // flat card: no shadow
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
        // Slightly off-white card on grey background
        color: Colors.grey[50],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image carousel with favorite icon
            Stack(
              children: [
                SizedBox(
                  height: 220,
                  width: double.infinity,
                  child: PageView.builder(
                    itemCount: house.images.length,
                    onPageChanged: (index) {
                      setState(() {
                        _imagePageIndex[house.id] = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      final imagePath = house.images[index];
                      return Hero(
                        tag: '${house.id}_image_$index',
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                          child: Image.asset(
                            imagePath,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: InkWell(
                    onTap: () => _toggleFavorite(house),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.35),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        house.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: house.isFavorite
                            ? Colors.redAccent
                            : Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Dots indicator
            if (house.images.length > 1)
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(house.images.length, (index) {
                    final isActive = index == pageIndex;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: isActive ? 10 : 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: isActive
                            ? primaryColor
                            : Colors.grey.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    );
                  }),
                ),
              ),

            Padding(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    house.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          house.fullLocation,
                          style: TextStyle(
                            color: grayText,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    house.formattedPrice,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.bed_outlined,
                        size: 16,
                        color: grayText,
                      ),
                      const SizedBox(width: 4),
                      Text('${house.bedrooms} Beds',
                          style: TextStyle(color: grayText, fontSize: 12)),
                      const SizedBox(width: 12),
                      Icon(
                        Icons.bathtub_outlined,
                        size: 16,
                        color: grayText,
                      ),
                      const SizedBox(width: 4),
                      Text('${house.bathrooms} Baths',
                          style: TextStyle(color: grayText, fontSize: 12)),
                      const SizedBox(width: 12),
                      Icon(
                        Icons.square_foot,
                        size: 16,
                        color: grayText,
                      ),
                      const SizedBox(width: 4),
                      Text('${house.sizeM2} m²',
                          style: TextStyle(color: grayText, fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Checking availability for \'${house.title}\' (demo)',
                            ),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                      child: const Text(
                        'Check availability',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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

class MoreAction {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const MoreAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });
}

class _MoreActionItem extends StatelessWidget {
  final MoreAction action;
  final Color primaryColor;
  final Color? grayText;

  const _MoreActionItem({
    required this.action,
    required this.primaryColor,
    required this.grayText,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 1.5,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: action.onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                action.icon,
                size: 28,
                color: primaryColor,
              ),
              const SizedBox(height: 12),
              Text(
                action.label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: grayText ?? Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
