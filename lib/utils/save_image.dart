import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:meme_generator/helpers/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:ui' as ui;

Future<String?> saveImage({
  bool save = true,
  required BuildContext context,
  required globalKey,
  bool edit = false,
}) async {
  try {
    RenderRepaintBoundary boundary =
        globalKey.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List? pngBytes = byteData?.buffer.asUint8List();

    if (!save) return null;
    var file = await _saveFile(pngBytes!, context: context);
    if (file.existsSync()) {
      logger.d('file saved');
      if (!edit) {
        await GallerySaver.saveImage(file.path);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Image saved to gallery'),
            duration: Duration(seconds: 1),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Template updated!'),
            duration: Duration(seconds: 1),
          ),
        );
      }
    } else {
      logger.d('file not saved');
    }
    return file.path;
  } catch (e) {
    logger.e(e);
    return null;
  }
}

Future<File> _saveFile(
  List<int> pngBytes, {
  required BuildContext context,
}) async {
  final dir = await getApplicationDocumentsDirectory();

  File file = File('${dir.path}/Meme/${DateTime.now().toIso8601String()}.png');
  if (!file.existsSync()) {
    file.createSync(recursive: true);
    if (file.existsSync()) {
      logger.d('File updated at ${file.path}');
    } else {
      logger.e('File not updated at ${file.path}');
    }
  }

  file.writeAsBytesSync(pngBytes);

  if (file.existsSync()) {
    logger.d('File Saved');
  } else {
    logger.d('Failed to save file');
  }

  return file;
}
