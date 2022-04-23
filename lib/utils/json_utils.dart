// Fetch content from the json file
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:meme_generator/constants/models/background_element.dart';
import 'package:meme_generator/constants/models/template.dart';
import 'package:meme_generator/helpers/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../constants/models/text_element.dart';

Future readJson() async {
  try {
    Directory dir = await getApplicationDocumentsDirectory();

    if (await File('${dir.path}/templates.json').exists()) {
      File file = File('${dir.path}/templates.json');
      String jsonString = await file.readAsString();
      Map<String, dynamic> json = jsonDecode(jsonString);
      logger.d('ONE: $json');
      List<Template> templates = [];
      json['templates'].forEach((e) {
        templates.add(Template.fromJson(e));
      });

      logger.d('ONE-T: $templates');
      return templates;
    } else {
      final String response =
          // File(Directory.current.absolute.path).readAsStringSync();
          await rootBundle.loadString('assets/data/dummy_data.json');
      await File('${dir.path}/templates.json').writeAsString(response);
      Map<String, dynamic> json = jsonDecode(response);
      logger.d('TWO: $json');
      List<Template> templates = [];
      json['templates'].forEach((e) {
        templates.add(Template.fromJson(e));
      });
      logger.d('TWO-T: $templates');
      return templates;
    }

    // final data = await json.decode(response);

    // return data['templates'];
  } catch (e) {
    logger.e(e);
  }
}

Future<void> addTemplate({
  required BackgroundElement? backgroundElement,
  required List<TextElement> textElements,
  String? path,
}) async {
  try {
    logger.d('Adding template');
    Directory dir = await getApplicationDocumentsDirectory();
    List templates = await readJson();
    logger.d('Templates: $templates');
    templates.add(
      Template(
        id: const Uuid().v4(),
        backgroundElement:
            BackgroundElement.copy(backgroundElement!, id: const Uuid().v4()),
        textElements: textElements,
        previewUrl: path,
      ),
    );
    final updatedTemplates = templates.map((e) => e.toMap()).toList();
    await File('${dir.path}/templates.json')
        .writeAsString(jsonEncode({'templates': updatedTemplates}));

    // return data['templates'];
  } catch (e) {
    logger.e('Error adding template $e');
  }
}

Future<void> editTemplate({
  required BackgroundElement? backgroundElement,
  required List<TextElement> textElements,
  String? path,
}) async {
  try {
    logger.d('Editing template');
    Directory dir = await getApplicationDocumentsDirectory();
    List templates = await readJson();
    logger.d('Templates: $templates');
    templates.add(
      Template(
        id: const Uuid().v4(),
        backgroundElement:
            BackgroundElement.copy(backgroundElement!, id: const Uuid().v4()),
        textElements: textElements,
        previewUrl: path,
      ),
    );
    final updatedTemplates = templates.map((e) => e.toMap()).toList();
    await File('${dir.path}/templates.json')
        .writeAsString(jsonEncode({'templates': updatedTemplates}));

    // return data['templates'];
  } catch (e) {
    logger.e('Error adding template $e');
  }
}
