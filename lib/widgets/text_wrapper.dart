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
    useEffect(() {
      if (_isNotActive.value == false) {
        _isNotActive.value = isContainerActive.value;
      }
      return null;
    }, [isContainerActive.value]);
    return GestureDetector(
      onTap: () {
        isContainerActive.value = false;
        _isNotActive.value = false;
      },
      child: DraggableResizableWidget(
        isNotActive: _isNotActive.value,
        child: Text('Hello'),
      ),
    );
  }
}
