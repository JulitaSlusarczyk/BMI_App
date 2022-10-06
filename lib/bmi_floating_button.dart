import 'package:flutter/material.dart';
import 'result_info.dart';
import 'calculate_bmi.dart';

class BmiFloatingActionButton extends StatelessWidget {
  final double height;
  final double weight;
  final bool imperialUnits;
  const BmiFloatingActionButton({Key? key, required this.height, required this.weight, required this.imperialUnits}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () async {
        await showDialog<void>(
            context: context,
            builder: (BuildContext context){
              String bmi = calculateBMI(height, weight, imperialUnits);
              return AlertDialog(
                title: Text('Twoje BMI wynosi $bmi'),
                content: RowResultInfo(bmi: double.parse(bmi)),
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
    );
  }
}
