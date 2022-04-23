import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meme_generator/provider/app_provider.dart';
import 'package:meme_generator/widgets/draggable_resizable_widget.dart';

import '../constants/models/text_element.dart';

class TextWrapper extends HookConsumerWidget {
  final TextElement textElement;
  final ValueNotifier<bool> isContainerActive;
  final String textId;

  const TextWrapper({
    Key? key,
    required this.textElement,
    required this.isContainerActive,
    required this.textId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _isNotActive = useState(false);
    final textWidgets = ref.watch(appProvider).textWidgets;
    final _textController = useTextEditingController(text: 'This is a text');
    useEffect(() {
      if (_isNotActive.value == false) {
        _isNotActive.value = isContainerActive.value;
      }
      return null;
    }, [isContainerActive.value]);
    void _openBottomSheet() {
      _textController.text = textElement.text;
      showModalBottomSheet<void>(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(15.0),
          ),
        ),
        backgroundColor: Colors.white,
        context: context,
        isScrollControlled: true,
        builder: (context) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  decoration: const InputDecoration(hintText: 'Text'),
                  autofocus: true,
                  controller: _textController,
                ),
                ElevatedButton(
                  onPressed: () {
                    ref.read(appProvider.notifier).updateTextWidget(
                          textId,
                          text: _textController.text,
                        );

                    Navigator.pop(context);
                  },
                  child: const Text('Update'),
                )
              ],
            ),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        isContainerActive.value = false;
        _isNotActive.value = false;
      },
      child: DraggableResizableWidget(
        isNotActive: _isNotActive.value,
        isNotActiveNotifier: _isNotActive,
        textElement: textElement,
        onPressed: _openBottomSheet,
        index: textWidgets.indexWhere((element) => element.id == textId),
        child: Text(textElement.text),
        widgetTop: textElement.top,
        widgetLeft: textElement.left,
      ),
    );
  }
}
