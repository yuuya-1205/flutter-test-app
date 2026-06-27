import '../entities/counter.dart';
import '../repositories/counter_repository.dart';

/// カウンターを加算するユースケース。
class IncrementCounter {
  const IncrementCounter(this._repository);

  final CounterRepository _repository;

  /// [step] だけ加算し、更新後のカウンターを返す。
  Counter call({int step = 1}) {
    final current = _repository.getCounter();
    final updated = Counter(value: current.value + step);
    _repository.saveCounter(updated);
    return updated;
  }
}
