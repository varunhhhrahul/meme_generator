import 'package:meme_generator/constants/models/element.dart';

class TextElement extends Element {
  final String text;
  final double cumulativeDy;
  final double cumulativeDx;
  final double cumulativeMid;

  TextElement({
    required String id,
    required this.text,
    double height = 100,
    double width = 200,
    ElementType type = ElementType.text,
    this.cumulativeDy = 0,
    this.cumulativeDx = 0,
    this.cumulativeMid = 0,
    double top = 20,
    double left = 50,
  }) : super(
          id: id,
          height: height,
          width: width,
          top: top,
          left: left,
          type: type,
        );

  TextElement.copy(
    TextElement copy, {
    String? id,
    String? text,
    double? height,
    double? width,
    double? cumulativeDy,
    double? cumulativeDx,
    double? cumulativeMid,
    double? top,
    double? left,
    ElementType? type,
  }) : this(
          id: id ?? copy.id,
          text: text ?? copy.text,
          height: height ?? copy.height,
          width: width ?? copy.width,
          cumulativeDy: cumulativeDy ?? copy.cumulativeDy,
          cumulativeDx: cumulativeDx ?? copy.cumulativeDx,
          cumulativeMid: cumulativeMid ?? copy.cumulativeMid,
          top: top ?? copy.top,
          left: left ?? copy.left,
          type: type ?? copy.type,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'height': height == double.infinity ? 'Infinity' : height,
      'width': width == double.infinity ? 'Infinity' : width,
      'cumulativeDy': cumulativeDy,
      'cumulativeDx': cumulativeDx,
      'cumulativeMid': cumulativeMid,
      'top': top,
      'left': left,
      'type': type == ElementType.text
          ? 'ElementType.text'
          : 'ElementType.background',
    };
  }

  factory TextElement.fromJson(Map<String, dynamic> json) {
    return TextElement(
      id: json['id'] ?? '',
      text: json['text'] ?? '',
      height: json['height'] == 'Infinity'
          ? double.infinity
          : json['height']?.toDouble() ?? 100,
      width: json['height'] == 'Infinity'
          ? double.infinity
          : json['width']?.toDouble() ?? 200,
      cumulativeDy: json['cumulativeDy']?.toDouble() ?? 0.0,
      cumulativeDx: json['cumulativeDx']?.toDouble() ?? 0.0,
      cumulativeMid: json['cumulativeMid']?.toDouble() ?? 0.0,
      top: json['top']?.toDouble() ?? 20,
      left: json['left']?.toDouble() ?? 50,
      type: json['type'] == 'ElmentType.text'
          ? ElementType.text
          : ElementType.text,
    );
  }
}
