import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meme_generator/helpers/logger.dart';
import 'package:meme_generator/provider/app_provider.dart';
import 'package:meme_generator/utils/json_utils.dart';
import 'package:uuid/uuid.dart';

import '../constants/models/text_element.dart';
import '../utils/save_image.dart';
import '../widgets/stack_wrapper.dart';

class MainAppScreenArguments {
  MainAppScreenArguments();
}

class MainAppScreen extends HookConsumerWidget {
  final MainAppScreenArguments? arguments;
  MainAppScreen({
    Key? key,
    this.arguments,
  }) : super(key: key);

  final GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final _textWidgets = useState<List<TextElement>>([]);

    final _isContainerActive = useState(false);
    final selectedBackground = ref.watch(appProvider).selectedBackground;
    final textWidgets = ref.watch(appProvider).textWidgets;
    // void addTextWidget() {
    //   setState(
    //     () {
    //       _textWidgets.value.add(
    //         TextElement(
    //           id: const Uuid().v4(),
    //           text: 'This is a text',
    //         ),
    //       );
    //     },
    //   );
    // }

    // void removeTextWidget(String textId) {
    //   setState(() {
    //     _textWidgets.value.removeWhere((element) => element.id == textId);
    //   });
    // }

    // TextElement updateTextWidget(
    //   String textId, {
    //   String? id,
    //   String? text,
    //   double? height,
    //   double? width,
    //   double? cumulativeDy,
    //   double? cumulativeDx,
    //   double? cumulativeMid,
    //   double? top,
    //   double? left,
    // }) {
    //   logger.d('updateTextWidget: $textId');
    //   int index =
    //       _textWidgets.value.indexWhere((element) => element.id == textId);
    //   TextElement element = TextElement.copy(
    //     _textWidgets.value[index],
    //     cumulativeDx: cumulativeDx,
    //     cumulativeDy: cumulativeDy,
    //     cumulativeMid: cumulativeMid,
    //     width: width,
    //     height: height,
    //     text: text,
    //     top: top,
    //     left: left,
    //   );
    //   setState(() {
    //     _textWidgets.value[index] = element;
    //   });
    //   return element;
    // }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meme Generator'),
      ),
      body: RepaintBoundary(
        key: _globalKey,
        child: StackWrapper(
          isContainerActive: _isContainerActive,
        ),
      ),

      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              heroTag: 'save-floating-button',
              onPressed: () async {
                _isContainerActive.value = true;
                await Future.delayed(const Duration(milliseconds: 500));
                final path =
                    await saveImage(context: context, globalKey: _globalKey);

                await addTemplate(
                  backgroundElement: selectedBackground,
                  textElements: textWidgets,
                  path: path,
                );

                Navigator.of(context).pop();
              },
              tooltip: 'Save',
              child: const Icon(Icons.save),
            ),
            FloatingActionButton(
              heroTag: 'add-text-floating-button',
              onPressed: () {
                ref.read(appProvider.notifier).addTextWidget();
              },
              tooltip: 'Add Text',
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
