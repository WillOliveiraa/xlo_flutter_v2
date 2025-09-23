import 'package:flutter/material.dart';
import 'package:xlo_flutter_v2/src/features/dashboard/presentation/viewmodels/test_viewmodel.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  late final TestViewmodel testViewmodel;

  @override
  void initState() {
    super.initState();
    testViewmodel = TestViewmodel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ValueListenableBuilder(
              valueListenable:
                  testViewmodel.incrementCounterCommand.isExecuting,
              builder: (context, isExecuting, snapshot) {
                if (isExecuting) {
                  return SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: CircularProgressIndicator(),
                  );
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('You have pushed the button this many times:'),
                    ValueListenableBuilder(
                      valueListenable: testViewmodel.incrementCounterCommand,
                      builder: (context, value, snapshot) {
                        return Text(
                          '$value',
                          style: Theme.of(context).textTheme.headlineMedium,
                        );
                      },
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
            ValueListenableBuilder(
              valueListenable: testViewmodel.incrementCounterCommand.canExecute,
              builder: (context, canExecute, _) {
                return IconButton(
                  icon: const Icon(Icons.add),
                  iconSize: 50,
                  onPressed:
                      canExecute
                          ? () =>
                              testViewmodel.incrementCounterCommand.execute()
                          : null,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: ValueListenableBuilder(
        valueListenable: testViewmodel.incrementCounterCommand.canExecute,
        builder: (context, canExecute, snapshot) {
          return FloatingActionButton(
            onPressed:
                canExecute
                    ? () => testViewmodel.incrementCounterCommand.execute()
                    : null,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          );
        },
      ),
    );
  }
}
