import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/counter.dart';

part 'counter_event.dart';
part 'counter_state.dart';

/// カウンターの状態管理を担う Bloc。
///
/// 加算・減算・リセットの計算と、状態の組み立て・偶奇判定といった
/// 「ヘルパー関数」をこの Bloc 内に閉じ込めている。
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterState.initial()) {
    on<CounterIncremented>(_onIncremented);
    on<CounterDecremented>(_onDecremented);
    on<CounterReset>(_onReset);
  }

  void _onIncremented(CounterIncremented event, Emitter<CounterState> emit) {
    emit(_stateFrom(_incrementBy(event.step)));
  }

  void _onDecremented(CounterDecremented event, Emitter<CounterState> emit) {
    emit(_stateFrom(_decrementBy(event.step)));
  }

  void _onReset(CounterReset event, Emitter<CounterState> emit) {
    emit(_stateFrom(const Counter(value: 0)));
  }

  // ---- ヘルパー関数（Bloc 内に実装） ----

  /// 現在の状態（[CounterState]）からドメインの [Counter] を組み立てる。
  Counter get _currentCounter => Counter(value: state.count);

  /// 現在値を [step] だけ加算した [Counter] を返す。
  Counter _incrementBy(int step) {
    return Counter(value: _currentCounter.value + step);
  }

  /// 現在値を [step] だけ減算した [Counter] を返す。
  Counter _decrementBy(int step) {
    return Counter(value: _currentCounter.value - step);
  }

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
