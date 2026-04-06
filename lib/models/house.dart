class House {
  final String id;
  final String title;
  final String city;
  final String area;
  final double latitude;
  final double longitude;
  final int priceMwk;
  final int bedrooms;
  final int bathrooms;
  final int sizeM2;
  final List<String> images;
  final bool isFavorite; // new field

  const House({
    required this.id,
    required this.title,
    required this.city,
    required this.area,
    required this.latitude,
    required this.longitude,
    required this.priceMwk,
    required this.bedrooms,
    required this.bathrooms,
    required this.sizeM2,
    required this.images,
    this.isFavorite = false,
  });

  House copyWith({
    bool? isFavorite,
  }) {
    return House(
      id: id,
      title: title,
      city: city,
      area: area,
      latitude: latitude,
      longitude: longitude,
      priceMwk: priceMwk,
      bedrooms: bedrooms,
      bathrooms: bathrooms,
      sizeM2: sizeM2,
      images: images,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  String get fullLocation => '$area, $city';

  String get formattedPrice => 'MWK ${_formatPrice(priceMwk)} / month';

  static String _formatPrice(int value) {
    final s = value.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      final reverseIndex = s.length - i;
      buffer.write(s[i]);
      if (reverseIndex > 1 && reverseIndex % 3 == 1) {
        buffer.write(',');
      }
    }
    return buffer.toString();
  }
}
