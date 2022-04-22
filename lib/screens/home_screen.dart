import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meme_generator/constants/routes.dart';
import 'package:meme_generator/screens/main_app_screen.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Meme Generator'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              // ref.read(navigateToGenerateMemeScreen).call();
              Navigator.of(context).pushNamed(
                Routes.generateMeme,
                arguments: MainAppScreenArguments(),
              );
            },
            child: const Text('Generate Meme'),
          ),
        ));
  }
}
