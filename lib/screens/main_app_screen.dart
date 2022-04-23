import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meme_generator/provider/app_provider.dart';
import 'package:meme_generator/utils/json_utils.dart';

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
    final _isContainerActive = useState(false);
    final selectedBackground = ref.watch(appProvider).selectedBackground;
    final textWidgets = ref.watch(appProvider).textWidgets;
    final templateId = ref.watch(appProvider).templateId;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meme Generator'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Edit Template',
            onPressed: () async {
              if (textWidgets.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please add text to edit template'),
                  ),
                );
              } else {
                _isContainerActive.value = true;
                final path = await saveImage(
                  context: context,
                  globalKey: _globalKey,
                  edit: true,
                );
                await editTemplate(
                  id: templateId!,
                  backgroundElement: selectedBackground,
                  textElements: textWidgets,
                  path: path,
                );
                ref.read(appProvider.notifier).setTemplateId(null);
                ref.read(appProvider.notifier).setSelectedBackground(null);

                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      body: RepaintBoundary(
        key: _globalKey,
        child: StackWrapper(
          isContainerActive: _isContainerActive,
        ),
      ),

      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton.extended(
              heroTag: 'save-floating-button',
              onPressed: () async {
                if (textWidgets.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please add text to save'),
                    ),
                  );
                } else {
                  _isContainerActive.value = true;
                  await Future.delayed(const Duration(milliseconds: 500));
                  final path =
                      await saveImage(context: context, globalKey: _globalKey);

                  await addTemplate(
                    backgroundElement: selectedBackground,
                    textElements: textWidgets,
                    path: path,
                  );
                  ref.read(appProvider.notifier).setTemplateId(null);
                  ref.read(appProvider.notifier).setSelectedBackground(null);
                  Navigator.of(context).pop();
                }
              },
              tooltip: 'Save',
              label: const Text('Save Image'),
              icon: const Icon(Icons.save),
            ),
            FloatingActionButton.extended(
              heroTag: 'add-text-floating-button',
              onPressed: () {
                ref.read(appProvider.notifier).addTextWidget();
              },
              tooltip: 'Add Text',
              label: const Text('Add Text'),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
