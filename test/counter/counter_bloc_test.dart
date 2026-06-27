import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_test_app/counter/counter_bloc.dart';

void main() {
  test('initial state is CounterState(count: 0)', () {
    expect(CounterBloc().state, const CounterState());
  });

  blocTest<CounterBloc, CounterState>(
    'CounterIncremented で count が 1 になる',
    build: CounterBloc.new,
    act: (bloc) => bloc.add(const CounterIncremented()),
    expect: () => const [CounterState(count: 1)],
  );

  blocTest<CounterBloc, CounterState>(
    'CounterDecremented で count が -1 になる',
    build: CounterBloc.new,
    act: (bloc) => bloc.add(const CounterDecremented()),
    expect: () => const [CounterState(count: -1)],
  );
}
