// import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart';
// import 'package:get_it/get_it.dart';
// import '../setup_di.dart';
//
// /// A widget that rebuilds when a ChangeNotifier from GetIt changes
// /// This replaces Provider's Consumer widget functionality
// class ContainerListenableBuilder<T extends ChangeNotifier> extends StatefulWidget {
//   final T Function() getNotifier;
//   final Widget Function(BuildContext context, T notifier) builder;
//
//   const ContainerListenableBuilder({
//     super.key,
//     required this.getNotifier,
//     required this.builder,
//   });
//
//   @override
//   State<ContainerListenableBuilder<T>> createState() => _ContainerListenableBuilderState<T>();
// }
//
// class _ContainerListenableBuilderState<T extends ChangeNotifier>
//     extends State<ContainerListenableBuilder<T>> {
//   late T _notifier;
//
//   @override
//   void initState() {
//     super.initState();
//     _notifier = widget.getNotifier();
//     _notifier.addListener(_onNotifierChanged);
//   }
//
//   @override
//   void dispose() {
//     _notifier.removeListener(_onNotifierChanged);
//     super.dispose();
//   }
//
//   void _onNotifierChanged() {
//     if (mounted) {
//       setState(() {});
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return widget.builder(context, _notifier);
//   }
// }
//
// /// Helper extension to easily create ContainerListenableBuilder from GetIt
// extension GetItListenableBuilder on GetIt {
//   /// Creates a ContainerListenableBuilder for a ChangeNotifier registered in GetIt
//   Widget listenableBuilder<T extends ChangeNotifier>({
//     required Widget Function(BuildContext context, T notifier) builder,
//   }) {
//     return ContainerListenableBuilder<T>(
//       getNotifier: () => get<T>(),
//       builder: builder,
//     );
//   }
// }
//
