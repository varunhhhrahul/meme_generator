import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:meme_generator/helpers/logger.dart';
import 'package:uuid/uuid.dart';

import '../constants/models/text_element.dart';
import '../utils/save_image.dart';
import '../widgets/stack_wrapper.dart';

class MainAppScreenArguments {
  MainAppScreenArguments();
}

class MainAppScreen extends StatefulHookWidget {
  final MainAppScreenArguments? arguments;
  const MainAppScreen({
    Key? key,
    this.arguments,
  }) : super(key: key);

  @override
  State<MainAppScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<MainAppScreen> {
  final GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final _textWidgets = useState<List<TextElement>>([]);
    final _isContainerActive = useState(false);
    void addTextWidget() {
      setState(
        () {
          _textWidgets.value.add(
            TextElement(
              id: const Uuid().v4(),
              text: 'This is a text',
            ),
          );
        },
      );
    }

    void removeTextWidget(String textId) {
      setState(() {
        _textWidgets.value.removeWhere((element) => element.id == textId);
      });
    }

    void updateTextWidget(
      String textId, {
      String? id,
      String? text,
      double? height,
      double? width,
      double? cumulativeDy,
      double? cumulativeDx,
      double? cumulativeMid,
      double? top,
      double? left,
    }) {
      logger.d('updateTextWidget: $textId');
      setState(() {
        int index =
            _textWidgets.value.indexWhere((element) => element.id == textId);
        _textWidgets.value[index] = TextElement.copy(
          _textWidgets.value[index],
          cumulativeDx: cumulativeDx,
          cumulativeDy: cumulativeDy,
          cumulativeMid: cumulativeMid,
          width: width,
          height: height,
          text: text,
          top: top,
          left: left,
        );
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meme Generator'),
      ),
      body: RepaintBoundary(
        key: _globalKey,
        child: StackWrapper(
          textWidgets: _textWidgets,
          isContainerActive: _isContainerActive,
          removeTextWidget: removeTextWidget,
          updateTextWidget: updateTextWidget,
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
                // _isContainerActive.value = true;
                await Future.delayed(const Duration(milliseconds: 500));
                saveImage(context: context, globalKey: _globalKey);
              },
              tooltip: 'Save',
              child: const Icon(Icons.save),
            ),
            FloatingActionButton(
              heroTag: 'add-text-floating-button',
              onPressed: () {
                addTextWidget();
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
