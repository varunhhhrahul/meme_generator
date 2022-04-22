import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:meme_generator/widgets/draggable_resizable_widget.dart';

class TextWrapper extends HookWidget {
  final ValueNotifier<bool> isContainerActive;
  const TextWrapper({Key? key, required this.isContainerActive})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _isNotActive = useState(false);
    final _textController = useTextEditingController(text: 'This is a text');
    final _currentText = useState('This is a text');
    useEffect(() {
      if (_isNotActive.value == false) {
        _isNotActive.value = isContainerActive.value;
      }
      return null;
    }, [isContainerActive.value]);
    void _openBottomSheet() {
      _textController.text = _currentText.value;
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: TextField(
                        decoration: const InputDecoration(hintText: 'Text'),
                        autofocus: true,
                        controller: _textController,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _currentText.value = _textController.text;
                        Navigator.pop(context);
                      },
                      child: const Text('Update'),
                    )
                  ],
                ),
              ));
    }

    return GestureDetector(
      onTap: () {
        isContainerActive.value = false;
        _isNotActive.value = false;
      },
      child: DraggableResizableWidget(
        isNotActive: _isNotActive.value,
        onPressed: _openBottomSheet,
        child: Text(_currentText.value),
      ),
    );
  }
}
