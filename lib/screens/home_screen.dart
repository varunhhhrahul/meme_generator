import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meme_generator/constants/routes.dart';
import 'package:meme_generator/provider/app_provider.dart';
import 'package:meme_generator/screens/main_app_screen.dart';
import 'package:meme_generator/widgets/bounce_animation.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedBackground = ref.watch(appProvider).selectedBackground;
    final List<String> backgroundUrls = [
      'https://picsum.photos/id/237/200/300',
      'https://picsum.photos/id/236/200/300',
      'https://picsum.photos/id/235/200/300',
      'https://picsum.photos/id/234/200/300',
      'https://picsum.photos/id/233/200/300',
      'https://picsum.photos/id/232/200/300',
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a background'),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: GridView.builder(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 0.8,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemBuilder: (ctx, index) {
            return BounceAnimation(
              onPress: () {
                ref
                    .read(appProvider.notifier)
                    .setSelectedBackground(backgroundUrls[index]);
              },
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage(
                          backgroundUrls[index],
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: selectedBackground == backgroundUrls[index]
                            ? Colors.green
                            : Colors.grey.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          itemCount: backgroundUrls.length,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedBackground != null) {
            Navigator.pushNamed(
              context,
              Routes.generateMeme,
              arguments: MainAppScreenArguments(),
            );
          } else {}
        },
        child: const Icon(
          Icons.chevron_right,
          size: 30,
        ),
      ),
    );
  }
}
