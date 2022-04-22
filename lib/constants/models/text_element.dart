class TextElement {
  final String id;
  final String text;
  final double height;
  final double width;
  final double cumulativeDy;
  final double cumulativeDx;
  final double cumulativeMid;
  final double top;
  final double left;

  TextElement({
    required this.id,
    required this.text,
    this.height = 100,
    this.width = 200,
    this.cumulativeDy = 0,
    this.cumulativeDx = 0,
    this.cumulativeMid = 0,
    this.top = 20,
    this.left = 50,
  });

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
        );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'height': height,
      'width': width,
      'cumulativeDy': cumulativeDy,
      'cumulativeDx': cumulativeDx,
      'cumulativeMid': cumulativeMid,
      'top': top,
      'left': left,
    };
  }

  factory TextElement.fromJson(Map<String, dynamic> json) {
    return TextElement(
      id: json['id'] ?? '',
      text: json['text'] ?? '',
      height: json['height']?.toDouble() ?? 100,
      width: json['width']?.toDouble() ?? 200,
      cumulativeDy: json['cumulativeDy']?.toDouble() ?? 0.0,
      cumulativeDx: json['cumulativeDx']?.toDouble() ?? 0.0,
      cumulativeMid: json['cumulativeMid']?.toDouble() ?? 0.0,
      top: json['top']?.toDouble() ?? 20,
      left: json['left']?.toDouble() ?? 50,
    );
  }
}
