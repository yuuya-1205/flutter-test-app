import 'package:equatable/equatable.dart';

/// ドメインのエンティティ。カウンターの「値」そのものを表す。
///
/// Equatable を継承しているため、値が等しければ同一オブジェクトとして扱われる。
class Counter extends Equatable {
  const Counter({required this.value});

  final int value;

  @override
  List<Object?> get props => [value];
}
