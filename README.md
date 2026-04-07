#+#+#+#+## KWANU — Malawi Rentals (Flutter)

Kwanu is a modern, minimal real estate mobile app focused on **rental listings in Malawi**. The UI is intentionally clean and professional: light/neutral backgrounds, flat surfaces (no heavy shadows), consistent spacing, and a warm orange accent pulled from the Kwanu logo.

This repository is currently in the **UI + navigation + local demo data** phase. The intent is to finalize the core flows and screens first, then plug in real authentication and a database (Firebase is on the TODO list).

---

## What’s implemented so far (current behavior)

### 1) Feed (Houses Listing)
The main experience is a rentals feed showing property cards with:

- Swipeable image carousel
- Property title + location (area + city)
- Price displayed in **Malawian Kwacha (MWK)** formatted as: `MWK 450,000 / month`
- Details row: Beds • Baths • Size in **m²**
- A heart icon to add/remove favourites
- A **“Check availability”** button (demo action)

The feed also includes:

- A search bar at the top (text filtering)
- Category chips (e.g., Houses, Apartments, Studios…)
- A consistent grey background so the property cards look clean and “premium”

Key file:
- `lib/screens/houses_list_screen.dart`

---

### 2) Favourites
Users can favourite a home by tapping the heart icon on a listing card.

The **Favourites** tab supports two states:

1. **Empty state**: a clean illustration + explanation + CTA button.
2. **List state**: shows favourited homes and enables the Sort / Filter / Compare controls.

This screen is designed to feel distinct from the feed (so it does not look like a duplicate list page).

Key files:
- Favourites UI is part of: `lib/screens/houses_list_screen.dart`
- House favourite state is stored inside the `House` model (`isFavorite`).

---

### 3) Map Search (OpenStreetMap via flutter_map)
The app includes a map-based search experience. It uses **OpenStreetMap tiles** through the `flutter_map` package.

On the map screen:

- A search header sits above the map.
- Typing shows **type-ahead suggestions** (like a search engine) based on the local houses dataset.
- Markers represent houses. Tapping a marker opens “nearby rentals” (see below).

Key file:
- `lib/screens/map_screen.dart`

Dependencies:
- `flutter_map`
- `latlong2`

---

### 4) Nearby rentals (sorted by proximity)
When a user taps a **house marker** on the map, or taps a **suggestion** in the search dropdown, the app navigates to a “Nearby rentals” screen.

That screen:

- Pins the selected house to the top
- Sorts all other houses by distance from the selected house (nearest first)
- Displays distance badges like `850 m away` or `2.4 km away`

Distance is calculated using `latlong2.Distance()`.

Key file:
- `lib/screens/nearby_houses_screen.dart`

---

### 5) Profile + Edit Profile UI
There is a Profile area and an Edit Profile screen. The Edit Profile screen was refined to match the app’s neutral palette and orange accent (to keep visual uniformity).

Key file:
- `lib/screens/edit_profile_screen.dart`

---

## Data model (current)
Listings are currently **static demo data** defined in code.

The core model is:
- `lib/models/house.dart`

Each `House` contains:

- `id`
- `title`
- `city`
- `area`
- `latitude`, `longitude`
- `priceMwk`
- `bedrooms`, `bathrooms`
- `sizeM2`
- `images` (list of asset paths)
- `isFavorite`

The formatted price is exposed through:
- `House.formattedPrice` → `MWK X / month`

---

## Search suggestion logic (SEO-like matching)
Search suggestions on the map screen are powered locally (no web API yet). The logic is designed to feel “search engine friendly”:

- Case-insensitive
- Ignores punctuation
- Collapses extra spaces
- Token-based matching (all tokens must match, e.g. “area 47”)
- Suggestions are ranked by a simple score (exact/prefix/token coverage)

Key file:
- `lib/utils/search_normalization.dart`

---

## Assets
House images are stored under:

- `assets/images/houses/`

Logo:

- `assets/logo/logo.png`

If you see:
> “Unable to load asset”

it usually means the filename in code does not exactly match the filename on disk (including spaces/case/extra extensions).

---

## How navigation currently works (high-level)
The app uses standard Flutter navigation with `Navigator.push(...)`.

Important routes/flows:

- Feed → Map: triggered by Map buttons / map actions.
- Map marker tap → Nearby rentals screen.
- Nearby rental card tap → House detail screen.
- Profile → Edit Profile screen.

---

## Running the project

### Install dependencies

```bash
flutter pub get
```

### Run

```bash
flutter run
```

### Analyze (recommended)

```bash
flutter analyze
```

---

## Known limitations / TODO

### Authentication + database
Auth is currently UI/demo logic. Planned next step:

- Firebase Authentication
  - Google sign-in
  - Phone number verification (SMS)
  - Email verification
- Firestore for user profiles and saved homes

### Real listings
Listings are currently static in code. Planned:

- Fetch homes from Firestore or a custom backend
- Add pagination/lazy loading

### Search improvements
Current search is local-only. Planned:

- Add geocoding/autocomplete (OpenStreetMap Nominatim or a paid geocoding API)
- Let users search by neighborhoods/points-of-interest

---

## Developer notes (why it’s built this way)
We are intentionally building the application in layers:

1. Finalize UI layout, spacing, and navigation.
2. Lock-in core flows (feed → map → nearby results, favourites, profile).
3. Introduce authentication and database once the UX is stable.

This approach prevents the project from getting blocked by backend details while the product design is still evolving.
