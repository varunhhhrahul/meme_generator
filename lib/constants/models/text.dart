class TextElement {
  final String id;
  final String text;
  final double height;
  final double width;
  final double cumulativeDy;
  final double cumulativeDx;
  final double cumulativeMid;

  TextElement({
    required this.id,
    required this.text,
    this.height = 100,
    this.width = 200,
    this.cumulativeDy = 0,
    this.cumulativeDx = 0,
    this.cumulativeMid = 0,
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
  }) : this(
          id: id ?? copy.id,
          text: text ?? copy.text,
          height: height ?? copy.height,
          width: width ?? copy.width,
          cumulativeDy: cumulativeDy ?? copy.cumulativeDy,
          cumulativeDx: cumulativeDx ?? copy.cumulativeDx,
          cumulativeMid: cumulativeMid ?? copy.cumulativeMid,
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
    };
  }

  factory TextElement.fromJson(Map<String, dynamic> json) {
    return TextElement(
      id: json['id'] ?? '',
      text: json['text'] ?? '',
      height: json['height']?.toDouble() ?? 0.0,
      width: json['width']?.toDouble() ?? 0.0,
      cumulativeDy: json['cumulativeDy']?.toDouble() ?? 0.0,
      cumulativeDx: json['cumulativeDx']?.toDouble() ?? 0.0,
      cumulativeMid: json['cumulativeMid']?.toDouble() ?? 0.0,
    );
  }
}
