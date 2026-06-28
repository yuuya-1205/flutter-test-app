// カウンター画面のウィジェットテスト。
//
// CounterBloc を組み込んだ MyApp を起動し、UI 操作で状態が変化することを確認する。

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_test_app/main.dart';

void main() {
  testWidgets('Counter increments / decrements', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // 初期値は 0。
    expect(find.text('0'), findsOneWidget);

    // 加算 -> 1。
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.text('1'), findsOneWidget);

    // 減算 -> 0 に戻る。
    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();
    expect(find.text('0'), findsOneWidget);
  });
}
