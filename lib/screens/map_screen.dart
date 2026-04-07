import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../models/house.dart';
import '../utils/search_normalization.dart';
import 'nearby_houses_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, required this.houses});

  final List<House> houses;

  static const Color _accentColor = Color(0xFFE67E22);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  String _query = '';

  @override
  Widget build(BuildContext context) {
    final center = _calculateCenter(widget.houses) ??
        const LatLng(-13.9626, 33.7741); // Lilongwe-ish

    final suggestions = _buildSuggestions(_query);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
        titleSpacing: 16,
        title: const Text(
          'Search',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          // Header search bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(24),
              ),
              child: TextField(
                controller: _searchController,
                focusNode: _searchFocusNode,
                textInputAction: TextInputAction.search,
                onChanged: (value) {
                  setState(() {
                    _query = value;
                  });
                },
                onSubmitted: (_) {
                  // If they submit with a strong match, navigate to it.
                  if (suggestions.isNotEmpty) {
                    _openNearbyResults(suggestions.first);
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Search area, city, or property name',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  border: InputBorder.none,
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _query.trim().isEmpty
                      ? const Icon(Icons.tune, color: Colors.transparent)
                      : IconButton(
                          tooltip: 'Clear',
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _query = '');
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                        ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
              ),
            ),
          ),

          // Map + suggestions overlay
          Expanded(
            child: Stack(
              children: [
                FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: center,
                    initialZoom: 11,
                    interactionOptions: const InteractionOptions(
                      flags: InteractiveFlag.all,
                    ),
                    onTap: (tapPosition, point) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.kwanu.app',
                    ),
                    MarkerLayer(
                      markers: widget.houses
                          .map(
                            (h) => Marker(
                              point: LatLng(h.latitude, h.longitude),
                              width: 44,
                              height: 44,
                              child: GestureDetector(
                                onTap: () {
                                  _openNearbyResults(h);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: MapScreen._accentColor,
                                      width: 2,
                                    ),
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.home_outlined,
                                      color: MapScreen._accentColor,
                                      size: 22,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),

                if (_searchFocusNode.hasFocus && suggestions.isNotEmpty)
                  Positioned(
                    left: 16,
                    right: 16,
                    top: 12,
                    child: Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight: 280),
                        child: ListView.separated(
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          itemCount: suggestions.length,
                          separatorBuilder: (context, index) => const Divider(
                            height: 1,
                            color: Color(0xFFE0E0E0),
                          ),
                          itemBuilder: (context, index) {
                            final h = suggestions[index];
                            return ListTile(
                              dense: true,
                              title: Text(
                                h.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Text(
                                h.fullLocation,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: Text(
                                h.formattedPrice,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: MapScreen._accentColor,
                                ),
                              ),
                              onTap: () {
                                _openNearbyResults(h);
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  LatLng? _calculateCenter(List<House> houses) {
    if (houses.isEmpty) return null;
    double lat = 0;
    double lng = 0;
    for (final h in houses) {
      lat += h.latitude;
      lng += h.longitude;
    }
    return LatLng(lat / houses.length, lng / houses.length);
  }

  List<House> _buildSuggestions(String query) {
    final q = normalizeQuery(query);
    if (q.length < 2) return const [];

    final scored = <({House house, int score})>[];
    for (final h in widget.houses) {
      final text = houseSearchText(title: h.title, city: h.city, area: h.area);
      if (!houseMatchesQuery(normalizedQuery: q, normalizedHouseText: text)) {
        continue;
      }
      scored.add((house: h, score: suggestionScore(normalizedQuery: q, normalizedHouseText: text)));
    }

    scored.sort((a, b) => b.score.compareTo(a.score));
    return scored.take(8).map((e) => e.house).toList();
  }

  void _openNearbyResults(House selected) {
    FocusManager.instance.primaryFocus?.unfocus();

    // Center map smoothly on the selected house (nice UX), then navigate.
    _mapController.move(
      LatLng(selected.latitude, selected.longitude),
      13,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => NearbyHousesScreen(
          selectedHouse: selected,
          houses: widget.houses,
        ),
      ),
    );
  }
}

