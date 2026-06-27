part of 'counter_bloc.dart';

/// カウンターに対する操作を表すイベント。
sealed class CounterEvent extends Equatable {
  const CounterEvent();

  @override
  List<Object?> get props => [];
}

/// 加算イベント。
class CounterIncremented extends CounterEvent {
  const CounterIncremented({this.step = 1});

  final int step;

  @override
  List<Object?> get props => [step];
}

/// 減算イベント。
class CounterDecremented extends CounterEvent {
  const CounterDecremented({this.step = 1});

  final int step;

  @override
  List<Object?> get props => [step];
}

/// 初期値（0）へのリセットイベント。
class CounterReset extends CounterEvent {
  const CounterReset();
}
