// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meme_generator/constants/models/template.dart';

import 'package:meme_generator/main.dart';
import 'package:meme_generator/utils/json_utils.dart';

void main() {
  testWidgets('Has Grid View', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.runAsync(() async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MyApp(),
        ),
        const Duration(milliseconds: 100),
      );

      expect(find.byType(GridView), findsOneWidget);
    });
  });

  testWidgets('Has Stacked Images in a grid', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.runAsync(() async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MyApp(),
        ),
        const Duration(milliseconds: 100),
      );
      expect(find.byType(Stack), findsWidgets);
    });
  });
}
