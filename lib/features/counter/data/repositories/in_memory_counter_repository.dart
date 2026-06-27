import '../../domain/entities/counter.dart';
import '../../domain/repositories/counter_repository.dart';

/// メモリ上にカウンターを保持するリポジトリ実装。
///
/// アプリの実行中のみ値を保持する。DB や API へ差し替える場合も、
/// この [CounterRepository] 実装だけを置き換えれば済む（依存方向はドメインへ向く）。
class InMemoryCounterRepository implements CounterRepository {
  Counter _counter = const Counter.initial();

  @override
  Counter getCounter() => _counter;

  @override
  void saveCounter(Counter counter) {
    _counter = counter;
  }
}
