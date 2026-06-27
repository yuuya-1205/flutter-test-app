import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/counter.dart';
import '../../domain/usecases/decrement_counter.dart';
import '../../domain/usecases/increment_counter.dart';
import '../../domain/usecases/reset_counter.dart';

part 'counter_event.dart';
part 'counter_state.dart';

/// カウンターの状態管理を担う Bloc。
///
/// 加算・減算・リセットの各ユースケース（ドメイン層）を呼び出し、
/// その結果を画面用の [CounterState] に変換する。状態の組み立てや
/// 偶奇判定といった「ヘルパー関数」はこの Bloc 内に閉じ込めている。
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc({
    required IncrementCounter incrementCounter,
    required DecrementCounter decrementCounter,
    required ResetCounter resetCounter,
  }) : _incrementCounter = incrementCounter,
       _decrementCounter = decrementCounter,
       _resetCounter = resetCounter,
       super(const CounterState.initial()) {
    on<CounterIncremented>(_onIncremented);
    on<CounterDecremented>(_onDecremented);
    on<CounterReset>(_onReset);
  }

  final IncrementCounter _incrementCounter;
  final DecrementCounter _decrementCounter;
  final ResetCounter _resetCounter;

  void _onIncremented(CounterIncremented event, Emitter<CounterState> emit) {
    final counter = _incrementCounter(_currentCounter, step: event.step);
    emit(_stateFrom(counter));
  }

  void _onDecremented(CounterDecremented event, Emitter<CounterState> emit) {
    final counter = _decrementCounter(_currentCounter, step: event.step);
    emit(_stateFrom(counter));
  }

  void _onReset(CounterReset event, Emitter<CounterState> emit) {
    final counter = _resetCounter();
    emit(_stateFrom(counter));
  }

  // ---- ヘルパー関数（Bloc 内に実装） ----

  /// 現在の状態（[CounterState]）からドメインの [Counter] を組み立てる。
  Counter get _currentCounter => Counter(value: state.count);

  /// ドメインの [Counter] から画面用の [CounterState] を組み立てる。
  CounterState _stateFrom(Counter counter) {
    return CounterState(
      count: counter.value,
      parity: _parityOf(counter.value),
    );
  }

  /// 値の偶奇を判定する。
  CounterParity _parityOf(int value) {
    return value.isEven ? CounterParity.even : CounterParity.odd;
  }
}
