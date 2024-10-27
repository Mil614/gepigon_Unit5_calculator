import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  // Controllers for input fields
  TextEditingController add1Controller = TextEditingController();
  TextEditingController add2Controller = TextEditingController();

  // Result variables for each operation
  String additionResult = "0";
  String subtractionResult = "0";
  String multiplicationResult = "0";
  String divisionResult = "0";

  // Function to perform calculation based on selected operation
  void calculate(String operation) {
    int num1 = int.tryParse(add1Controller.text) ?? 0;
    int num2 = int.tryParse(add2Controller.text) ?? 0;

    switch (operation) {
      case '+':
        additionResult = (num1 + num2).toString();
        break;
      case '-':
        subtractionResult = (num1 - num2).toString();
        break;
      case '*':
        multiplicationResult = (num1 * num2).toString();
        break;
      case '/':
        divisionResult = (num2 != 0)
            ? (num1 / num2).toString()
            : "Error"; // Division by zero handling
        break;
      default:
        additionResult =
            subtractionResult = multiplicationResult = divisionResult = "0";
    }

    setState(() {}); // Update the UI
  }

  // Function to clear inputs and results
  void clearInputs() {
    add1Controller.clear();
    add2Controller.clear();
    additionResult = "0";
    subtractionResult = "0";
    multiplicationResult = "0";
    divisionResult = "0"; // Reset results
    setState(() {}); // Update the UI
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Input Fields
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: add1Controller,
                    decoration:
                        const InputDecoration(labelText: "First Number"),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: add2Controller,
                    decoration:
                        const InputDecoration(labelText: "Second Number"),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Operation Rows
            buildOperationRow('+', additionResult),
            buildOperationRow('-', subtractionResult),
            buildOperationRow('*', multiplicationResult),
            buildOperationRow('/', divisionResult),
            const SizedBox(height: 20),
            // Clear Button
            ElevatedButton(
              onPressed: clearInputs,
              child: const Text('Clear'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOperationRow(String operation, String result) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(" $operation "),
        IconButton(
          icon: const Icon(Icons.calculate),
          onPressed: () => calculate(operation), // Pass the operation
        ),
        Text(' = $result'),
      ],
    );
  }
}
