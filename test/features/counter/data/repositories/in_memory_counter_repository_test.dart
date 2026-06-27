import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_test_app/features/counter/data/repositories/in_memory_counter_repository.dart';
import 'package:flutter_test_app/features/counter/domain/entities/counter.dart';

void main() {
  late InMemoryCounterRepository repository;

  setUp(() {
    repository = InMemoryCounterRepository();
  });

  test('初期値は 0 を返す', () {
    expect(repository.getCounter(), const Counter.initial());
  });

  test('保存した値を取得できる', () {
    repository.saveCounter(const Counter(value: 7));
    expect(repository.getCounter(), const Counter(value: 7));
  });
}
