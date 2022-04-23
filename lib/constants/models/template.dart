import 'package:meme_generator/constants/models/background_element.dart';
import 'package:meme_generator/constants/models/element.dart';
import 'package:meme_generator/constants/models/text_element.dart';

import '../../helpers/logger.dart';

// class Template {
//   final String id;
//   final List<Element> elements;

//   Template({
//     required this.id,
//     required this.elements,
//   });

//   Template.copy(
//     Template copy, {
//     String? id,
//     List<Element>? elements,
//   }) : this(
//           id: id ?? copy.id,
//           elements: elements ?? copy.elements,
//         );
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'elements': elements.map((e) => e.toMap()).toList(),
//     };
//   }

//   factory Template.fromJson(Map<String, dynamic> json) {
//     return Template(
//       id: json['id'] as String,
//       elements: (json['elements'] as List)
//           .map((e) => Element.fromJson(e as Map<String, dynamic>))
//           .toList(),
//     );
//   }
// }

class Template {
  final String id;
  final String? previewUrl;
  final BackgroundElement backgroundElement;
  final List<TextElement> textElements;

  Template({
    required this.id,
    this.previewUrl,
    required this.backgroundElement,
    required this.textElements,
  });

  Template.copy(
    Template copy, {
    String? id,
    String? previewUrl,
    BackgroundElement? backgroundElement,
    List<TextElement>? textElements,
  }) : this(
          id: id ?? copy.id,
          previewUrl: previewUrl ?? copy.previewUrl,
          backgroundElement: backgroundElement ?? copy.backgroundElement,
          textElements: textElements ?? copy.textElements,
        );
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'previewUrl': previewUrl,
      'backgroundElement': backgroundElement.toMap(),
      'textElements': textElements.map((e) => e.toMap()).toList(),
    };
  }

  factory Template.fromJson(Map<String, dynamic> json) {
    logger.d(json);
    return Template(
      id: json['id'] as String,
      backgroundElement: BackgroundElement.fromJson(
        json['backgroundElement'] as Map<String, dynamic>,
      ),
      previewUrl: json['previewUrl'] as String?,
      textElements: (json['textElements'] as List)
          .map((e) => TextElement.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
