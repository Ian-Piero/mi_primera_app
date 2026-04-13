import 'package:flutter/material.dart';

void main() => runApp(const CalculadoraApp());

class CalculadoraApp extends StatelessWidget {
  const CalculadoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora Flutter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Calculadora(),
    );
  }
}

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String _display = '0';
  double _primerNumero = 0;
  String _operacion = '';
  bool _nuevaOperacion = true;

  void _presionarBoton(String valor) {
    setState(() {
      if (valor == 'C') {
        _display = '0';
        _primerNumero = 0;
        _operacion = '';
        _nuevaOperacion = true;
      } else if (valor == '+' || valor == '-' || valor == '×' || valor == '÷') {
        _primerNumero = double.parse(_display);
        _operacion = valor;
        _nuevaOperacion = true;
      } else if (valor == '=') {
        double segundoNumero = double.parse(_display);
        switch (_operacion) {
          case '+': _display = (_primerNumero + segundoNumero).toString(); break;
          case '-': _display = (_primerNumero - segundoNumero).toString(); break;
          case '×': _display = (_primerNumero * segundoNumero).toString(); break;
          case '÷': _display = segundoNumero != 0 ? (_primerNumero / segundoNumero).toString() : 'Error'; break;
        }
        _operacion = '';
        _nuevaOperacion = true;
      } else {
        if (_nuevaOperacion) {
          _display = valor;
          _nuevaOperacion = false;
        } else {
          _display += valor;
        }
      }
    });
  }

  Color _getDisplayColor() {
    double? valor = double.tryParse(_display);
    if (valor == null || valor == 0) return Colors.grey;
    return valor > 0 ? Colors.blue.shade800 : Colors.red.shade800;
  }

  Widget _crearBoton(String texto, {Color? color}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Colors.grey.shade200,
            padding: const EdgeInsets.symmetric(vertical: 20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: () => _presionarBoton(texto),
          child: Text(texto, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculadora Básica')),
      body: Column(
        children: [
          // Display
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(24),
              color: Colors.white,
              child: Text(
                _display,
                style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: _getDisplayColor()),
              ),
            ),
          ),
          // Botones
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.grey.shade100,
            child: Column(
              children: [
                Row(children: [_crearBoton('7'), _crearBoton('8'), _crearBoton('9'), _crearBoton('÷', color: Colors.orange.shade200)]),
                Row(children: [_crearBoton('4'), _crearBoton('5'), _crearBoton('6'), _crearBoton('×', color: Colors.orange.shade200)]),
                Row(children: [_crearBoton('1'), _crearBoton('2'), _crearBoton('3'), _crearBoton('-', color: Colors.orange.shade200)]),
                Row(children: [_crearBoton('C', color: Colors.red.shade200), _crearBoton('0'), _crearBoton('.'), _crearBoton('+', color: Colors.orange.shade200)]),
                Row(children: [_crearBoton('=', color: Colors.green.shade200)]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}