import 'package:flutter/material.dart';

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

   String calculateBMI(double height, double weight){
    height = height/100;
    return (weight/(height*height)).toStringAsFixed(2);
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
                onChanged: (value) => height = double.parse(value),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your height (in cm)',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              child: TextField(
                controller: _weightInputController,
                onChanged: (value) => weight = double.parse(value),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your weight (in kg)',
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await showDialog<void>(
              context: context,
              builder: (BuildContext context){
                String bmi = calculateBMI(height, weight);
                return AlertDialog(
                  title: Text('Your BMI is $bmi'),
                  actions: <Widget>[
                    TextButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: const Text('Ok'))
                  ],
                );
             }
          );
        },
        label: const Text(
          'Check your BMI'
        ),
      ),
    );
  }
}
