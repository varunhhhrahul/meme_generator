import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:meme_generator/utils/save_image.dart';
import 'package:meme_generator/widgets/draggable_resizable_widget.dart';
import 'package:meme_generator/widgets/text_wrapper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulHookWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    final _isContainerActive = useState(false);
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: RepaintBoundary(
        key: _globalKey,
        child: LayoutBuilder(
          builder: (context, size) {
            double dimensions =
                size.maxWidth > size.maxHeight ? size.maxHeight : size.maxWidth;
            return Center(
              child: GestureDetector(
                onTap: () => _isContainerActive.value = true,
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
                    children: <Widget>[
                      TextWrapper(isContainerActive: _isContainerActive),
                      TextWrapper(isContainerActive: _isContainerActive),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),

      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              onPressed: () async {
                _isContainerActive.value = true;
                await Future.delayed(Duration(milliseconds: 500));
                saveImage(context: context, globalKey: _globalKey);
              },
              tooltip: 'Save',
              child: const Icon(Icons.add),
            ),
            if (_isContainerActive.value == false)
              FloatingActionButton(
                onPressed: () async {
                  _isContainerActive.value = true;
                  await Future.delayed(Duration(milliseconds: 500));
                  saveImage(context: context, globalKey: _globalKey);
                },
                tooltip: 'Edit text',
                child: const Icon(Icons.edit),
              ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
