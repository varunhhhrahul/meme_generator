import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// import 'package:flutter/rendering.dart';

import 'package:path_provider/path_provider.dart';
import 'dart:ui' as ui;

Future<String?> saveImage({
  bool save = true,
  required BuildContext context,
  required globalKey,
})
// async {
//   if (save) {
//     final status = await Permission.storage.request();
//     if (status.isGranted) {
//       final directory = await getApplicationDocumentsDirectory();
//       final path = '${directory.path}/${DateTime.now().toUtc().toIso8601String()}.png';
//       final image = await boundary.toImage(pixelRatio: 3.0);
//       final data = await image.toByteData(format: ui.ImageByteFormat.png);
//       return data.buffer.asUint8List();
//     }
//   }
//   final image = await boundary.toImage(pixelRatio: 3.0);
//   final data = await image.toByteData(format: ui.ImageByteFormat.png);
//   return data.buffer.asUint8List();
// })
async {
  try {
    print('inside');

    RenderRepaintBoundary boundary =
        globalKey.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    var pngBytes = byteData?.buffer.asUint8List();
//      var bs64 = base64Encode(pngBytes);
//      print(pngBytes);
//      print(bs64);
//      setState(() {});
    if (!save) return null;
    var file = await _saveFile(pngBytes!, context: context);
    if (file.existsSync()) {
      print('Saved');
    } else {
      print('Not Save');
    }
    return file.path;
  } catch (e) {
    print(e);
    return null;
  }
}

// _sharePng() async {
//   var bytes = await _capturePng(save: false);
//   if (bytes == null) return;
//   await Share.file(
//       'Share meme', 'meme.png', bytes.buffer.asUint8List(), 'image/png');
// }

Future<File> _saveFile(
  List<int> pngBytes, {
  required BuildContext context,
}) async {
  // PermissionStatus permission = await PermissionHandler()
  //     .checkPermissionStatus(PermissionGroup.storage);
  // if (permission != PermissionStatus.granted) {
  //   var permissions = await PermissionHandler()
  //       .requestPermissions([PermissionGroup.storage]);
  //   permission = permissions[PermissionGroup.storage];
  //   if (permission != PermissionStatus.granted) {
  //     await showDialog(
  //         context: context,
  //         builder: (context) {
  //           return AlertDialog(
  //             title: Text("No storage permissions"),
  //             content:
  //                 Text("You have not approved storage permissions, so the "
  //                     "image cannot be save to the gallery."),
  //             actions: <Widget>[
  //               FlatButton(
  //                 onPressed: () => Navigator.of(context).pop(),
  //                 child: Text('Cancel'),
  //               )
  //             ],
  //           );
  //         });

  //     return null;
  //   }
  // }

  // showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         content: Center(
  //           child: CircularProgressIndicator(),
  //         ),
  //       );
  //     });

  final dir = await getApplicationDocumentsDirectory();

  File file = File('${dir.path}/Meme/${DateTime.now().toIso8601String()}.png');
  if (!file.existsSync()) {
    file.createSync(recursive: true);
    if (file.existsSync())
      print('Done Create');
    else
      print('Ndakonewa');
  }
  file.writeAsBytesSync(pngBytes);
  print(file);
  if (file.existsSync()) {
    print('Saved');
  } else {
    print('Agh');
  }
  // Navigator.of(context).pop();
  return file;
}
