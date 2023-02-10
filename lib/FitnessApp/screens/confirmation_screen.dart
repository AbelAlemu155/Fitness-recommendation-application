import 'dart:isolate';

import 'package:firsstapp/FitnessApp/bloc/auth_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmationScreen extends StatelessWidget {
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();
  final controller3 = TextEditingController();
  final controller4 = TextEditingController();
  late FocusNode focusNode1;
  late FocusNode focusNode2;
  late FocusNode focusNode3;

  final String token;
  String textField1 = '';
  String textField2 = '';
  String textField3 = '';
  String textField4 = '';
  ConfirmationScreen({required this.token}) {
    focusNode2 = FocusNode();
    focusNode1 = FocusNode();
    focusNode3 = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 40,
          margin: EdgeInsets.only(right: 10, top: 10),
          child: TextField(
              cursorHeight: 30,
              cursorColor: Colors.cyan,
              onChanged: (text) {
                BlocProvider.of<AuthBloc>(context).add(
                    ConfirmationValidation(cscreen: this, token: this.token));
              },
              controller: controller1,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              maxLength: 1,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                counterText: "",
              )),
        ),
        Container(
          width: 40,
          margin: EdgeInsets.only(right: 10, top: 10),
          child: TextField(
              focusNode: focusNode1,
              cursorHeight: 30,
              cursorColor: Colors.cyan,
              onChanged: (text) {
                BlocProvider.of<AuthBloc>(context).add(
                    ConfirmationValidation(cscreen: this, token: this.token));
              },
              controller: controller2,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              maxLength: 1,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                counterText: "",
              )),
        ),
        Container(
          width: 40,
          margin: EdgeInsets.only(right: 10, top: 10),
          child: TextField(
              focusNode: focusNode2,
              cursorHeight: 30,
              cursorColor: Colors.cyan,
              onChanged: (text) {
                BlocProvider.of<AuthBloc>(context).add(
                    ConfirmationValidation(cscreen: this, token: this.token));
              },
              controller: controller3,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              maxLength: 1,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                counterText: "",
              )),
        ),
        Container(
          width: 40,
          margin: EdgeInsets.only(right: 6, top: 10),
          child: TextField(
              focusNode: focusNode3,
              cursorHeight: 30,
              cursorColor: Colors.cyan,
              onChanged: (text) {
                BlocProvider.of<AuthBloc>(context).add(
                    ConfirmationValidation(cscreen: this, token: this.token));
              },
              controller: controller4,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(1),
              ],
              maxLength: 1,
              decoration: InputDecoration(
                counterText: "",
                border: OutlineInputBorder(),
              )),
        ),
      ],
    );
  }
}
