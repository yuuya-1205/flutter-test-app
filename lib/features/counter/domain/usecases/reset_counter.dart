import '../entities/counter.dart';
import '../repositories/counter_repository.dart';

/// カウンターを初期値（0）に戻すユースケース。
class ResetCounter {
  const ResetCounter(this._repository);

  final CounterRepository _repository;

  /// 初期状態に戻し、そのカウンターを返す。
  Counter call() {
    const reset = Counter.initial();
    _repository.saveCounter(reset);
    return reset;
  }
}
