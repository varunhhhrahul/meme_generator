import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class StackWrapper extends HookWidget {
  final ValueNotifier<List<Widget>> textWidgets;
  const StackWrapper({Key? key, required this.textWidgets}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
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
          // mainAxisSize: MainAxisSize.min,

          children: [
            for (int i = 0; i < textWidgets.value.length; i++)
              Container(color: Colors.red, child: textWidgets.value[i])
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
