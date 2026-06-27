import 'counter_bloc.dart';

/// Facade（窓口）。
///
/// UI 層は Bloc のイベント（[CounterIncremented] 等）を直接知らず、この
/// Facade の単純なメソッドだけを呼び出す。「どのイベントを add するか」という
/// 詳細を Facade の内側に隠蔽する。
class CounterFacade {
  const CounterFacade(this._bloc);

  final CounterBloc _bloc;

  /// 現在の状態。
  CounterState get state => _bloc.state;

  /// 状態の変化ストリーム。
  Stream<CounterState> get stateStream => _bloc.stream;

  /// 加算する。
  void increment() => _bloc.add(const CounterIncremented());

  /// 減算する。
  void decrement() => _bloc.add(const CounterDecremented());
}
