import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_test_app/counter/counter_bloc.dart';

void main() {
  test('initial state is CounterState(count: 0)', () {
    expect(CounterBloc().state, const CounterState());
  });

  test('Event / State は値で比較できる（Equatable）', () {
    expect(const CounterIncremented(), const CounterIncremented());
    expect(const CounterDecremented(), const CounterDecremented());
    expect(const CounterState(count: 1), const CounterState(count: 1));
    expect(
      const CounterState(count: 1),
      isNot(const CounterState(count: 2)),
    );
  });

  test('increment() / decrement() で状態が更新される', () async {
    final bloc = CounterBloc();

    bloc.increment();
    await Future<void>.delayed(Duration.zero);
    expect(bloc.state, const CounterState(count: 1));

    bloc.decrement();
    await Future<void>.delayed(Duration.zero);
    expect(bloc.state, const CounterState(count: 0));

    await bloc.close();
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
