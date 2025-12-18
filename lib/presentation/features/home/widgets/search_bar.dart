import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/app_theme.dart';
import '../screens/search_results_screen.dart';
import '../providers/home_provider.dart';

class SearchBarWidget extends ConsumerStatefulWidget {
  final bool autoFocus;
  final bool showInAppBar;

  const SearchBarWidget({
    super.key,
    this.autoFocus = false,
    this.showInAppBar = false,
  });

  @override
  ConsumerState<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends ConsumerState<SearchBarWidget> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.autoFocus) {
      _focusNode.requestFocus();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeProvider);

    return Container(
      margin: widget.showInAppBar
          ? const EdgeInsets.symmetric(horizontal: 0)
          : const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: widget.showInAppBar
          ? null
          : BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
      child: TextField(
        controller: _searchController,
        focusNode: _focusNode,
        decoration: InputDecoration(
          hintText: 'Search your favorite electronics...',
          prefixIcon: const Icon(Icons.search, color: AppTheme.secondaryColor),
          suffixIcon: homeState.searchQuery.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.close, color: AppTheme.secondaryColor),
                  onPressed: () {
                    _searchController.clear();
                    ref.read(homeProvider.notifier).clearFilters();
                    _focusNode.unfocus();
                  },
                )
              : null,
          border: widget.showInAppBar
              ? InputBorder.none
              : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          filled: !widget.showInAppBar,
          fillColor: widget.showInAppBar ? Colors.transparent : Colors.white,
        ),
        onChanged: (value) {
          ref.read(homeProvider.notifier).searchProducts(value);
        },
        onSubmitted: (value) {
          ref.read(homeProvider.notifier).searchProducts(value);
          _focusNode.unfocus();
        },
        onTap: widget.showInAppBar
            ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchResultsScreen(),
                  ),
                );
              }
            : null,
        readOnly: widget.showInAppBar,
      ),
    );
  }
}