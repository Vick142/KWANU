import 'package:flutter/material.dart';
import '../models/house.dart';

class HouseDetailScreen extends StatelessWidget {
  final House house;

  const HouseDetailScreen({super.key, required this.house});

  @override
  Widget build(BuildContext context) {
    final primaryColor = const Color(0xFFE67E22);
    final grayText = Colors.grey[600];

    return Scaffold(
      appBar: AppBar(
        title: Text(house.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Hero(
                tag: '${house.id}_image_0',
                child: Image.asset(
                  house.images.first,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    house.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined,
                          size: 18, color: Colors.grey),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          house.fullLocation,
                          style: TextStyle(color: grayText),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    house.formattedPrice,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(Icons.bed_outlined, size: 18, color: grayText),
                      const SizedBox(width: 4),
                      Text('${house.bedrooms} Beds',
                          style: TextStyle(color: grayText)),
                      const SizedBox(width: 16),
                      Icon(Icons.bathtub_outlined, size: 18, color: grayText),
                      const SizedBox(width: 4),
                      Text('${house.bathrooms} Baths',
                          style: TextStyle(color: grayText)),
                      const SizedBox(width: 16),
                      Icon(Icons.square_foot, size: 18, color: grayText),
                      const SizedBox(width: 4),
                      Text('${house.sizeM2} m²',
                          style: TextStyle(color: grayText)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    // For now, reuse title and location as a simple description.
                    '${house.title} located in ${house.fullLocation}. Beautiful rental home in Malawi.',
                    style: const TextStyle(fontSize: 14, height: 1.4),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Later: if user is not logged in, redirect to login.
                        // For now,it's just showing a placeholder.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Contact landlord feature coming soon'),
                          ),
                        );
                      },
                      icon: const Icon(Icons.message_outlined),
                      label: const Text('Contact Landlord'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
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

