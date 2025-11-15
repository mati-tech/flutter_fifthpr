# Riverpod Migration Instructions

## Overview
This Flutter e-commerce app has been successfully migrated from GetIt + ChangeNotifier to Riverpod with code generation.

## Code Generation

### Step 1: Install Dependencies
```bash
flutter pub get
```

### Step 2: Generate Riverpod Providers
Run the build_runner to generate all provider files:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

This will generate the following files:
- `lib/features/auth/providers/auth_provider.g.dart`
- `lib/features/cart/providers/cart_provider.g.dart`
- `lib/features/favorites/providers/favorites_provider.g.dart`
- `lib/features/home/providers/home_provider.g.dart`
- `lib/features/orders/providers/orders_provider.g.dart`
- `lib/features/profile/providers/profile_provider.g.dart`
- `lib/features/settings/providers/settings_provider.g.dart`

### Step 3: Watch Mode (Optional)
For continuous code generation during development:

```bash
flutter pub run build_runner watch --delete-conflicting-outputs
```

## Migration Summary

### What Changed

1. **Dependencies**
   - Removed: `provider`, `get_it`
   - Added: `flutter_riverpod`, `riverpod_annotation` (already present)
   - Dev dependencies: `riverpod_generator`, `build_runner` (already present)

2. **State Management**
   - Old: `ChangeNotifier` containers with `GetIt` dependency injection
   - New: Riverpod providers with code generation using `@riverpod` annotation

3. **Widget Updates**
   - All screens migrated from `ContainerListenableBuilder` to `ConsumerWidget` or `ConsumerStatefulWidget`
   - All widgets using state migrated to `ConsumerWidget`

4. **Main Entry Point**
   - `main.dart` now wraps app with `ProviderScope`

### Provider Structure

Each feature now has a provider file in `lib/features/{feature}/providers/{feature}_provider.dart`:
- Uses `@riverpod` annotation for code generation
- Extends `_${Feature}Notifier` (generated class)
- Maintains same functionality as original containers

### Usage Examples

**Reading State:**
```dart
final homeState = ref.watch(homeNotifierProvider);
```

**Calling Methods:**
```dart
ref.read(homeNotifierProvider.notifier).searchProducts(query);
```

**In Widgets:**
```dart
class MyScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(myNotifierProvider);
    // Use state...
  }
}
```

## Files to Remove After Verification

Once you've verified everything works, you can safely remove:
- `lib/core/setup_di.dart`
- `lib/core/widgets/listenable_builder.dart`
- All `*_container.dart` files in `lib/features/*/state/` directories

## Testing Checklist

- [ ] Run code generation successfully
- [ ] App starts without errors
- [ ] Home screen displays products
- [ ] Search functionality works
- [ ] Category filtering works
- [ ] Add to cart works
- [ ] Cart screen displays items correctly
- [ ] Favorites functionality works
- [ ] Profile screen loads
- [ ] Settings screen works
- [ ] Orders screen displays correctly

## Troubleshooting

### Code Generation Errors
- Ensure all imports are correct
- Check that `part` directives match file names
- Run `flutter clean` then `flutter pub get` if issues persist

### Provider Not Found Errors
- Ensure `ProviderScope` wraps your app in `main.dart`
- Verify code generation completed successfully
- Check provider file names match generated files

### State Not Updating
- Ensure you're using `ref.watch()` for reactive updates
- Use `ref.read()` only for one-time reads or method calls
- Check that notifier methods are properly updating state

## Next Steps

1. Run code generation
2. Test all features
3. Remove old state management files
4. Update any remaining references if needed

