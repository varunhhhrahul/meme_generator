import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meme_generator/constants/models/text_element.dart';
import 'package:meme_generator/helpers/logger.dart';
import 'package:meme_generator/provider/app_provider.dart';
import 'package:meme_generator/widgets/text_wrapper.dart';

class StackWrapper extends HookConsumerWidget {
  final ValueNotifier<List<TextElement>> textWidgets;
  final ValueNotifier<bool> isContainerActive;
  final void Function(String) removeTextWidget;
  final void Function(
    String, {
    double? cumulativeDx,
    double? cumulativeDy,
    double? cumulativeMid,
    double? height,
    String? id,
    String? text,
    double? width,
    double? top,
    double? left,
  }) updateTextWidget;

  const StackWrapper({
    Key? key,
    required this.textWidgets,
    required this.isContainerActive,
    required this.removeTextWidget,
    required this.updateTextWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedBackground = ref.watch(appProvider).selectedBackground;
    useEffect(() {
      logger.d('StackWrapper build: ${textWidgets.value}');
      return null;
    }, [textWidgets.value.length]);
    return GestureDetector(
      onTap: () => isContainerActive.value = true,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: NetworkImage(
              selectedBackground ?? 'https://picsum.photos/id/237/200/300',
            ),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(8),
        child: Stack(
          children: [
            ...textWidgets.value
                .map(
                  (value) => TextWrapper(
                    textElement: value,
                    isContainerActive: isContainerActive,
                    textId: value.id,
                    removeTextWidget: () => removeTextWidget(value.id),
                    updateTextWidget: updateTextWidget,
                  ),
                )
                .toList(),
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
