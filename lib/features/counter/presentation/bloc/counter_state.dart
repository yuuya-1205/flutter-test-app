part of 'counter_bloc.dart';

/// カウンターの偶奇。表示やロジック分岐のための派生情報。
enum CounterParity { even, odd }

/// 画面が必要とするカウンターの状態。
///
/// [count] は表示する値、[parity] は偶奇（Bloc 内のヘルパー関数で算出される派生値）。
class CounterState extends Equatable {
  const CounterState({required this.count, required this.parity});

  /// 初期状態（0 / 偶数）。
  const CounterState.initial() : count = 0, parity = CounterParity.even;

  final int count;
  final CounterParity parity;

  bool get isEven => parity == CounterParity.even;

  @override
  List<Object?> get props => [count, parity];
}
