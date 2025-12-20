import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/home_provider.dart';

class SearchBarWidget extends ConsumerStatefulWidget {
  final bool autoFocus;

  const SearchBarWidget({super.key, this.autoFocus = false});

  @override
  ConsumerState<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends ConsumerState<SearchBarWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final homeNotifier = ref.read(homeProvider.notifier);

    return TextField(
      controller: _controller,
      autofocus: widget.autoFocus,
      decoration: InputDecoration(
        hintText: 'Search products...',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: _controller.text.isNotEmpty
            ? IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            _controller.clear();
            homeNotifier.initialize(); // reset to all products
          },
        )
            : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onChanged: (value) {
        if (value.isEmpty) {
          homeNotifier.initialize(); // reset
        } else {
          homeNotifier.searchProducts(value);
        }
      },
      onSubmitted: (value) {
        homeNotifier.searchProducts(value);
      },
    );
  }
}
