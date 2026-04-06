import 'package:flutter/material.dart';

import 'houses_list_screen.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  static const Color _dividerColor = Color(0xFFE0E0E0);
  static const Color _iconColor = Color(0xFF9E9E9E);
  static const Color _labelColor = Color(0xFF616161);
  static const Color _accentColor = Color(0xFFE67E22);

  @override
  Widget build(BuildContext context) {
    final items = <_MoreItem>[
      const _MoreItem(
        icon: Icons.chat_bubble_outline,
        label: 'Customer Support',
      ),
      const _MoreItem(
        icon: Icons.settings_outlined,
        label: 'Settings',
      ),
      const _MoreItem(
        icon: Icons.visibility_off_outlined,
        label: 'Hidden Homes',
      ),
      const _MoreItem(
        icon: Icons.search_outlined,
        label: 'Saved Searches',
      ),
      const _MoreItem(
        icon: Icons.history,
        label: 'Recently Viewed',
      ),
      const _MoreItem(
        icon: Icons.home_work_outlined,
        label: 'Post a Rental Listing',
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        titleSpacing: 16,
        title: const Text(
          'More',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: _buildGrid(items),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildGrid(List<_MoreItem> items) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: _dividerColor, width: 0.5),
              right: BorderSide(color: _dividerColor, width: 0.5),
            ),
          ),
          child: InkWell(
            onTap: () {
              // TODO: navigate to concrete screens for each action
            },
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    item.icon,
                    size: 26,
                    color: _iconColor,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.label,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                      color: _labelColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 4,
      selectedItemColor: _accentColor,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        if (index == 4) return; // already on More
        if (index == 0 || index == 1 || index == 2 || index == 3) {
          // Navigate back to main houses list screen and let it handle tab index
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const HousesListScreen(),
            ),
          );
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Feed',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search_outlined),
          activeIcon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          activeIcon: Icon(Icons.favorite),
          label: 'Saves',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications_none),
          activeIcon: Icon(Icons.notifications),
          label: 'Alerts',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.more_horiz),
          activeIcon: Icon(Icons.more_horiz),
          label: 'More',
        ),
      ],
    );
  }
}

class _MoreItem {
  final IconData icon;
  final String label;

  const _MoreItem({required this.icon, required this.label});
}

