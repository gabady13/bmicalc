import 'package:bmi_calculator/screens/results_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bmi_calculator/components/icon_content.dart';
import 'package:bmi_calculator/components/reusable_card.dart';
import 'package:bmi_calculator/constans.dart';
import 'results_page.dart';
import 'package:bmi_calculator/components/bottom_button.dart';
import 'package:bmi_calculator/components/round_icon_button.dart';
import 'package:bmi_calculator/calculator_brain.dart';

enum Genders{male,female}
enum Procedure{plus,minus}


class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Genders selectedGender;
  int height = 171;
  int weight = 98;
  int age = 31;

  void onPressedButton(int number, Procedure procedure){
    setState(() {
      if (procedure == Procedure.plus) {
        number++;
      }else{
        number--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    onPress: (){
                     setState(() {
                       selectedGender = Genders.male;
                     });
                    },
                    colour: selectedGender == Genders.male ? kActiveCardColour: kInactiveCardColour,
                    cardChild: ImageAndText(
                      label: 'MALE',
                      icon:FontAwesomeIcons.mars,
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    onPress: (){
                      setState(() {
                        selectedGender = Genders.female;
                      });
                    },
                    colour: selectedGender == Genders.female ? kActiveCardColour: kInactiveCardColour,
                    cardChild: ImageAndText(
                      label: 'FEMALE',
                      icon: FontAwesomeIcons.venus,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ReusableCard(colour: kActiveCardColour,
            cardChild: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('HEIGHT', style: kLabelTextStyle,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: <Widget>[
                 Text(height.toString(),
                   style: kNumberTextStyle,
                 ),
                  Text('cm',
                  style: kLabelTextStyle,
                  ),
                ],
              ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    inactiveTrackColor: Color(0xFF8D8E98),
                    activeTrackColor: Colors.white,
                    thumbColor: Color(0xFFEB1555),
                    overlayColor: Color(0x29EB1555),
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 30.0)
                  ),
                  child: Slider(
                    value: height.toDouble(),
                    min: 100.0,
                    max: 250.0,
                    onChanged: (double newValue){
                      setState(() {
                        height = newValue.toInt();
                      });
                    },
                  ),
                ),],
            ),),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(colour: kActiveCardColour,
                  cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'WEIGHT',
                      style: kLabelTextStyle,
                    ),
                    Text(weight.toString(),
                    style: kNumberTextStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RoundIconButton(icon: FontAwesomeIcons.minus, onPressed:(){
                          setState(() {
                            weight--;
                          });
                        },),
                        SizedBox(width:10.0),
                        RoundIconButton(icon: FontAwesomeIcons.plus, onPressed:(){
                          setState(() {
                            weight++;
                          });
                        },),
                      ],
                    )
                  ],
                  ),
                  ),
                ),
                Expanded(
                  child: ReusableCard(colour: kActiveCardColour,
                  cardChild: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'AGE',
                        style: kLabelTextStyle,
                      ),
                      Text(age.toString(),
                        style: kNumberTextStyle,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RoundIconButton(icon: FontAwesomeIcons.minus, onPressed:(){
                            setState(() {
                              age--;
                            });
                          },),
                          SizedBox(width:10.0),
                          RoundIconButton(icon: FontAwesomeIcons.plus, onPressed:(){
                            setState(() {
                              age++;
                            });
                          },),
                        ],
                      )
                    ],
                  ),),
                ),
              ],
            ),
          ),
          BottomButton(buttonTitle: 'CALCULATER', onTap: (){

            CalculatorBrain calc = CalculatorBrain(height: height, weight: weight);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultsPage(
                  bmiResult: calc.calculateBMI(),
                  resultText: calc.getResult(),
                  resultInterpretation: calc.getInterpretation()),
                )
            );
          },),
        ],
      ),
    );
  }
}
