import 'package:flutter/material.dart';

class RowResultInfo extends StatelessWidget {
  final double bmi;
  const RowResultInfo({Key? key, required this.bmi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                            'Otyłość I Stopnia  >30 & <35\n'
                            'Otyłość II Stopnia  >35 & <40\n'
                            'Otyłość III Stopnia  >40'
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
}
