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
  bool imperialUnits = false;
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
    if(imperialUnits){
      return ((weight/(height*height))*703).toStringAsFixed(2);
    }
    height = height/100;
    return (weight/(height*height)).toStringAsFixed(2);
  }

  Widget resultBMI (double bmi){
    String result = '';
    if(bmi<16){
      result = 'Wygłodzenie';
    } else if(bmi>=16 && bmi<17){
      result = 'Wychudzenie';
    } else if(bmi>=17 && bmi<18.5){
      result = 'Niedowaga';
    } else if(bmi>=18.5 && bmi<25){
      result = 'Waga Prawidłowa';
    } else if(bmi>=25 && bmi<30){
      result = 'Nadwaga';
    } else if(bmi>=30 && bmi<35){
      result = 'Otyłość I Stopnia';
    } else if(bmi>=35 && bmi<40){
      result = 'Otyłość II Stopnia';
    } else {
      result = 'Otyłość III Stopnia';
    }
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.info),
          onPressed: (){
              showDialog(
              context: context,
              builder: (BuildContext context){
                return AlertDialog(
                  content: const Text(
                      'BMI:\n\n'
                          'Wygłodzenie  <16\n'
                          'Wychudzenie  >16 & <17\n'
                          'Niedowaga  >17 & <18.5\n'
                          'Waga prawidłowa  >18.5 & <25\n'
                          'Nadwaga  >25 & <30\n'
                          'Otyłość I Stopnia >30 & <35\n'
                          'Otyłość II Stopnia >35 & <40\n'
                          'Otyłość III Stopnia >40'
                  ),
                  actions: <Widget>[
                    TextButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: const Text('OK'))
                  ],
                );
              }
          );},
        ),
        Text(result),
      ],
    );
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
                onChanged: (value) => weight = double.parse(value),
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
                  onChanged:(value){
                    setState(()
                    {
                      imperialUnits = value;
                    }
                    );
                  },
                ),
                const Text('funty/cale'),
              ],
            )
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
                  title: Text('Twoje BMI wynosi $bmi'),
                  content: resultBMI(double.parse(bmi)),
                  actions: <Widget>[
                    TextButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: const Text('OK'))
                  ],
                );
             }
          );
        },
        label: const Text(
          'Sprawdź swoje BMI'
        ),
      ),
    );
  }
}
