import '../entities/counter.dart';

/// カウンターを減算するユースケース。
///
/// 状態の保持は行わず、現在の [Counter] を受け取って減算後の [Counter] を返す
/// 純粋な操作。状態の保持は呼び出し側（Bloc）の責務とする。
class DecrementCounter {
  const DecrementCounter();

  /// [current] を [step] だけ減算した新しい [Counter] を返す。
  Counter call(Counter current, {int step = 1}) {
    return Counter(value: current.value - step);
  }
}
