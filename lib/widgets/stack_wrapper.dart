import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:meme_generator/widgets/text_wrapper.dart';

class StackWrapper extends HookWidget {
  final ValueNotifier<List<String>> textWidgets;
  final ValueNotifier<bool> isContainerActive;

  const StackWrapper({
    Key? key,
    required this.textWidgets,
    required this.isContainerActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => isContainerActive.value = true,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: NetworkImage(
              'https://picsum.photos/id/237/200/300',
            ),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(8),
        child: Stack(
          children: [
            for (int i = 0; i < textWidgets.value.length; i++)
              TextWrapper(
                isContainerActive: isContainerActive,
                textId: textWidgets.value[i],
              )
            // textWidgets.value[i],
            // ...textWidgets.value
            //     .map((e) => LayoutBuilder(builder: (context, size) {
            //           return e;
            //         }))
            //     .toList()
          ],
        ),
      ),
    );
  }
}
