import '../bloc/counter_bloc.dart';

/// Facade（窓口）。
///
/// UI 層は Bloc のイベント（[CounterIncremented] 等）を直接知らず、この
/// Facade の単純なメソッドだけを呼び出す。これにより「どんなイベントを
/// add するか」という詳細を Facade の内側に隠蔽できる。
class CounterFacade {
  const CounterFacade(this._bloc);

  final CounterBloc _bloc;

  /// 現在の状態。
  CounterState get state => _bloc.state;

  /// 状態の変化ストリーム。
  Stream<CounterState> get stateStream => _bloc.stream;

  /// 加算する。
  void increment({int step = 1}) {
    _bloc.add(CounterIncremented(step: step));
  }

  /// 減算する。
  void decrement({int step = 1}) {
    _bloc.add(CounterDecremented(step: step));
  }

  /// 初期値に戻す。
  void reset() {
    _bloc.add(const CounterReset());
  }
}
