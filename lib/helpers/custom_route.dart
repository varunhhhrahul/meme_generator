import 'package:flutter/material.dart';

// For unnamed routes
class CustomRoute<T> extends MaterialPageRoute<T> {
  CustomRoute({required WidgetBuilder builder, required RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.name == '/') {
      return child;
    }
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}

// For named routes
class CustomPageTransitionBuilder extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    Offset begin = const Offset(0.0, 1.0);

    Offset end = Offset.zero;

    Animatable<Offset> tween = Tween(begin: begin, end: end).chain(
      CurveTween(
        curve: Curves.easeOutCubic,
      ),
    );

    Animation<Offset> offsetAnimation = animation.drive(tween);

    if (route.settings.name == '/') {
      return child;
    }

    return SlideTransition(
      position: offsetAnimation,
      child: child,
    );
  }
}
