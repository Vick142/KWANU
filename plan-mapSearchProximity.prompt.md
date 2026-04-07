## Plan: MapScreen search + proximity results

Add a fixed search header above `FlutterMap` on `MapScreen`, with type-ahead suggestions from the in-memory `houses` list using normalized (SEO-like) matching. Selecting a suggestion (or tapping a marker) navigates to a new “Nearby results” screen that shows the selected house first, then nearby houses sorted by distance, reusing the existing property card UI from `HousesListScreen`. Implement this with minimal new state, clear data flow, and robust edge-case handling.

### Steps 1–5
1. Define normalization + matching utilities in a small helper (e.g., `normalizeQuery`, `houseSearchText`, token matching).
2. Convert `MapScreen` (`lib/screens/map_screen.dart`) to stateful: manage `TextEditingController`, focus, and suggestion list.
3. Build UI layout as a `Column`: search header (top) + `Expanded(FlutterMap)` (bottom), overlay suggestions panel.
4. Add navigation target `NearbyHousesScreen`: accept `selectedHouse`, `houses`, compute distance-sorted list, render with reused card widget.
5. Wire interactions: suggestion tap and marker tap both push `NearbyHousesScreen` with consistent selection + sorting.

### Further Considerations 1–3
1. Reuse card UI by extracting `_buildPropertyCard` into a shared widget file, or wrap via callback.
2. Decide matching behavior: prefix-only vs contains; title-only vs title+area+city.
3. Decide “nearby” limits: top N results and/or max radius (km) for performance and UX.

## Plan Details (what each step includes)

### 1) Normalization + search matching (SEO-like)
- **Goal:** Make search tolerant of casing, extra spaces, punctuation, and common formatting differences.
- **Where:** Create a reusable helper in something like `lib/utils/search_normalization.dart` (or similar).
- **Normalization rules (recommended):**
    - `trim`, `toLowerCase`
    - collapse whitespace to single spaces
    - remove punctuation/symbols (keep letters/numbers/spaces)
    - optionally strip diacritics (if you want true SEO-like behavior; otherwise keep simple ASCII normalization)
- **House searchable text (recommended):**
    - Concatenate `house.title`, `house.area`, `house.city` (and maybe bedroom count as text).
- **Matching strategy:**
    - Split normalized query into tokens; require all tokens to appear somewhere in the normalized house text (AND match).
    - Rank suggestions by:
        1) exact match of full normalized string (best)
        2) prefix matches (query starts a field)
        3) token count matched / earlier index
- **Edge cases:**
    - Empty query → no suggestions panel
    - Very short query (1 char) → either show none or show limited top suggestions to avoid noise
    - Duplicates (same title/area) → key suggestions by `house.id`

### 2) MapScreen state + data flow
- **Current:** `MapScreen` is `StatelessWidget` and marker tap calls `_showHouseSheet`.
- **Change:** Make `MapScreen` stateful to hold:
    - `TextEditingController searchController`
    - `FocusNode searchFocusNode`
    - `String query`
    - `List<House> suggestions` (derived; can be computed on change)
    - Optionally `House? highlightedHouse` (for temporarily emphasizing a marker / centering map)
- **Data flow:**
    - Input keystroke → update `query` → compute `suggestions` from `widget.houses` (already passed in from `HousesListScreen._openMapSearch`)
    - Suggestion selected → navigate to proximity results screen with `(selectedHouse, widget.houses)`
- **Don’t introduce global state** unless you already use Provider/Riverpod (none is evident from current files).

### 3) UI layout: search header above map + suggestions overlay
- **Layout in `MapScreen.build`:**
    - `Scaffold`
        - optional `AppBar` stays or can be removed if header acts as app bar replacement
        - `body: Column(`
            - `SearchHeader` container (fixed height, padding, background)
            - `Expanded(child: Stack(children: [FlutterMap, SuggestionsOverlay]))`
- **Search header contents:**
    - `TextField` similar styling to the main list screen’s search bar (see `lib/screens/houses_list_screen.dart` search field)
    - Leading search icon, trailing clear icon
    - Optional “Cancel”/back button to pop screen
- **Suggestions overlay:**
    - Show only when:
        - query not empty
        - suggestions not empty
        - and focus is in the text field (recommended)
    - Use a `Material` surface with rounded corners and max height (e.g., 240–320px), list tiles showing:
        - house title (bold)
        - `house.fullLocation` (subtitle)
        - optionally formatted price
- **Interaction:**
    - Tapping map (already `MapOptions.onTap`) should unfocus and hide suggestions.

### 4) Navigation target: proximity-sorted results list
- **New screen:** e.g., `lib/screens/nearby_houses_screen.dart`
- **Inputs:**
    - `House selectedHouse`
    - `List<House> houses` (the same filtered set you map over)
- **Distance calculation:**
    - Use `latlong2` already present (and used by `flutter_map`) to compute meters/kilometers.
    - For sorting: compute distance from `selectedHouse` to each house; sort ascending.
    - Ensure selected house appears first:
        - Option A: keep it in the list with distance 0 and stable-sort it first
        - Option B: render as a pinned “Selected property” card, then render remaining list
- **Results rendering:**
    - Title/header: “Nearby rentals” + small line “Near: {selectedHouse.title}”
    - `ListView.builder` for nearby houses
    - Optionally limit to top N (e.g., 20–50) to keep UI snappy.
- **Edge cases:**
    - If `houses` only contains the selected one → show selected card and an “No other nearby rentals” empty state
    - Missing/invalid lat/lng (not expected in your dummy data, but guard anyway)

### 5) Reuse existing house card UI (avoid duplication)
- **Current:** Card is implemented as `_buildPropertyCard` inside `HousesListScreen` (private method).
- **Recommended refactor approach (choose one):**
    - **Option A (best):** Extract the card into a shared widget:
        - Create `lib/widgets/house_card.dart` with something like `HouseCard(house, onTap, primaryColor, ...)`.
        - Update both `HousesListScreen` and `NearbyHousesScreen` to use it.
    - **Option B (minimal change):** Copy card UI into new screen (not ideal; diverges over time).
    - **Option C:** Convert `_buildPropertyCard` to a public widget builder (still tied to screen unless extracted).
- **Navigation from cards:**
    - Keep existing behavior: tapping card pushes `HouseDetailScreen(house: house)` (as in `HousesListScreen`).

## Marker tap behavior change (as requested)
- **Current:** marker tap opens `_showHouseSheet` bottom sheet.
- **New:** marker tap should navigate to proximity results list.
    - Either replace sheet entirely, or keep sheet with a prominent “See nearby” button that navigates.
    - Your request says: “marker tap navigates…” → plan assumes direct navigation.

## Incremental delivery (so you can ship safely)
1. Add header UI and basic query state (no suggestions yet).
2. Add local suggestions with normalization + selection logging (still no navigation).
3. Add navigation to `NearbyHousesScreen` from suggestion tap.
4. Switch marker tap from bottom sheet to the same navigation path.
5. Extract and reuse the existing property card widget; ensure consistent styling between screens.

Draft complete—tell me your preference on two choices so I can refine the plan:
1) Keep marker bottom sheet (with “Nearby” CTA) or navigate immediately on marker tap?
2) Suggestion ranking: simple contains-match only, or token-based AND matching with ranking?

