import '../entities/counter.dart';

/// カウンターの永続化（保持）を抽象化したリポジトリ。
///
/// ドメイン層はこのインターフェースにのみ依存し、具体的な保存先
/// （メモリ・DB・API 等）はデータ層の実装に委譲する。
abstract class CounterRepository {
  /// 現在のカウンターを取得する。
  Counter getCounter();

  /// カウンターを保存する。
  void saveCounter(Counter counter);
}
