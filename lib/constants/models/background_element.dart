import 'package:meme_generator/constants/models/element.dart';

import '../../helpers/logger.dart';

class BackgroundElement extends Element {
  final String url;

  BackgroundElement({
    required this.url,
    required String id,
    double height = double.infinity,
    double width = double.infinity,
    double top = 0,
    double left = 0,
    ElementType type = ElementType.background,
  }) : super(
            id: id,
            height: height,
            width: width,
            top: top,
            left: left,
            type: type);

  BackgroundElement.copy(
    BackgroundElement copy, {
    String? url,
    String? id,
    double? height,
    double? width,
    double? top,
    double? left,
  }) : this(
          url: url ?? copy.url,
          id: id ?? copy.id,
          height: height ?? copy.height,
          width: width ?? copy.width,
          top: top ?? copy.top,
          left: left ?? copy.left,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'url': url,
      'height': height == double.infinity ? 'Infinity' : height,
      'width': width == double.infinity ? 'Infinity' : width,
      'top': top,
      'left': left,
      'type': type == ElementType.text
          ? 'ElementType.text'
          : 'ElementType.background',
    };
  }

  factory BackgroundElement.fromJson(Map<String, dynamic> json) {
    return BackgroundElement(
      url: json['url'] as String,
      id: json['id'] as String,
      height: json['height'] == 'Infinity'
          ? double.infinity
          : json['height']?.toDouble() ?? double.infinity,
      width: json['height'] == 'Infinity'
          ? double.infinity
          : json['width']?.toDouble() ?? double.infinity,
      top: json['top'] as double,
      left: json['left'] as double,
      type: json['type'] == 'ElmentType.background'
          ? ElementType.background
          : ElementType.text,
    );
  }
}
