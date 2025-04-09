import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runZonedGuarded(
    () {
      runApp(const MyApp());
    },
    (error, stackTrace) {
      print('Erro: $error');
      print('Stack trace: $stackTrace');
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //representação da regra de negócio
  var height = 0.0;
  var weight = 0.0;

  //representação do estado

  var result = '';

  // representação da ação / regra de negócio da aplicação
  void calcularIMC() {
    if (height > 0) {
      final imc = weight / (height * height);
      setState(() {
        result = 'IMC: ${imc.toStringAsFixed(2)}';
      });
    } else {
      setState(() {
        result = 'A altura não pode ser zero!';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text('IMC Calculator'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Height (m)'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                height = double.tryParse(value) ?? 0.0;
              },
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Weight (kg)'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                weight = double.tryParse(value) ?? 0.0;
              },
            ),
            ElevatedButton(
              onPressed: calcularIMC,
              child: const Text('Calculate IMC'),
            ),
            Text(result),
          ],
        ),
      ),
    );
  }
}
