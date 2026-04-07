import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import '../models/house.dart';
import 'house_detail_screen.dart';

class NearbyHousesScreen extends StatefulWidget {
  const NearbyHousesScreen({
    super.key,
    required this.selectedHouse,
    required this.houses,
  });

  final House selectedHouse;
  final List<House> houses;

  @override
  State<NearbyHousesScreen> createState() => _NearbyHousesScreenState();
}

class _NearbyHousesScreenState extends State<NearbyHousesScreen> {
  static const Color _primaryColor = Color(0xFFE67E22);
  final Distance _distance = const Distance();

  late final List<_HouseDistance> _sorted;

  @override
  void initState() {
    super.initState();
    _sorted = _computeSorted();
  }

  List<_HouseDistance> _computeSorted() {
    final center = LatLng(widget.selectedHouse.latitude, widget.selectedHouse.longitude);

    final list = widget.houses.map((h) {
      final dMeters = _distance(
        center,
        LatLng(h.latitude, h.longitude),
      );
      return _HouseDistance(house: h, meters: dMeters.toDouble());
    }).toList();

    list.sort((a, b) {
      // Keep selected house first.
      if (a.house.id == widget.selectedHouse.id) return -1;
      if (b.house.id == widget.selectedHouse.id) return 1;
      return a.meters.compareTo(b.meters);
    });

    return list;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final grayText = Colors.grey[700];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
        titleSpacing: 16,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nearby rentals',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'Near: ${widget.selectedHouse.fullLocation}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        physics: const BouncingScrollPhysics(),
        itemCount: _sorted.length,
        itemBuilder: (context, index) {
          final item = _sorted[index];
          final house = item.house;

          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _NearbyHouseCard(
              house: house,
              distanceMeters: item.meters,
              primaryColor: _primaryColor,
              grayText: grayText,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HouseDetailScreen(house: house),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _HouseDistance {
  final House house;
  final double meters;

  const _HouseDistance({
    required this.house,
    required this.meters,
  });
}

class _NearbyHouseCard extends StatelessWidget {
  const _NearbyHouseCard({
    required this.house,
    required this.distanceMeters,
    required this.primaryColor,
    required this.grayText,
    required this.onTap,
  });

  final House house;
  final double distanceMeters;
  final Color primaryColor;
  final Color? grayText;
  final VoidCallback onTap;

  String _formatDistance(double meters) {
    final km = meters / 1000.0;
    if (km < 1) {
      return '${meters.toStringAsFixed(0)} m away';
    }
    return '${km.toStringAsFixed(km < 10 ? 1 : 0)} km away';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        elevation: 0,
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
        color: Colors.grey[50],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero image 16:9-ish
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.asset(
                house.images.first,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          house.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor.withValues(alpha: 0.10),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Text(
                          _formatDistance(distanceMeters),
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
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
                      Icon(Icons.bed_outlined, size: 16, color: grayText),
                      const SizedBox(width: 4),
                      Text('${house.bedrooms} Beds',
                          style: TextStyle(color: grayText, fontSize: 12)),
                      const SizedBox(width: 12),
                      Icon(Icons.bathtub_outlined, size: 16, color: grayText),
                      const SizedBox(width: 4),
                      Text('${house.bathrooms} Baths',
                          style: TextStyle(color: grayText, fontSize: 12)),
                      const SizedBox(width: 12),
                      Icon(Icons.square_foot, size: 16, color: grayText),
                      const SizedBox(width: 4),
                      Text('${house.sizeM2} m²',
                          style: TextStyle(color: grayText, fontSize: 12)),
                    ],
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

