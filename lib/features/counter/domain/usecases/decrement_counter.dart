import '../entities/counter.dart';
import '../repositories/counter_repository.dart';

/// カウンターを減算するユースケース。
class DecrementCounter {
  const DecrementCounter(this._repository);

  final CounterRepository _repository;

  /// [step] だけ減算し、更新後のカウンターを返す。
  Counter call({int step = 1}) {
    final current = _repository.getCounter();
    final updated = Counter(value: current.value - step);
    _repository.saveCounter(updated);
    return updated;
  }
}
