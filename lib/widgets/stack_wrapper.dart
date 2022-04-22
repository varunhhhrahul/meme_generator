import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meme_generator/helpers/logger.dart';
import 'package:meme_generator/provider/app_provider.dart';
import 'package:meme_generator/widgets/text_wrapper.dart';

class StackWrapper extends HookConsumerWidget {
  final ValueNotifier<List<String>> textWidgets;
  final ValueNotifier<bool> isContainerActive;
  final void Function(String) removeTextWidget;

  const StackWrapper({
    Key? key,
    required this.textWidgets,
    required this.isContainerActive,
    required this.removeTextWidget,
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
                    isContainerActive: isContainerActive,
                    textId: value,
                    removeTextWidget: () => removeTextWidget(value),
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
