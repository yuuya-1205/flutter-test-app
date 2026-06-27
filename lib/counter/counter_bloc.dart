import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// ===== Event =====
// カウンターに対する操作を表すイベント。Bloc と同じファイルにまとめる。

sealed class CounterEvent extends Equatable {
  const CounterEvent();

  @override
  List<Object?> get props => [];
}

/// 加算イベント。
class CounterIncremented extends CounterEvent {
  const CounterIncremented();
}

/// 減算イベント。
class CounterDecremented extends CounterEvent {
  const CounterDecremented();
}

// ===== State =====

/// カウンターの状態。
class CounterState extends Equatable {
  const CounterState({this.count = 0});

  final int count;

  @override
  List<Object?> get props => [count];
}

// ===== Bloc =====

/// カウンターの状態管理を担う Bloc。
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterState()) {
    on<CounterIncremented>(_onIncremented);
    on<CounterDecremented>(_onDecremented);
  }

  /// 加算する（イベントの add を隠蔽した窓口）。
  void increment() => add(const CounterIncremented());

  /// 減算する（イベントの add を隠蔽した窓口）。
  void decrement() => add(const CounterDecremented());

  void _onIncremented(CounterIncremented event, Emitter<CounterState> emit) {
    emit(_stateOf(_movedBy(1)));
  }

  void _onDecremented(CounterDecremented event, Emitter<CounterState> emit) {
    emit(_stateOf(_movedBy(-1)));
  }

  // ---- ヘルパー関数 ----

  /// 現在値を [delta] だけ動かした値を返す。
  int _movedBy(int delta) => state.count + delta;

  /// カウント値から [CounterState] を組み立てる。
  CounterState _stateOf(int count) => CounterState(count: count);
}
