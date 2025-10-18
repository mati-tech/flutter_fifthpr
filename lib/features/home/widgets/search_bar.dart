// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:storelytech/features/home/screens/home_screen.dart';
// import '../../../shared/app_theme.dart';
// import '../state/home_container.dart';
//
// class SearchBarWidget extends StatefulWidget {
//   final bool autoFocus;
//
//   const SearchBarWidget({super.key, this.autoFocus = false});
//
//   @override
//   State<SearchBarWidget> createState() => _SearchBarWidgetState();
// }
//
// class _SearchBarWidgetState extends State<SearchBarWidget> {
//   final TextEditingController _searchController = TextEditingController();
//   final FocusNode _focusNode = FocusNode();
//
//   @override
//   void initState() {
//     super.initState();
//     if (widget.autoFocus) {
//       _focusNode.requestFocus();
//     }
//   }
//
//   @override
//   void dispose() {
//     _searchController.dispose();
//     _focusNode.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final homeContainer = Provider.of<HomeScreen>(context);
//
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: TextField(
//         controller: _searchController,
//         focusNode: _focusNode,
//         decoration: InputDecoration(
//           hintText: 'Search products...',
//           prefixIcon: Icon(Icons.search, color: AppTheme.secondaryColor),
//           suffixIcon: homeContainer.searchQuery.isNotEmpty
//               ? IconButton(
//             icon: const Icon(Icons.close, color: AppTheme.secondaryColor),
//             onPressed: () {
//               _searchController.clear();
//               homeContainer.clearFilters();
//               _focusNode.unfocus();
//             },
//           )
//               : null,
//           border: InputBorder.none,
//           contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//         ),
//         onChanged: (value) {
//           homeContainer.searchProducts(value);
//         },
//         onSubmitted: (value) {
//           homeContainer.searchProducts(value);
//         },
//       ),
//     );
//   }
// }