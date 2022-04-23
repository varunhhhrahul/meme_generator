// * Like App Slice
import 'package:meme_generator/constants/models/background_element.dart';
import 'package:meme_generator/constants/models/text_element.dart';
import 'package:uuid/uuid.dart';

import '../constants/models/template.dart';
import '../helpers/logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Initial App State
class InitialState {
  final BackgroundElement? selectedBackground;
  final List<TextElement> textWidgets;
  final List<Template> templates;
  final bool loading;

  InitialState({
    required this.selectedBackground,
    required this.textWidgets,
    required this.loading,
    required this.templates,
  });

  InitialState.copy(
    InitialState copy, {
    BackgroundElement? selectedBackground,
    List<TextElement>? textWidgets,
    List<Template>? templates,
    bool? loading,
  }) : this(
          selectedBackground: selectedBackground ?? copy.selectedBackground,
          textWidgets: textWidgets ?? copy.textWidgets,
          loading: loading ?? copy.loading,
          templates: templates ?? copy.templates,
        );
}

// App Slice with initial State
class AppProvider extends StateNotifier<InitialState> {
  AppProvider()
      : super(
          InitialState(
            loading: false,
            textWidgets: [],
            templates: [],
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

  void setTemplates(List<Template> templates) {
    state = InitialState.copy(
      state,
      templates: templates,
    );
  }

  void setSelectedBackground(BackgroundElement? selectedBackground) {
    state = InitialState.copy(
      state,
      selectedBackground: selectedBackground,
    );
  }

  void setTextWidgets(List<TextElement> textWidgets) {
    state = InitialState.copy(
      state,
      textWidgets: textWidgets,
    );
  }

  void emptyTextWidgets() {
    state = InitialState.copy(
      state,
      textWidgets: [],
    );
  }

  void addTextWidget() {
    state = InitialState.copy(
      state,
      textWidgets: [
        ...state.textWidgets,
        TextElement(
          id: const Uuid().v4(),
          text: 'This is a text',
        ),
      ],
    );
  }

// void updateCoords(String textId, {
//   double top,
//   double left,
// })
  void removeTextWidget(String id) {
    final int index =
        state.textWidgets.indexWhere((element) => element.id == id);

    state = InitialState.copy(
      state,
      textWidgets: [
        ...state.textWidgets.sublist(0, index),
        ...state.textWidgets.sublist(index + 1),
      ],
    );
  }

  void updateTextWidget(
    String id, {
    String? text,
    double? height,
    double? width,
    double? cumulativeDy,
    double? cumulativeDx,
    double? cumulativeMid,
    double? top,
    double? left,
  }) {
    logger.d('updateTextWidget: $id');
    state = InitialState.copy(
      state,
      textWidgets: state.textWidgets
          .map((element) => element.id == id
              ? TextElement.copy(
                  element,
                  text: text ?? element.text,
                  height: height ?? element.height,
                  width: width ?? element.width,
                  cumulativeDy: cumulativeDy ?? element.cumulativeDy,
                  cumulativeDx: cumulativeDx ?? element.cumulativeDx,
                  cumulativeMid: cumulativeMid ?? element.cumulativeMid,
                  top: top ?? element.top,
                  left: left ?? element.left,
                )
              : element)
          .toList(),
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
