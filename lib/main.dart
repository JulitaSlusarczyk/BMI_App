import 'package:flutter/material.dart';
import 'bmi_floating_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Application',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const MyHomePage(title: 'BMI App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _heightInputController;
  late TextEditingController _weightInputController;
  bool imperialUnits = false;
  bool visibilityError = false;
  double height = 0;
  double weight = 0;

  @override
  void initState() {
    super.initState();
    _heightInputController = TextEditingController();
    _weightInputController = TextEditingController();
  }

  @override
  void dispose() {
    _heightInputController.dispose();
    _weightInputController.dispose();
    super.dispose();
  }
  parseValue(String value){
    if(double.tryParse(value)!=null){
      return double.parse(value);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(8),
              child: TextField(
                controller: _heightInputController,
                onChanged: (value) => parseValue(value)==null ? setState( () => visibilityError = true) : setState((){height = parseValue(value); visibilityError = false;}),
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Podaj swój wzrost (w ${imperialUnits ? 'calach' : 'cm'})',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              child: TextField(
                controller: _weightInputController,
                onChanged: (value) => parseValue(value)==null ? setState( () => visibilityError = true) : setState((){weight = parseValue(value); visibilityError = false;}),
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Podaj swoją wagę (w ${imperialUnits ? 'funtach' : 'kg'})',
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('kg/cm'),
                Switch(
                  value: imperialUnits,
                  onChanged:(value) => setState( () => imperialUnits = value ),
                ),
                const Text('funty/cale'),
              ],
            ),
            Visibility(
              visible: visibilityError,
              child: const Text("Wprowadzono niepoprawne dane", style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
      floatingActionButton: BmiFloatingActionButton(height: height, weight: weight, imperialUnits: imperialUnits),
    );
  }
}
