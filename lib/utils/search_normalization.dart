String normalizeQuery(String input) {
  final lower = input.toLowerCase().trim();
  // Replace any non letter/number with space, then collapse whitespace.
  final cleaned = lower.replaceAll(RegExp(r'[^a-z0-9\s]'), ' ');
  return cleaned.replaceAll(RegExp(r'\s+'), ' ').trim();
}

String houseSearchText({
  required String title,
  required String city,
  required String area,
}) {
  return normalizeQuery('$title $area $city');
}

bool houseMatchesQuery({
  required String normalizedQuery,
  required String normalizedHouseText,
}) {
  if (normalizedQuery.isEmpty) return true;
  final tokens = normalizedQuery.split(' ').where((t) => t.isNotEmpty);
  for (final t in tokens) {
    if (!normalizedHouseText.contains(t)) return false;
  }
  return true;
}

int suggestionScore({
  required String normalizedQuery,
  required String normalizedHouseText,
}) {
  if (normalizedQuery.isEmpty) return 0;
  if (normalizedHouseText == normalizedQuery) return 1000;
  if (normalizedHouseText.startsWith(normalizedQuery)) return 700;
  if (normalizedHouseText.contains(' $normalizedQuery')) return 600;

  // token coverage score
  final tokens = normalizedQuery.split(' ').where((t) => t.isNotEmpty).toList();
  int matched = 0;
  for (final t in tokens) {
    if (normalizedHouseText.contains(t)) matched++;
  }
  return matched * 100;
}

