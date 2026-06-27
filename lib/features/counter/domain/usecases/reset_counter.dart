import '../entities/counter.dart';

/// カウンターを初期値（0）に戻すユースケース。
class ResetCounter {
  const ResetCounter();

  /// 初期状態の [Counter] を返す。
  Counter call() {
    return const Counter.initial();
  }
}
