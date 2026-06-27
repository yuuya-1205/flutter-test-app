import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_test_app/features/counter/domain/entities/counter.dart';
import 'package:flutter_test_app/features/counter/domain/usecases/decrement_counter.dart';
import 'package:flutter_test_app/features/counter/domain/usecases/increment_counter.dart';
import 'package:flutter_test_app/features/counter/domain/usecases/reset_counter.dart';
import 'package:flutter_test_app/features/counter/presentation/bloc/counter_bloc.dart';

class MockIncrementCounter extends Mock implements IncrementCounter {}

class MockDecrementCounter extends Mock implements DecrementCounter {}

class MockResetCounter extends Mock implements ResetCounter {}

void main() {
  late MockIncrementCounter incrementCounter;
  late MockDecrementCounter decrementCounter;
  late MockResetCounter resetCounter;

  CounterBloc buildBloc() {
    return CounterBloc(
      incrementCounter: incrementCounter,
      decrementCounter: decrementCounter,
      resetCounter: resetCounter,
    );
  }

  setUpAll(() {
    // any() で Counter を扱うためのフォールバック値を登録する。
    registerFallbackValue(const Counter.initial());
  });

  setUp(() {
    incrementCounter = MockIncrementCounter();
    decrementCounter = MockDecrementCounter();
    resetCounter = MockResetCounter();
  });

  test('initial state is CounterState.initial()', () {
    expect(buildBloc().state, const CounterState.initial());
  });

  group('CounterIncremented', () {
    blocTest<CounterBloc, CounterState>(
      'odd の状態を emit し、現在値とともにユースケースを呼び出す',
      setUp: () {
        when(
          () => incrementCounter(any(), step: any(named: 'step')),
        ).thenReturn(const Counter(value: 1));
      },
      build: buildBloc,
      act: (bloc) => bloc.add(const CounterIncremented()),
      expect: () => const [
        CounterState(count: 1, parity: CounterParity.odd),
      ],
      verify: (_) {
        verify(
          () => incrementCounter(const Counter(value: 0), step: 1),
        ).called(1);
      },
    );

    blocTest<CounterBloc, CounterState>(
      'step を指定すると even の状態（2）を emit する',
      setUp: () {
        when(
          () => incrementCounter(any(), step: any(named: 'step')),
        ).thenReturn(const Counter(value: 2));
      },
      build: buildBloc,
      act: (bloc) => bloc.add(const CounterIncremented(step: 2)),
      expect: () => const [
        CounterState(count: 2, parity: CounterParity.even),
      ],
      verify: (_) {
        verify(
          () => incrementCounter(const Counter(value: 0), step: 2),
        ).called(1);
      },
    );
  });

  group('CounterDecremented', () {
    blocTest<CounterBloc, CounterState>(
      '減算後の状態を emit する',
      setUp: () {
        when(
          () => decrementCounter(any(), step: any(named: 'step')),
        ).thenReturn(const Counter(value: -1));
      },
      build: buildBloc,
      act: (bloc) => bloc.add(const CounterDecremented()),
      expect: () => const [
        CounterState(count: -1, parity: CounterParity.odd),
      ],
      verify: (_) {
        verify(
          () => decrementCounter(const Counter(value: 0), step: 1),
        ).called(1);
      },
    );
  });

  group('CounterReset', () {
    blocTest<CounterBloc, CounterState>(
      '初期状態（0 / even）を emit する',
      setUp: () {
        when(resetCounter.call).thenReturn(const Counter.initial());
      },
      build: buildBloc,
      // 初期状態と同一の状態は emit されないため、非初期状態を seed してから
      // reset の遷移（0 / even への変化）を確認する。
      seed: () => const CounterState(count: 5, parity: CounterParity.odd),
      act: (bloc) => bloc.add(const CounterReset()),
      expect: () => const [
        CounterState(count: 0, parity: CounterParity.even),
      ],
      verify: (_) {
        verify(resetCounter.call).called(1);
      },
    );
  });
}
