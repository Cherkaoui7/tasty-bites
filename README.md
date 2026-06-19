# Tasty Bites

A polished Flutter restaurant-ordering demo built with Material 3. Browse a curated menu, inspect dishes, manage quantities in a cart, and move through the experience using a compact bottom navigation bar.

![Tasty Bites app screens](docs/screenshots/mockup.jpeg)

## What is included

- A home feed with delivery details, category filters, promotions, and popular dishes.
- A searchable menu and a dish-detail page with quantity controls.
- A cart with live item counts, subtotal, delivery fee, and total calculation.
- A profile screen with common account actions.
- Shared cart state powered by `provider`, so the basket stays in sync across tabs.
- A Material 3 theme using the Poppins font from `google_fonts`.
- Emoji-based dish artwork: the demo needs no image-asset setup to run.

## Tech stack

| Area | Choice | Why it is used |
| --- | --- | --- |
| UI | Flutter + Material 3 | A responsive, modern interface from one codebase. |
| State | `provider` | Keeps cart data simple and available throughout the app. |
| Typography | `google_fonts` | Applies Poppins consistently to the app theme. |
| Web | Flutter web | Lets the project run directly in Chrome. |

## Getting started

### Prerequisites

Install the [Flutter SDK](https://docs.flutter.dev/get-started/install) and confirm that Chrome is available for web development:

```bash
flutter doctor
```

### Install and run

```bash
git clone https://github.com/Cherkaoui7/tasty-bites.git
cd tasty-bites
flutter pub get
flutter run -d chrome
```

To choose a different available device, run `flutter devices`, then pass its identifier to `flutter run -d <device-id>`.

### Verify and build

```bash
# Run the widget test suite
flutter test

# Create an optimized web build in build/web
flutter build web
```

You can preview the generated web output with any static-file server, or deploy the `build/web` directory to a web host.

## Project structure

```text
lib/
├── data/
│   └── sample_data.dart        # Demo categories and menu items
├── models/
│   └── dish.dart               # Dish data model
├── providers/
│   └── cart_provider.dart      # Cart state and price calculations
├── screens/
│   ├── root_nav.dart           # Bottom navigation shell
│   ├── home_screen.dart        # Landing and discovery experience
│   ├── menu_screen.dart        # Searchable menu
│   ├── dish_detail_screen.dart # Dish details and add-to-cart controls
│   ├── cart_screen.dart        # Basket and checkout summary
│   └── profile_screen.dart     # User profile and settings actions
├── widgets/
│   └── dish_card.dart          # Reusable menu-card presentation
└── main.dart                   # App theme and provider setup

test/
└── widget_test.dart            # Home-screen startup smoke test

web/                            # Flutter web runner and icons
```

## Customization guide

### Brand and theme

Change `TastyBitesApp.seed` in [lib/main.dart](lib/main.dart) to update the primary color. The rest of the Material 3 color scheme is generated from that seed.

### Menu content

Edit the categories and dishes in [lib/data/sample_data.dart](lib/data/sample_data.dart). Each dish model controls the name, price, category, rating, preparation time, and emoji shown throughout the app.

### Images

The app uses emojis so it runs without downloaded media. For production artwork, replace the emoji rendering in the dish widgets/screens with `Image.asset` or `Image.network`, then declare local files from an `assets/` directory in the `flutter:` section of `pubspec.yaml` when necessary.

### Checkout behaviour

Cart totals and delivery calculations live in [lib/providers/cart_provider.dart](lib/providers/cart_provider.dart). This is the natural place to connect a backend, delivery rules, or payments in a full application.

## Notes

This repository includes Flutter web support. To add another platform later, generate only the platform you need, for example:

```bash
flutter create --platforms=android,ios .
```

## License

Released under the [MIT License](LICENSE).
