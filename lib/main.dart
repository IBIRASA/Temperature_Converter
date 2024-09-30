import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      home: const TemperatureConverter(),
    );
  }
}

class TemperatureConverter extends StatefulWidget {
  const TemperatureConverter({Key? key}) : super(key: key);

  @override
  _TemperatureConverterState createState() => _TemperatureConverterState();
}

class _TemperatureConverterState extends State<TemperatureConverter> {
  final TextEditingController _controller = TextEditingController();
  String _result = '';
  bool _isCelsiusToFahrenheit = true;
  List<String> _history = [];

  void _convertTemperature() {
    double? inputValue = double.tryParse(_controller.text);
    if (inputValue != null) {
      String conversionResult;
      if (_isCelsiusToFahrenheit) {
        double fahrenheit = (inputValue * 9 / 5) + 32;
        conversionResult =
            '$inputValue °C = ${fahrenheit.toStringAsFixed(2)} °F';
      } else {
        double celsius = (inputValue - 32) * 5 / 9;
        conversionResult = '$inputValue °F = ${celsius.toStringAsFixed(2)} °C';
      }
      setState(() {
        _result = conversionResult;
        _history.insert(0, conversionResult);
      });
    } else {
      setState(() {
        _result = 'Please enter a valid number';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Temperature Converter')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Enter temperature'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            SwitchListTile(
              title: const Text('Celsius to Fahrenheit'),
              value: _isCelsiusToFahrenheit,
              onChanged: (value) {
                setState(() {
                  _isCelsiusToFahrenheit = value;
                  _controller.clear();
                  _result = '';
                });
              },
            ),
            ElevatedButton(
              onPressed: _convertTemperature,
              child: const Text('Convert'),
            ),
            const SizedBox(height: 20),
            Text(
              _result,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            const Text('Conversion History:', style: TextStyle(fontSize: 18)),
            Expanded(
              child: ListView.builder(
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_history[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
