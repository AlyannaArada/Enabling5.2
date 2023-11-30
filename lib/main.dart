import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MaterialApp(
    home: Calculator(),
  ));
}

class Calculator extends HookWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textController = useTextEditingController();
    final output = useState('');

    void calculate() {
      try {
        final parser = Parser();
        final exp = parser.parse(textController.text);
        final cm = ContextModel();
        output.value = exp.evaluate(EvaluationType.REAL, cm).toString();
      } catch (e) {
        output.value = 'Error';
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Calculator'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: TextField(
                    controller: textController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter expression',
                    ),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 24.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: calculate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text('Calculate'),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: TextField(
                    readOnly: true,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Result',
                    ),
                    controller: TextEditingController(text: output.value),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 24.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}