import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  double _valor = 0;
  double _valorTotal = 0.00;
  double _percent = 0;

  void _calcTotal() {
    setState(() {
      _valorTotal = _valor * (100+_percent) / 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conta'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: TextFormField(
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  hintText: 'Valor da conta',
                  hintStyle: TextStyle(color: Colors.white)
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe um valor';
                  } else {
                    _valor = double.parse(value);
                    if (_valor <= 0) {
                      return 'O valor deve ser maior que zero';
                    }
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: TextFormField(
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  hintText: 'Porcentagem',
                  hintStyle: TextStyle(color: Colors.white)
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe um valor';
                  } else {
                    _percent = double.parse(value);
                    if (_percent <= 0) {
                      return 'O valor deve ser maior que zero';
                    } else if (_percent > 100){
                      return 'O valor deve ser menor que cem';
                    }
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _calcTotal();
                }
              },
              child: const Text('Calcular'),
            ),
            const SizedBox(height: 40),
            Text(
              _valorTotal != 0 ? 'Valor total R\$ ${_valorTotal.toStringAsFixed(2)}' : '',
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }


}
