import 'package:flutter/material.dart';
import 'package:meme_generator/constants/models/text_element.dart';

class DraggableResizableWidget extends StatefulWidget {
  const DraggableResizableWidget({
    Key? key,
    required this.child,
    required this.isNotActive,
    required this.onPressed,
    required this.removeTextWidget,
    required this.textElement,
    required this.updateTextWidget,
  }) : super(key: key);

  final Widget child;
  final bool isNotActive;
  final TextElement textElement;
  final void Function() onPressed;
  final void Function() removeTextWidget;
  final void Function(
    String, {
    double? cumulativeDx,
    double? cumulativeDy,
    double? cumulativeMid,
    double? height,
    String? id,
    String? text,
    double? width,
    double? top,
    double? left,
  }) updateTextWidget;
  @override
  _ResizebleWidgetState createState() => _ResizebleWidgetState();
}

const ballDiameter = 15.0;
const discreteStepSize = 50;

class _ResizebleWidgetState extends State<DraggableResizableWidget> {
  // double height = 100;
  // double width = 200;

  // double top = 20;
  // double left = 50;

  // double cumulativeDy = 0;
  // double cumulativeDx = 0;
  // double cumulativeMid = 0;

  void onDrag(double dx, double dy) {
    // var newHeight = height + dy;
    // var newWidth = width + dx;

    var newHeight = widget.textElement.height + dy;
    var newWidth = widget.textElement.width + dx;
    setState(() {
      // height = newHeight > 0 ? newHeight : 0;
      // width = newWidth > 0 ? newWidth : 0;
      widget.updateTextWidget(widget.textElement.id,
          height: newHeight > 0 ? newHeight : 0,
          width: newWidth > 0 ? newWidth : 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          // top: top,
          // left: left,
          top: widget.textElement.top,
          left: widget.textElement.left,
          child: Container(
            // height: height,
            // width: width,
            height: widget.textElement.height,
            width: widget.textElement.width,
            alignment: Alignment.center,
            decoration: !widget.isNotActive
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

            // color: Colors.red[100],
            // color: Colors.white,
            child: Wrap(
              children: [
                widget.child,
              ],
            ),
          ),
        ),
        // top left
        Positioned(
          // top: top - ballDiameter,
          // left: left - ballDiameter,
          top: widget.textElement.top - ballDiameter,
          left: widget.textElement.left - ballDiameter,
          child: !widget.isNotActive
              ? Container(
                  width: ballDiameter + 15,
                  height: ballDiameter + 15,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.8),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: IconButton(
                      onPressed: widget.removeTextWidget,
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ),
                )
              : Container(child: null),
          // top: top - ballDiameter / 2,
          // left: left - ballDiameter / 2,
          // child: ManipulatingBall(
          //   isBallVisible: !widget.isNotActive,
          //   onDrag: (dx, dy) {
          //     var mid = (dx + dy) / 2;
          //     cumulativeMid -= 2 * mid;
          //     if (cumulativeMid >= discreteStepSize) {
          //       setState(() {
          //         var newHeight = height + discreteStepSize;
          //         height = newHeight > 0 ? newHeight : 0;
          //         var newWidth = width + discreteStepSize;
          //         width = newWidth > 0 ? newWidth : 0;
          //         cumulativeMid = 0;
          //       });
          //     } else if (cumulativeMid <= -discreteStepSize) {
          //       setState(() {
          //         var newHeight = height - discreteStepSize;
          //         height = newHeight > 0 ? newHeight : 0;
          //         var newWidth = width - discreteStepSize;
          //         width = newWidth > 0 ? newWidth : 0;
          //         cumulativeMid = 0;
          //       });
          //     }
          //   },
          // ),
        ),
        // top middle
        Positioned(
          // top: top - ballDiameter / 2,
          top: widget.textElement.top - ballDiameter / 2,
          // left: left + width / 2 - ballDiameter / 2,
          left: widget.textElement.left +
              widget.textElement.width / 2 -
              ballDiameter / 2,
          child: ManipulatingBall(
            isBallVisible: !widget.isNotActive,
            onDrag: (dx, dy) {
              // cumulativeDy -= dy;
              // if (cumulativeDy >= discreteStepSize) {
              //   setState(() {
              //     var newHeight = height + discreteStepSize;
              //     height = newHeight > 0 ? newHeight : 0;
              //     cumulativeDy = 0;
              //   });
              // } else if (cumulativeDy <= -discreteStepSize) {
              //   setState(() {
              //     var newHeight = height - discreteStepSize;
              //     height = newHeight > 0 ? newHeight : 0;
              //     cumulativeDy = 0;
              //   });
              // }
              // var cumulativeDy = widget.textElement.cumulativeDy;
              // cumulativeDy -= dy;
              widget.updateTextWidget(widget.textElement.id,
                  cumulativeDy: widget.textElement.cumulativeDy - dy);
              if (widget.textElement.cumulativeDy >= discreteStepSize) {
                setState(() {
                  var newHeight = widget.textElement.height + discreteStepSize;
                  widget.updateTextWidget(widget.textElement.id,
                      height: newHeight > 0 ? newHeight : 0, cumulativeDy: 0);
                });
              } else if (widget.textElement.cumulativeDy <= -discreteStepSize) {
                setState(() {
                  var newHeight = widget.textElement.height - discreteStepSize;
                  widget.updateTextWidget(widget.textElement.id,
                      height: newHeight > 0 ? newHeight : 0, cumulativeDy: 0);

                  // var newHeight = height - discreteStepSize;
                  // height = newHeight > 0 ? newHeight : 0;
                  // cumulativeDy = 0;
                });
              }
            },
          ),
        ),
        // top right
        Positioned(
          // top: top - ballDiameter / 2,
          // left: left + width - ballDiameter / 2,
          top: widget.textElement.top - ballDiameter,
          // left: left + width - ballDiameter,
          left:
              widget.textElement.left + widget.textElement.width - ballDiameter,
          child: !widget.isNotActive
              ? Container(
                  width: ballDiameter + 15,
                  height: ballDiameter + 15,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.8),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: IconButton(
                      onPressed: widget.onPressed,
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ),
                )
              : Container(child: null),
          //  ManipulatingBall(
          //   isBallVisible: !widget.isNotActive,
          //   onDrag: (dx, dy) {
          //     var mid = (dx + (dy * -1)) / 2;
          //     cumulativeMid += 2 * mid;
          //     if (cumulativeMid >= discreteStepSize) {
          //       setState(() {
          //         var newHeight = height + discreteStepSize;
          //         height = newHeight > 0 ? newHeight : 0;
          //         var newWidth = width + discreteStepSize;
          //         width = newWidth > 0 ? newWidth : 0;
          //         cumulativeMid = 0;
          //       });
          //     } else if (cumulativeMid <= -discreteStepSize) {
          //       setState(() {
          //         var newHeight = height - discreteStepSize;
          //         height = newHeight > 0 ? newHeight : 0;
          //         var newWidth = width - discreteStepSize;
          //         width = newWidth > 0 ? newWidth : 0;
          //         cumulativeMid = 0;
          //       });
          //     }
          //   },
          // ),
        ),
        // center right
        Positioned(
          // top: top + height / 2 - ballDiameter / 2,
          // left: left + width - ballDiameter / 2,
          top: widget.textElement.top +
              widget.textElement.height / 2 -
              ballDiameter / 2,
          left: widget.textElement.left +
              widget.textElement.width -
              ballDiameter / 2,
          child: ManipulatingBall(
            isBallVisible: !widget.isNotActive,
            onDrag: (dx, dy) {
              // var cumulativeDx = widget.textElement.cumulativeDx;
              // cumulativeDx += dx;

              widget.updateTextWidget(widget.textElement.id,
                  cumulativeDx: widget.textElement.cumulativeDx + dx);

              // if (cumulativeDx >= discreteStepSize) {
              //   setState(() {
              //     var newWidth = width + discreteStepSize;
              //     width = newWidth > 0 ? newWidth : 0;
              //     cumulativeDx = 0;
              //   });
              // } else if (cumulativeDx <= -discreteStepSize) {
              //   setState(() {
              //     var newWidth = width - discreteStepSize;
              //     width = newWidth > 0 ? newWidth : 0;
              //     cumulativeDx = 0;
              //   });
              // }
              if (widget.textElement.cumulativeDx >= discreteStepSize) {
                setState(() {
                  var newWidth = widget.textElement.width + discreteStepSize;
                  // width = newWidth > 0 ? newWidth : 0;
                  // cumulativeDx = 0;
                  widget.updateTextWidget(widget.textElement.id,
                      width: newWidth > 0 ? newWidth : 0, cumulativeDx: 0);
                });
              } else if (widget.textElement.cumulativeDx <= -discreteStepSize) {
                setState(() {
                  var newWidth = widget.textElement.width - discreteStepSize;
                  // width = newWidth > 0 ? newWidth : 0;
                  // cumulativeDx = 0;
                  widget.updateTextWidget(widget.textElement.id,
                      width: newWidth > 0 ? newWidth : 0, cumulativeDx: 0);
                });
              }
            },
          ),
        ),
        // bottom right
        Positioned(
          // top: top + height - ballDiameter / 2,
          // left: left + width - ballDiameter / 2,
          top: widget.textElement.top +
              widget.textElement.height -
              ballDiameter / 2,
          left: widget.textElement.left +
              widget.textElement.width -
              ballDiameter / 2,
          child: ManipulatingBall(
            isBallVisible: !widget.isNotActive,
            onDrag: (dx, dy) {
              var mid = (dx + dy) / 2;

              // cumulativeMid += 2 * mid;
              // if (cumulativeMid >= discreteStepSize) {
              //   setState(() {
              //     var newHeight = height + discreteStepSize;
              //     height = newHeight > 0 ? newHeight : 0;
              //     var newWidth = width + discreteStepSize;
              //     width = newWidth > 0 ? newWidth : 0;
              //     cumulativeMid = 0;
              //   });
              // } else if (cumulativeMid <= -discreteStepSize) {
              //   setState(() {
              //     var newHeight = height - discreteStepSize;
              //     height = newHeight > 0 ? newHeight : 0;
              //     var newWidth = width - discreteStepSize;
              //     width = newWidth > 0 ? newWidth : 0;
              //     cumulativeMid = 0;
              //   });
              // }
              widget.updateTextWidget(widget.textElement.id,
                  cumulativeMid: widget.textElement.cumulativeMid + 2 * mid);
              //  cumulativeMid += 2 * mid;
              if (widget.textElement.cumulativeMid >= discreteStepSize) {
                setState(() {
                  var newHeight = widget.textElement.height + discreteStepSize;
                  var newWidth = widget.textElement.width + discreteStepSize;
                  widget.updateTextWidget(widget.textElement.id,
                      height: newHeight > 0 ? newHeight : 0,
                      width: newWidth > 0 ? newWidth : 0,
                      cumulativeMid: 0);
                });
              } else if (widget.textElement.cumulativeMid <=
                  -discreteStepSize) {
                setState(() {
                  var newHeight = widget.textElement.height - discreteStepSize;
                  var newWidth = widget.textElement.width - discreteStepSize;

                  widget.updateTextWidget(
                    widget.textElement.id,
                    height: newHeight > 0 ? newHeight : 0,
                    width: newWidth > 0 ? newWidth : 0,
                    cumulativeMid: 0,
                  );
                });
              }
            },
          ),
        ),
        // bottom center
        Positioned(
          // top: top + height - ballDiameter / 2,
          // left: left + width / 2 - ballDiameter / 2,
          top: widget.textElement.top +
              widget.textElement.height -
              ballDiameter / 2,
          left: widget.textElement.left +
              widget.textElement.width / 2 -
              ballDiameter / 2,
          child: ManipulatingBall(
            isBallVisible: !widget.isNotActive,
            onDrag: (dx, dy) {
              // cumulativeDy += dy;

              // if (cumulativeDy >= discreteStepSize) {
              //   setState(() {
              //     var newHeight = height + discreteStepSize;
              //     height = newHeight > 0 ? newHeight : 0;
              //     cumulativeDy = 0;
              //   });
              // } else if (cumulativeDy <= -discreteStepSize) {
              //   setState(() {
              //     var newHeight = height - discreteStepSize;
              //     height = newHeight > 0 ? newHeight : 0;
              //     cumulativeDy = 0;
              //   });
              // }
              widget.updateTextWidget(widget.textElement.id,
                  cumulativeDy: widget.textElement.cumulativeDy + dy);
              // cumulativeDy += dy;

              if (widget.textElement.cumulativeDy >= discreteStepSize) {
                setState(() {
                  var newHeight = widget.textElement.height + discreteStepSize;
                  widget.updateTextWidget(widget.textElement.id,
                      height: newHeight > 0 ? newHeight : 0, cumulativeDy: 0);
                  // height = newHeight > 0 ? newHeight : 0;
                  // cumulativeDy = 0;
                });
              } else if (widget.textElement.cumulativeDy <= -discreteStepSize) {
                setState(() {
                  var newHeight = widget.textElement.height - discreteStepSize;
                  widget.updateTextWidget(widget.textElement.id,
                      height: newHeight > 0 ? newHeight : 0, cumulativeDy: 0);
                });
              }
            },
          ),
        ),
        // bottom left
        Positioned(
          // top: top + height - ballDiameter / 2,
          top: widget.textElement.top +
              widget.textElement.height -
              ballDiameter / 2,
          left: widget.textElement.left - ballDiameter / 2,
          child: ManipulatingBall(
            isBallVisible: !widget.isNotActive,
            onDrag: (dx, dy) {
              var mid = ((dx * -1) + dy) / 2;

              // cumulativeMid += 2 * mid;
              // if (cumulativeMid >= discreteStepSize) {
              //   setState(() {
              //     var newHeight = height + discreteStepSize;
              //     height = newHeight > 0 ? newHeight : 0;
              //     var newWidth = width + discreteStepSize;
              //     width = newWidth > 0 ? newWidth : 0;
              //     cumulativeMid = 0;
              //   });
              // } else if (cumulativeMid <= -discreteStepSize) {
              //   setState(() {
              //     var newHeight = height - discreteStepSize;
              //     height = newHeight > 0 ? newHeight : 0;
              //     var newWidth = width - discreteStepSize;
              //     width = newWidth > 0 ? newWidth : 0;
              //     cumulativeMid = 0;
              //   });
              // }
              widget.updateTextWidget(widget.textElement.id,
                  cumulativeMid: widget.textElement.cumulativeMid + 2 * mid);
              // cumulativeMid += 2 * mid;
              if (widget.textElement.cumulativeMid >= discreteStepSize) {
                setState(() {
                  var newHeight = widget.textElement.height + discreteStepSize;
                  var newWidth = widget.textElement.width + discreteStepSize;
                  widget.updateTextWidget(
                    widget.textElement.id,
                    height: newHeight > 0 ? newHeight : 0,
                    width: newWidth > 0 ? newWidth : 0,
                    cumulativeMid: 0,
                  );
                });
              } else if (widget.textElement.cumulativeMid <=
                  -discreteStepSize) {
                setState(() {
                  var newHeight = widget.textElement.height - discreteStepSize;
                  var newWidth = widget.textElement.width - discreteStepSize;
                  widget.updateTextWidget(
                    widget.textElement.id,
                    height: newHeight > 0 ? newHeight : 0,
                    width: newWidth > 0 ? newWidth : 0,
                    cumulativeMid: 0,
                  );
                });
              }
            },
          ),
        ),
        //left center
        Positioned(
          // top: top + height / 2 - ballDiameter / 2,
          top: widget.textElement.top +
              widget.textElement.height / 2 -
              ballDiameter / 2,
          left: widget.textElement.left - ballDiameter / 2,
          child: ManipulatingBall(
            isBallVisible: !widget.isNotActive,
            onDrag: (dx, dy) {
              // cumulativeDx -= dx;

              // if (cumulativeDx >= discreteStepSize) {
              //   setState(() {
              //     var newWidth = width + discreteStepSize;
              //     width = newWidth > 0 ? newWidth : 0;
              //     cumulativeDx = 0;
              //   });
              // } else if (cumulativeDx <= -discreteStepSize) {
              //   setState(() {
              //     var newWidth = width - discreteStepSize;
              //     width = newWidth > 0 ? newWidth : 0;
              //     cumulativeDx = 0;
              //   });
              // }
              widget.updateTextWidget(widget.textElement.id,
                  cumulativeDx: widget.textElement.cumulativeDx - dx);
              //  cumulativeDx -= dx;

              if (widget.textElement.cumulativeDx >= discreteStepSize) {
                setState(() {
                  var newWidth = widget.textElement.width + discreteStepSize;
                  widget.updateTextWidget(widget.textElement.id,
                      width: newWidth > 0 ? newWidth : 0, cumulativeDx: 0);
                  // width = newWidth > 0 ? newWidth : 0;
                  // cumulativeDx = 0;
                });
              } else if (widget.textElement.cumulativeDx <= -discreteStepSize) {
                setState(() {
                  var newWidth = widget.textElement.width - discreteStepSize;
                  widget.updateTextWidget(widget.textElement.id,
                      width: newWidth > 0 ? newWidth : 0, cumulativeDx: 0);
                  // width = newWidth > 0 ? newWidth : 0;
                  // cumulativeDx = 0;
                });
              }
            },
          ),
        ),
        // center center
        Positioned(
          // top: top + height / 2 - ballDiameter / 2,
          // left: left + width / 2 - ballDiameter / 2,
          top: widget.textElement.top +
              widget.textElement.height / 2 -
              ballDiameter / 2,
          left: widget.textElement.left +
              widget.textElement.width / 2 -
              ballDiameter / 2,
          child: ManipulatingBall(
            isBallVisible: false,
            onDrag: (dx, dy) {
              setState(() {
                // top = top + dy;
                // left = left + dx;
                widget.updateTextWidget(
                  widget.textElement.id,
                  top: widget.textElement.top + dy,
                  left: widget.textElement.left + dx,
                );
              });
            },
          ),
        ),
      ],
    );
  }
}

class ManipulatingBall extends StatefulWidget {
  final bool isBallVisible;
  const ManipulatingBall(
      {Key? key, required this.onDrag, this.isBallVisible = true})
      : super(key: key);

  final Function onDrag;

  @override
  _ManipulatingBallState createState() => _ManipulatingBallState();
}

class _ManipulatingBallState extends State<ManipulatingBall> {
  late double initX;
  late double initY;

  _handleDrag(details) {
    print(details);

    setState(() {
      initX = details.globalPosition.dx;
      initY = details.globalPosition.dy;
    });
  }

  _handleUpdate(details) {
    var dx = details.globalPosition.dx - initX;
    var dy = details.globalPosition.dy - initY;
    initX = details.globalPosition.dx;
    initY = details.globalPosition.dy;
    widget.onDrag(dx, dy);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: _handleDrag,
      onPanUpdate: _handleUpdate,
      child: Container(
        width: ballDiameter,
        height: ballDiameter,
        decoration: BoxDecoration(
          color: widget.isBallVisible
              ? Colors.blue.withOpacity(0.5)
              : Colors.transparent,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
