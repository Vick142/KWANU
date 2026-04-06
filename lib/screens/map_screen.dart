import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../models/house.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key, required this.houses});

  final List<House> houses;

  static const Color _accentColor = Color(0xFFE67E22);

  @override
  Widget build(BuildContext context) {
    final center = _calculateCenter(houses) ?? const LatLng(-13.9626, 33.7741);

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
      body: FlutterMap(
        options: MapOptions(
          initialCenter: center,
          initialZoom: 11,
          interactionOptions: const InteractionOptions(
            flags: InteractiveFlag.all,
          ),
          onTap: (_, __) => FocusManager.instance.primaryFocus?.unfocus(),
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.kwanu.app',
          ),
          MarkerLayer(
            markers: houses
                .map(
                  (h) => Marker(
                    point: LatLng(h.latitude, h.longitude),
                    width: 44,
                    height: 44,
                    child: GestureDetector(
                      onTap: () {
                        _showHouseSheet(context, h);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: _accentColor, width: 2),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.home_outlined,
                            color: _accentColor,
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
    );
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

  void _showHouseSheet(BuildContext context, House house) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  house.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  house.fullLocation,
                  style: TextStyle(color: Colors.grey[700]),
                ),
                const SizedBox(height: 10),
                Text(
                  house.formattedPrice,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: _accentColor,
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: _accentColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text('View details'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

