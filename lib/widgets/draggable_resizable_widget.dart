import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meme_generator/constants/models/text_element.dart';
import 'package:meme_generator/provider/app_provider.dart';

import '../constants/models/text_element.dart';

const ballDiameter = 15.0;
const discreteStepSize = 50;

class DraggableResizableWidget extends HookConsumerWidget {
  const DraggableResizableWidget({
    Key? key,
    required this.child,
    required this.isNotActive,
    required this.onPressed,
    required this.textElement,
    required this.widgetTop,
    required this.widgetLeft,
    required this.index,
    required this.isNotActiveNotifier,
  }) : super(key: key);

  final Widget child;
  final bool isNotActive;
  final TextElement textElement;
  final void Function() onPressed;
  final double widgetTop;
  final double widgetLeft;
  final int index;
  final ValueNotifier<bool> isNotActiveNotifier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final updateTextWidget = ref.read(appProvider.notifier).updateTextWidget;
    final textWidgets = ref.read(appProvider).textWidgets;
    final height = useState(textElement.height);
    final width = useState(textElement.width);
    final top = useState(textElement.top);
    final left = useState(textElement.left);
    final cumulativeDy = useState(textElement.cumulativeDy);
    final cumulativeDx = useState(textElement.cumulativeDx);
    final cumulativeMid = useState(textElement.cumulativeMid);

    useEffect(() {
      height.value = textElement.height;
      width.value = textElement.width;
      top.value = textElement.top;
      left.value = textElement.left;
      cumulativeDy.value = textElement.cumulativeDy;
      cumulativeDx.value = textElement.cumulativeDx;
      cumulativeMid.value = textElement.cumulativeMid;
      return null;
    }, [textElement]);
    useEffect(() {
      height.value = textElement.height;
      width.value = textElement.width;
      top.value = textElement.top;
      left.value = textElement.left;
      cumulativeDy.value = textElement.cumulativeDy;
      cumulativeDx.value = textElement.cumulativeDx;
      cumulativeMid.value = textElement.cumulativeMid;
      return null;
    }, []);
    return Stack(
      children: <Widget>[
        Positioned(
          top: top.value,
          left: left.value,
          child: Container(
            height: height.value,
            width: width.value,
            alignment: Alignment.center,
            decoration: !isNotActive
                ? BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.blue.withOpacity(0.8),
                      width: 1,
                    ),
                  )
                : const BoxDecoration(
                    color: Colors.white,
                  ),
            child: Wrap(
              children: [
                child,
              ],
            ),
          ),
        ),
        // top left
        Positioned(
          top: top.value - ballDiameter,
          left: left.value - ballDiameter,
          child: !isNotActive
              ? Container(
                  width: ballDiameter + 15,
                  height: ballDiameter + 15,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.8),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: IconButton(
                      onPressed: () {
                        isNotActiveNotifier.value = true;

                        ref
                            .watch(appProvider.notifier)
                            .removeTextWidget(textElement.id);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ),
                )
              : Container(child: null),
        ),
        // top middle
        Positioned(
          top: top.value - ballDiameter / 2,
          left: left.value + width.value / 2 - ballDiameter / 2,
          child: DraggableBall(
            isBallVisible: !isNotActive,
            onDrag: (dx, dy) {
              cumulativeDy.value -= dy;
              if (cumulativeDy.value >= discreteStepSize) {
                var newHeight = height.value + discreteStepSize;
                height.value = newHeight > 0 ? newHeight : 0;
                cumulativeDy.value = 0;
              } else if (cumulativeDy.value <= -discreteStepSize) {
                var newHeight = height.value - discreteStepSize;
                height.value = newHeight > 0 ? newHeight : 0;
                cumulativeDy.value = 0;
              }
            },
            onDragEnd: (dx, dy) {
              updateTextWidget(
                textElement.id,
                cumulativeDy: cumulativeDy.value,
                height: height.value,
                width: width.value,
              );
            },
          ),
        ),
        // top right
        Positioned(
          top: top.value - ballDiameter,
          left: left.value + width.value - ballDiameter,
          child: !isNotActive
              ? Container(
                  width: ballDiameter + 15,
                  height: ballDiameter + 15,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.8),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: IconButton(
                      onPressed: onPressed,
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ),
                )
              : Container(child: null),
        ),
        // center right
        Positioned(
          top: top.value + height.value / 2 - ballDiameter / 2,
          left: left.value + width.value - ballDiameter / 2,
          child: DraggableBall(
            isBallVisible: !isNotActive,
            onDrag: (dx, dy) {
              cumulativeDx.value += dx;

              if (cumulativeDx.value >= discreteStepSize) {
                var newWidth = width.value + discreteStepSize;
                width.value = newWidth > 0 ? newWidth : 0;
                cumulativeDx.value = 0;
              } else if (cumulativeDx.value <= -discreteStepSize) {
                var newWidth = width.value - discreteStepSize;
                width.value = newWidth > 0 ? newWidth : 0;
                cumulativeDx.value = 0;
              }
            },
            onDragEnd: (dx, dy) {
              updateTextWidget(
                textElement.id,
                cumulativeDx: cumulativeDx.value,
                height: height.value,
                width: width.value,
              );
            },
          ),
        ),
        // bottom right
        Positioned(
          top: top.value + height.value - ballDiameter / 2,
          left: left.value + width.value - ballDiameter / 2,
          child: DraggableBall(
            isBallVisible: !isNotActive,
            onDrag: (dx, dy) {
              var mid = (dx + dy) / 2;

              cumulativeMid.value += 2 * mid;
              if (cumulativeMid.value >= discreteStepSize) {
                var newHeight = height.value + discreteStepSize;
                height.value = newHeight > 0 ? newHeight : 0;
                var newWidth = width.value + discreteStepSize;
                width.value = newWidth > 0 ? newWidth : 0;
                cumulativeMid.value = 0;
              } else if (cumulativeMid.value <= -discreteStepSize) {
                var newHeight = height.value - discreteStepSize;
                height.value = newHeight > 0 ? newHeight : 0;
                var newWidth = width.value - discreteStepSize;
                width.value = newWidth > 0 ? newWidth : 0;
                cumulativeMid.value = 0;
              }
            },
            onDragEnd: (dx, dy) {
              updateTextWidget(
                textElement.id,
                cumulativeMid: cumulativeMid.value,
                height: height.value,
                width: width.value,
              );
            },
          ),
        ),
        // bottom center
        Positioned(
          top: top.value + height.value - ballDiameter / 2,
          left: left.value + width.value / 2 - ballDiameter / 2,
          child: DraggableBall(
            isBallVisible: !isNotActive,
            onDrag: (dx, dy) {
              cumulativeDy.value += dy;

              if (cumulativeDy.value >= discreteStepSize) {
                var newHeight = height.value + discreteStepSize;
                height.value = newHeight > 0 ? newHeight : 0;
                cumulativeDy.value = 0;
              } else if (cumulativeDy.value <= -discreteStepSize) {
                var newHeight = height.value - discreteStepSize;
                height.value = newHeight > 0 ? newHeight : 0;
                cumulativeDy.value = 0;
              }
            },
            onDragEnd: (dx, dy) {
              updateTextWidget(
                textElement.id,
                cumulativeDy: cumulativeDy.value,
                height: height.value,
                width: width.value,
              );
            },
          ),
        ),
        // bottom left
        Positioned(
          top: top.value + height.value - ballDiameter / 2,
          left: left.value - ballDiameter / 2,
          child: DraggableBall(
            isBallVisible: !isNotActive,
            onDrag: (dx, dy) {
              var mid = ((dx * -1) + dy) / 2;

              cumulativeMid.value += 2 * mid;
              if (cumulativeMid.value >= discreteStepSize) {
                var newHeight = height.value + discreteStepSize;
                height.value = newHeight > 0 ? newHeight : 0;
                var newWidth = width.value + discreteStepSize;
                width.value = newWidth > 0 ? newWidth : 0;
                cumulativeMid.value = 0;
              } else if (cumulativeMid.value <= -discreteStepSize) {
                var newHeight = height.value - discreteStepSize;
                height.value = newHeight > 0 ? newHeight : 0;
                var newWidth = width.value - discreteStepSize;
                width.value = newWidth > 0 ? newWidth : 0;
                cumulativeMid.value = 0;
              }
            },
            onDragEnd: (dx, dy) {
              updateTextWidget(
                textElement.id,
                cumulativeMid: cumulativeMid.value,
                height: height.value,
                width: width.value,
              );
            },
          ),
        ),
        //left center
        Positioned(
          top: top.value + height.value / 2 - ballDiameter / 2,
          left: left.value - ballDiameter / 2,
          child: DraggableBall(
            isBallVisible: !isNotActive,
            onDrag: (dx, dy) {
              cumulativeDx.value -= dx;

              if (cumulativeDx.value >= discreteStepSize) {
                var newWidth = width.value + discreteStepSize;
                width.value = newWidth > 0 ? newWidth : 0;
                cumulativeDx.value = 0;
              } else if (cumulativeDx.value <= -discreteStepSize) {
                var newWidth = width.value - discreteStepSize;
                width.value = newWidth > 0 ? newWidth : 0;
                cumulativeDx.value = 0;
              }
            },
            onDragEnd: (dx, dy) {
              updateTextWidget(
                textElement.id,
                cumulativeDx: cumulativeDx.value,
                height: height.value,
                width: width.value,
              );
            },
          ),
        ),
        // center center
        Positioned(
          top: top.value + height.value / 2 - ballDiameter / 2,
          left: left.value + width.value / 2 - ballDiameter / 2,
          child: DraggableBall(
            isBallVisible: false,
            onDrag: (dx, dy) {
              top.value = top.value + dy;
              left.value = left.value + dx;
            },
            onDragEnd: (dx, dy) {
              ref.watch(appProvider.notifier).updateTextWidget(
                    textElement.id,
                    top: top.value + dy,
                    left: left.value + dx,
                    width: width.value,
                    height: height.value,
                  );
            },
          ),
        ),
      ],
    );
  }
}

class DraggableBall extends HookWidget {
  const DraggableBall({
    Key? key,
    required this.onDrag,
    this.isBallVisible = true,
    required this.onDragEnd,
  }) : super(key: key);
  final bool isBallVisible;
  final void Function(double, double) onDrag;
  final void Function(double, double) onDragEnd;

  @override
  Widget build(BuildContext context) {
    final initX = useState<double>(0);
    final initY = useState<double>(0);

    void _handleDrag(DragStartDetails details) {
      initX.value = details.globalPosition.dx;
      initY.value = details.globalPosition.dy;
    }

    void _handleUpdate(DragUpdateDetails details) {
      final dx = details.globalPosition.dx - initX.value;
      final dy = details.globalPosition.dy - initY.value;
      initX.value = details.globalPosition.dx;
      initY.value = details.globalPosition.dy;
      onDrag(dx, dy);
    }

    void _handleDragEnd(DragEndDetails details) {
      onDragEnd(
        details.velocity.pixelsPerSecond.dx,
        details.velocity.pixelsPerSecond.dy,
      );
    }

    return GestureDetector(
      onPanStart: _handleDrag,
      onPanUpdate: _handleUpdate,
      onPanEnd: _handleDragEnd,
      child: Container(
        width: ballDiameter,
        height: ballDiameter,
        decoration: BoxDecoration(
          color:
              isBallVisible ? Colors.blue.withOpacity(0.5) : Colors.transparent,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
