// カウンター画面のウィジェットテスト。
//
// 実際の依存（InMemoryCounterRepository + 各ユースケース + CounterBloc）を
// 組み込んだ MyApp を起動し、UI 操作で状態が変化することを確認する。

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_test_app/main.dart';

void main() {
  testWidgets('Counter increments / decrements / resets', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    // 初期値は 0（偶数）。
    expect(find.text('0'), findsOneWidget);
    expect(find.text('even'), findsOneWidget);

    // 加算 -> 1（奇数）。
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.text('1'), findsOneWidget);
    expect(find.text('odd'), findsOneWidget);

    // 減算 -> 0（偶数）に戻る。
    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();
    expect(find.text('0'), findsOneWidget);
    expect(find.text('even'), findsOneWidget);

    // 数回加算してからリセット -> 0 に戻る。
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.text('2'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.refresh));
    await tester.pump();
    expect(find.text('0'), findsOneWidget);
    expect(find.text('even'), findsOneWidget);
  });
}
