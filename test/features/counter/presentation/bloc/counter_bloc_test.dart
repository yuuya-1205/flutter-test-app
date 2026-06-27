import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_test_app/features/counter/presentation/bloc/counter_bloc.dart';

void main() {
  test('initial state is CounterState.initial()', () {
    expect(CounterBloc().state, const CounterState.initial());
  });

  group('CounterIncremented', () {
    blocTest<CounterBloc, CounterState>(
      '1 加算して odd の状態を emit する',
      build: CounterBloc.new,
      act: (bloc) => bloc.add(const CounterIncremented()),
      expect: () => const [
        CounterState(count: 1, parity: CounterParity.odd),
      ],
    );

    blocTest<CounterBloc, CounterState>(
      'step を指定すると even の状態（2）を emit する',
      build: CounterBloc.new,
      act: (bloc) => bloc.add(const CounterIncremented(step: 2)),
      expect: () => const [
        CounterState(count: 2, parity: CounterParity.even),
      ],
    );
  });

  group('CounterDecremented', () {
    blocTest<CounterBloc, CounterState>(
      '1 減算して odd の状態（-1）を emit する',
      build: CounterBloc.new,
      act: (bloc) => bloc.add(const CounterDecremented()),
      expect: () => const [
        CounterState(count: -1, parity: CounterParity.odd),
      ],
    );
  });

  group('CounterReset', () {
    blocTest<CounterBloc, CounterState>(
      '初期状態（0 / even）を emit する',
      build: CounterBloc.new,
      // 初期状態と同一の状態は emit されないため、非初期状態を seed してから
      // reset の遷移（0 / even への変化）を確認する。
      seed: () => const CounterState(count: 5, parity: CounterParity.odd),
      act: (bloc) => bloc.add(const CounterReset()),
      expect: () => const [
        CounterState(count: 0, parity: CounterParity.even),
      ],
    );
  });
}
