import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_health_monitor/l10n/app_localizations.dart';

class BMICalculator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BMICalculator();
  }
}

class _BMICalculator extends State<BMICalculator> {
  var primaryHeightInput = 0.0;
  var secondaryHeightInput = 0.0;
  var weightInput = 0.0;

  var selectedHeight = "metric";
  var selectedWeight = "kg";

  var metricWeight = 0.0;
  var metricHeight = 0.0;
  var bmi = 0.0;
  var bmiComment = "";

  var textStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.w500);

  final weightMenuEntries = [
    {"label": "KG", "value": "kg"},
    {"label": "LB", "value": "lb"},
  ];

  final heightMenuEntries = [
    {"label": "CM", "value": "metric"},
    {"label": "FT, IN", "value": "imp"},
  ];

  void updateInputs() {
    switch (selectedWeight) {
      case "lb":
        metricWeight = weightInput * 0.453592;
        break;
      default:
        metricWeight = weightInput;
        break;
    }
    switch (selectedHeight) {
      case "imp":
        metricHeight = primaryHeightInput * 30.48 + secondaryHeightInput * 2.54;
        break;
      default:
        metricHeight = primaryHeightInput;
        break;
    }
    setState(() {
      bmi = metricWeight / pow(metricHeight / 100, 2);
      if (bmi.isNaN || bmi.isInfinite) {
        bmi = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    updateInputs();
    var localizations = AppLocalizations.of(context)!;
    
    if (bmi < 18.5) {
      bmiComment = localizations.underweight;
    } else if (bmi > 24.9) {
      bmiComment = localizations.overweight;
    } else {
      bmiComment = localizations.healthy;
    }
    
    return Scaffold(
      appBar: AppBar(title: Text(localizations.bmiCalculator)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 48.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(localizations.inputWeight, style: textStyle),
              ),
              SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 10,
                      child: TextField(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        keyboardType: TextInputType.number,
                        onChanged: (str) {
                          setState(() {
                            weightInput = double.tryParse(str) ?? 0.0;
                          });
                        },
                      ),
                    ),
                    Expanded(flex: 1, child: SizedBox()),
                    Expanded(
                      flex: 6,
                      child: DropdownMenu(
                        initialSelection: selectedWeight,
                        dropdownMenuEntries: weightMenuEntries
                            .map(
                              (el) => DropdownMenuEntry(
                                label: el["label"]!,
                                value: el["value"]!,
                              ),
                            )
                            .toList(),
                        onSelected: (val) => setState(() {
                          selectedWeight = val!;
                        }),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(localizations.inputHeight, style: textStyle),
              ),
              SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: selectedHeight == "metric" ? 100 : 50,
                      child: TextField(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        keyboardType: TextInputType.number,
                        onChanged: (str) {
                          setState(() {
                            primaryHeightInput = double.tryParse(str) ?? 0;
                          });
                        },
                      ),
                    ),
                    if (selectedHeight == "imp") ...[
                      Expanded(flex: 3, child: SizedBox()),
                      Expanded(
                        flex: 50,
                        child: TextField(
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          keyboardType: TextInputType.number,
                          onChanged: (str) {
                            setState(() {
                              secondaryHeightInput = double.tryParse(str) ?? 0;
                            });
                          },
                        ),
                      ),
                    ],
                    Expanded(flex: 10, child: SizedBox()),
                    Expanded(
                      flex: 60,
                      child: DropdownMenu(
                        initialSelection: selectedHeight,
                        dropdownMenuEntries: heightMenuEntries
                            .map(
                              (el) => DropdownMenuEntry(
                                label: el["label"]!,
                                value: el["value"]!,
                              ),
                            )
                            .toList(),
                        onSelected: (value) =>
                            setState(() => selectedHeight = value!),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),
              Text(
                localizations.yourBMI,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              Text(
                bmi.toStringAsPrecision(2),
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              Text('"$bmiComment"', style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),)
            ],
          ),
        ),
      ),
    );
  }
}
