// * Like App Slice
import '../helpers/logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Initial App State
class InitialState {
  final String? selectedBackground;
  final bool loading;

  InitialState({
    required this.selectedBackground,
    required this.loading,
  });

  InitialState.copy(
    InitialState copy, {
    String? selectedBackground,
    bool? loading,
  }) : this(
          selectedBackground: selectedBackground ?? copy.selectedBackground,
          loading: loading ?? copy.loading,
        );
}

// App Slice with initial State
class AppProvider extends StateNotifier<InitialState> {
  AppProvider()
      : super(
          InitialState(
            loading: false,
            selectedBackground: null,
          ),
        );

// Actions
  void setLoading() {
    state = InitialState.copy(
      state,
      loading: !state.loading,
    );
  }

  void setSelectedBackground(String? selectedBackground) {
    state = InitialState.copy(
      state,
      selectedBackground: selectedBackground,
    );
  }
}

// app reducer
final appProvider = StateNotifierProvider<AppProvider, InitialState>(
  (
    StateNotifierProviderRef<AppProvider, InitialState> ref,
  ) {
    var mounted = true;
    ref.onDispose(() => mounted = false);
    logger.d('App Provider: $mounted');
    return AppProvider();
  },
);
