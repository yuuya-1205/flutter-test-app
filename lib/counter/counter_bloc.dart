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

/// 初期値（0）へのリセットイベント。
class CounterReset extends CounterEvent {
  const CounterReset();
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
    on<CounterReset>(_onReset);
  }

  void _onIncremented(CounterIncremented event, Emitter<CounterState> emit) {
    emit(CounterState(count: state.count + 1));
  }

  void _onDecremented(CounterDecremented event, Emitter<CounterState> emit) {
    emit(CounterState(count: state.count - 1));
  }

  void _onReset(CounterReset event, Emitter<CounterState> emit) {
    emit(const CounterState());
  }
}
