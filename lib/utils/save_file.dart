// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:async';
import 'dart:io' as _io;

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:image/image.dart';
import 'package:path_provider/path_provider.dart';

class SaveFile {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<_io.File> getImageFromNetwork(String url) async {
    _io.File file = await DefaultCacheManager().getSingleFile(url);
    return file;
  }

  Future<_io.File> saveImage(String url) async {
    final file = await getImageFromNetwork(url);

    //retrieve local path for device
    var path = await _localPath;
    Image? image = decodeImage(file.readAsBytesSync());

    Image thumbnail = copyResize(image!, width: 120, height: 120);

    // Save the thumbnail as a PNG.
    return _io.File('$path/${DateTime.now().toUtc().toIso8601String()}.png')
      ..writeAsBytesSync(encodePng(thumbnail));
  }
}
