import 'package:flutter/material.dart';
import 'package:meme_generator/Theme/theme.dart';
import 'package:meme_generator/constants/routes.dart';
import 'package:meme_generator/screens/home_screen.dart';
import 'package:meme_generator/screens/main_app_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: const HomeScreen(),
      routes: {
        Routes.generateMeme: (context) => MainAppScreen(
              arguments: ModalRoute.of(context)!.settings.arguments
                  as MainAppScreenArguments,
            )
      },
    );
  }
}
