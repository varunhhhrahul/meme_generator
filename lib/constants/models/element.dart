enum ElementType { text, background }

class Element {
  final String id;
  final ElementType type;
  final double height;
  final double width;
  final double top;
  final double left;

  const Element({
    required this.id,
    required this.type,
    required this.height,
    required this.width,
    required this.top,
    required this.left,
  });

  Element.copy(
    Element copy, {
    String? id,
    ElementType? type,
    double? height,
    double? width,
    double? top,
    double? left,
  }) : this(
          id: id ?? copy.id,
          type: type ?? copy.type,
          height: height ?? copy.height,
          width: width ?? copy.width,
          top: top ?? copy.top,
          left: left ?? copy.left,
        );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'height': height,
      'width': width,
      'top': top,
      'left': left,
    };
  }

  factory Element.fromJson(Map<String, dynamic> json) {
    return Element(
      id: json['id'] as String,
      type: json['type'] as ElementType,
      height: json['height'] as double,
      width: json['width'] as double,
      top: json['top'] as double,
      left: json['left'] as double,
    );
  }
}
