import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_bloc.dart';

/// カウンター画面。
///
/// 状態の購読は [BlocBuilder]、操作は `context.read<CounterBloc>().add(...)` で行う。
class CounterPage extends StatelessWidget {
  const CounterPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: BlocBuilder<CounterBloc, CounterState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('You have pushed the button this many times:'),
                Text(
                  '${state.count}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: 'increment',
            onPressed: () =>
                context.read<CounterBloc>().add(const CounterIncremented()),
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            heroTag: 'decrement',
            onPressed: () =>
                context.read<CounterBloc>().add(const CounterDecremented()),
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            heroTag: 'reset',
            onPressed: () =>
                context.read<CounterBloc>().add(const CounterReset()),
            tooltip: 'Reset',
            child: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}
