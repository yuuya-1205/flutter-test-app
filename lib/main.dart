import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/counter/data/repositories/in_memory_counter_repository.dart';
import 'features/counter/domain/repositories/counter_repository.dart';
import 'features/counter/domain/usecases/decrement_counter.dart';
import 'features/counter/domain/usecases/increment_counter.dart';
import 'features/counter/domain/usecases/reset_counter.dart';
import 'features/counter/presentation/bloc/counter_bloc.dart';
import 'features/counter/presentation/pages/counter_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // データ層の実装を組み立てる（依存性の注入はここに集約する）。
    final CounterRepository repository = InMemoryCounterRepository();

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: BlocProvider(
        create: (_) => CounterBloc(
          incrementCounter: IncrementCounter(repository),
          decrementCounter: DecrementCounter(repository),
          resetCounter: ResetCounter(repository),
        ),
        child: const CounterPage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
