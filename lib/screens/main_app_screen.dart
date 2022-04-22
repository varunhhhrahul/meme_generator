import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:uuid/uuid.dart';

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
    final _textWidgets = useState<List<String>>([]);
    final _isContainerActive = useState(false);
    void addTextWidget() {
      setState(() {
        _textWidgets.value.add(
          const Uuid().v4(),
        );
      });
    }

    void removeTextWidget(String textId) {
      setState(() {
        _textWidgets.value.removeWhere((element) => element == textId);
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
