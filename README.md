# Kwanu (Malawi Rentals) (Flutter)

Kwanu is a Flutter mobile app focused on rental listings in Malawi.
The goal is to keep things simple, clean UI, straightforward navigation, and fast browsing of houses.

Right now the project is still in the **UI + local data** stage. I'm focusing on getting the core screens and flows right before wiring it up to authentication and a backend (likely Firebase).



## What’s working so far

### Feed (Listings)

The main screen shows rental properties in a scrollable feed. Each card includes:

* Swipeable images
* Title and location
* Price in MWK per month
* Beds, baths, and size
* Favourite button
* "Check availability" (demo action)

There’s also:

* A search bar
* Category chips
* Clean neutral background for readability

File:

```
lib/screens/houses_list_screen.dart
```

---

### Favourites

You can favourite a house from the feed.

The favourites tab has:

* Empty state when nothing is saved
* List view when houses are added

Favourite state is stored inside the `House` model.

---

### Map Search

There’s a map screen built using OpenStreetMap (`flutter_map`).

Features:

* Search bar above the map
* Type-ahead suggestions from local data
* Markers for houses
* Tap marker → view nearby rentals

File:

```
lib/screens/map_screen.dart
```

---

### Nearby Rentals

When a house is selected from the map, the app shows nearby listings sorted by distance.

* Selected house appears first
* Others sorted by proximity
* Distance badges (e.g. 850 m, 2.4 km)

Distance calculation uses `latlong2`.

File:

```
lib/screens/nearby_houses_screen.dart
```

---

### Profile

Basic profile screen + edit profile UI.

File:

```
lib/screens/edit_profile_screen.dart
```

---

## Data Model

Listings are currently static demo data.

Model:

```
lib/models/house.dart
```

Each house includes:

* id
* title
* city / area
* latitude / longitude
* price (MWK)
* bedrooms / bathrooms
* size
* images
* isFavorite

---

## Search

Search suggestions are local (no API yet).
It supports:

* case-insensitive search
* token matching
* simple ranking

File:

```
lib/utils/search_normalization.dart
```

---

## Assets

Images:

```
assets/images/houses/
```

Logo:

```
assets/logo/logo.png
```

If assets fail to load, double-check filename spelling and case.

---

## Running the project

Install dependencies:

```bash
flutter pub get
```

Run:

```bash
flutter run
```

Optional:

```bash
flutter analyze
```

---

## Planned next steps

* Firebase authentication
* Firestore database
* Real listings instead of static data
* Pagination / lazy loading
* Better search (geocoding + locations)

---

## Notes

The project is being built in stages:

1. UI and navigation
2. Core flows (feed, map, favourites, profile)
3. Backend integration

This keeps things flexible while the design is still evolving.
