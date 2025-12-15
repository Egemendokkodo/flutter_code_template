import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_code_template/core/network/api_state.dart';

/// A generic Consumer widget for Flutter applications that listens to a [ChangeNotifier] ViewModel
/// and reacts to changes in an [ApiState].
///
/// This widget handles the common UI states such as:
/// - Loading
/// - Success (with non-null data)
/// - Success (with null data / empty)
/// - Error (with optional widget or callback)
///
/// Example usage:
/// ```dart
/// CommonConsumer<LoginViewModel, User>(
///   stateSelector: (vm) => vm.userDetailState,
///   builder: (context, user) => Text(user.email),
///   loadingWidget: CircularProgressIndicator(),
///   emptyWidget: Text("No user found"),
///   errorCallback: (context, message) {
///     showDialog(
///       context: context,
///       builder: (_) => AlertDialog(
///         title: Text("Error"),
///         content: Text(message ?? "Unknown error"),
///       ),
///     );
///   },
/// )
/// ```
class CommonConsumer<VM extends ChangeNotifier, T> extends StatelessWidget {
  /// Callback to select the ApiState from the ViewModel
  final ApiState<T> Function(VM vm) stateSelector;

  /// Callback to build the UI when data is successfully fetched
  final Widget Function(BuildContext context, T data) builder;

  /// Widget to display while loading
  final Widget? loadingWidget;

  /// Widget to display when data is empty (null)
  final Widget? emptyWidget;

  /// Widget to display in case of error
  final Widget Function(String? message)? errorWidget;

  /// Callback to handle errors (for example, showing an AlertDialog)
  final void Function(BuildContext context, String? message)? errorCallback;

  const CommonConsumer({super.key, required this.stateSelector, required this.builder, this.loadingWidget, this.emptyWidget, this.errorWidget, this.errorCallback});

  @override
  Widget build(BuildContext context) {
    // Error validation: Both errorCallback and errorWidget cannot be used simultaneously
    if (errorCallback != null && errorWidget != null) {
      throw ArgumentError('errorCallback and errorWidget cannot be used at the same time.');
    }

    return Consumer<VM>(
      builder: (context, vm, child) {
        final state = stateSelector(vm);

        switch (state.status) {
          case UiStatus.loading:
            // Show loading widget if provided, otherwise default CircularProgressIndicator
            return loadingWidget ?? const Center(child: CircularProgressIndicator());

          case UiStatus.success:
            // Show the builder if data is not null
            if (state.data != null) {
              return builder(context, state.data!);
            } else {
              // Show empty widget if provided, otherwise default text
              return emptyWidget ?? const Center(child: Text("No data found"));
            }

          case UiStatus.error:
            // If error callback is provided, call it (e.g., show AlertDialog)
            if (errorCallback != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                errorCallback!(context, state.errorMessage);
              });
              // Return empty container since UI is handled in callback
              return const SizedBox.shrink();
            }

            // If error widget is provided, display it
            if (errorWidget != null) {
              return errorWidget!(state.errorMessage);
            }

            // Default error widget
            return Center(child: Text(state.errorMessage ?? "An error occurred"));

          default:
            // Fallback for unhandled states
            return Center(child: Text("Unhandled state: ${state}"));
        }
      },
    );
  }
}
