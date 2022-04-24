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

// Get Json data from the assets folder and store it into DocumentDirectory of the app
Future readJson() async {
  try {
    Directory dir = await getApplicationDocumentsDirectory();

    if (await File('${dir.path}/templates.json').exists()) {
      File file = File('${dir.path}/templates.json');

      String jsonString = await file.readAsString();

      Map<String, dynamic> json = jsonDecode(jsonString);

      List<Template> templates = [];

      json['templates'].forEach((e) {
        templates.add(Template.fromJson(e));
      });

      return templates;
    } else {
      final String response =
          await rootBundle.loadString('assets/data/dummy_data.json');

      await File('${dir.path}/templates.json').writeAsString(response);

      Map<String, dynamic> json = jsonDecode(response);

      List<Template> templates = [];

      json['templates'].forEach((e) {
        templates.add(Template.fromJson(e));
      });
      return templates;
    }
  } catch (e) {
    logger.e(e);
  }
}

//  Append new template to the json file in the DocumentDirectory of the app
Future<void> addTemplate({
  required BackgroundElement? backgroundElement,
  required List<TextElement> textElements,
  String? path,
}) async {
  try {
    Directory dir = await getApplicationDocumentsDirectory();
    List templates = await readJson();

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
  } catch (e) {
    logger.e('Error adding template $e');
  }
}

// Update template in the json file in the DocumentDirectory of the app
Future<void> editTemplate({
  required String id,
  required BackgroundElement? backgroundElement,
  required List<TextElement> textElements,
  String? path,
}) async {
  try {
    Directory dir = await getApplicationDocumentsDirectory();
    List<Template> templates = await readJson();
    int index = templates.indexWhere((e) => e.id == id);
    templates[index] = Template.copy(
      templates[index],
      backgroundElement:
          BackgroundElement.copy(backgroundElement!, id: const Uuid().v4()),
      textElements: textElements,
      previewUrl: path,
    );
    final updatedTemplates = templates.map((e) => e.toMap()).toList();
    await File('${dir.path}/templates.json')
        .writeAsString(jsonEncode({'templates': updatedTemplates}));
  } catch (e) {
    logger.e('Error adding template $e');
  }
}
