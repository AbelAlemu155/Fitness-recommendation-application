import 'dart:isolate';

import 'package:firsstapp/FitnessApp/bloc/auth_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/auth_event.dart';
import 'package:firsstapp/FitnessApp/bloc/auth_state.dart';
import 'package:firsstapp/FitnessApp/screens/confirmation_screen.dart';
import 'package:firsstapp/FitnessApp/screens/signup_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

import 'home.dart';
import 'login_screen.dart';

class ForgotScreen extends StatefulWidget {
  _ForgotState createState() => _ForgotState();
  static const routeName = '/forgotscreen';
  ConfirmationEvent cEvent;

  ForgotScreen([this.cEvent = const ConfirmationEvent()]);
}

class _ForgotState extends State<ForgotScreen> {
  final _formKey2 = GlobalKey<FormState>();
  final Map<String, dynamic> _userNewCredential = {};
  ScrollController _scrollController = ScrollController();
  bool _tapped = false;
  bool _isvisible = false;
  bool _isDisabled = false;
  int _count = 0;
  final _formFieldKey2 = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    //bool checker = widget.successAccess ?? false;

    TextStyle defaultStyle = TextStyle(color: Colors.grey, fontSize: 20.0);
    TextStyle linkStyle = TextStyle(color: Colors.blue);

    return Scaffold(
        appBar: AppBar(
          title: Text('Reset your password'),
          backwardsCompatibility: false,
          systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.cyan),
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(20.0, 110, 0, 0),
                    child: Text(
                      "Update your",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          fontFamily: "Mon"),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20.0, 160, 0, 0),
                    child: Text(
                      "Account",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          fontFamily: "Mon"),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(170, 150, 0, 0),
                    child: Text(
                      ".",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 55,
                        color: Colors.cyan,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Form(
                key: _formKey2,
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(40, 100, 0, 0),
                    child: Column(children: [
                      Container(
                        padding: EdgeInsets.only(right: 100),
                        child: TextFormField(
                            initialValue: '',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "EMAIL",
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Mon',
                                  color: Colors.cyan,
                                  fontSize: 15.0),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            onSaved: (value) {
                              setState(() {
                                this._userNewCredential["username"] = value;
                              });
                            }),
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.only(top: 20.0, right: 100),
                        child: TextFormField(
                            key: _formFieldKey2,
                            obscureText: true,
                            initialValue: '',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your password';
                              }
                              if (value.length < 8) {
                                return 'Invalid password';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "PASSWORD",
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Mon',
                                color: Colors.cyan,
                                fontSize: 15.0,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            onSaved: (value) {
                              this._userNewCredential["password"] = value;
                            }),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20, right: 50),
                        child: TextFormField(
                            obscureText: true,
                            initialValue: '',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter password confirmation';
                              }
                              if (_formFieldKey2.currentState!.value != value) {
                                return 'Passwords must match';
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'CONFIRM PASSWORD',
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Mon',
                                color: Colors.cyan,
                                fontSize: 15.0,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                            ),
                            onSaved: (value) {
                              setState(() {
                                this._userNewCredential["cpassword"] = value;
                              });
                            }),
                      ),
                      SizedBox(height: 40.0),
                      SizedBox(height: 40.0),
                      Container(
                        padding: EdgeInsets.only(right: 50.0),
                        height: 40.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.cyanAccent,
                          color: _tapped
                              ? Colors.cyan.withOpacity(0.6)
                              : Colors.cyan,
                          elevation: 4.0,
                          child: GestureDetector(
                            onTap: _isDisabled
                                ? null
                                : () {
                                    _count++;
                                    setState(() {
                                      _tapped = true;
                                    });
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    final form = _formKey2.currentState;
                                    if (form!.validate()) {
                                      form.save();
                                      final ValidationEvent2 vevent =
                                          ValidationEvent2(
                                              email: this._userNewCredential[
                                                  'username']);

                                      BlocProvider.of<AuthBloc>(context)
                                          .add(vevent);
                                      setState(() {
                                        _isvisible = true;
                                        if (_count == 3) {
                                          _isDisabled = true;
                                        }
                                      });
                                      WidgetsBinding.instance!
                                          .addPostFrameCallback((_) {
                                        _scrollController.animateTo(
                                            _scrollController
                                                .position.maxScrollExtent,
                                            duration:
                                                Duration(milliseconds: 500),
                                            curve: Curves.ease);
                                      });
                                    }

                                    Future.delayed(
                                        const Duration(milliseconds: 100), () {
                                      setState(() {
                                        _tapped = false;
                                      });
                                    });
                                  },
                            child: Center(
                              child: Text(
                                "Change password",
                                style: TextStyle(
                                  fontFamily: "Mon",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 35.0),
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (_, state) {
                          if (state is ValidationInProgress) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                CircularProgressIndicator(),
                              ],
                            );
                          }
                          if (state is ValidationFailure) {
                            String message =
                                state.message.replaceAll('Exception: ', '');
                            return Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  '***${message}',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 15),
                                ),
                              ],
                            );
                          }
                          if (state is ValidationSuccess2) {
                           
                            BlocProvider.of<AuthBloc>(context).add(EmailEvent(
                                email: this._userNewCredential['username']));
                           
                          }
                          if (state is EmailInProgress) {
                            return Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(),
                                  Container(
                                      margin: EdgeInsets.only(left: 20),
                                      child: Text('Sending email...'))
                                ],
                              ),
                            );
                          }
                          if (state is EmailFailure) {
                            WidgetsBinding.instance!.addPostFrameCallback((_) {
                              setState(() {
                                _isDisabled = false;
                              });
                            });
                            return Text(state.message);
                          }

                          if (state is EmailSuccess) {
                            final snackBar = SnackBar(
                                content:
                                    Text('Confirmation email has been sent'));

                            WidgetsBinding.instance!.addPostFrameCallback((_) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            });
                            print(state.token);
                            ConfirmationScreen cscreen =
                                ConfirmationScreen(token: state.token);
                            BlocProvider.of<AuthBloc>(context).add(
                                ConfirmationValidation(
                                    cscreen: cscreen, token: state.token));
                            return cscreen;
                          }
                          if (state is ConfirmationRight) {
                            BlocProvider.of<AuthBloc>(context).add(
                                ChangePasswordEvent(
                                    email: this._userNewCredential['username'],
                                    password:
                                        this._userNewCredential['password']));
                          }

                          if (state is ChangeInProgress) {
                            return Column(
                              children: [
                                SizedBox(height: 20),
                                CircularProgressIndicator(),
                              ],
                            );
                          }
                          if (state is ChangePasswordFailure) {
                            String message =
                                state.message.replaceAll('Exception: ', '');
                            return Column(
                              children: [
                                SizedBox(height: 20),
                                Text('**$message'),
                              ],
                            );
                          }

                          if (state is ChangePasswordSuccess) {
                            final snackBar = SnackBar(
                                content: Text('Password has been changed '));

                            WidgetsBinding.instance!.addPostFrameCallback((_) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              Navigator.of(context).pop();
                            });
                          }

                          if (state is ConfirmationWrong) {
                            state.cscreen.controller1.text = '';
                            state.cscreen.controller2.text = '';
                            state.cscreen.controller3.text = '';
                            state.cscreen.controller4.text = '';

                            return Column(children: [
                              state.cscreen,
                              Column(children: [
                                SizedBox(
                                  height: 25,
                                ),
                                Text(
                                  '***Confirmation is Wrong',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 15),
                                ),
                              ]),
                            ]);
                          }
                          if (state is ConfirmationValidationProgress) {
                            return Column(
                              children: [
                                Text(
                                  'Enter confirmation code',
                                  style: TextStyle(
                                      color: Colors.cyan, fontSize: 17),
                                ),
                                state.cscreen
                              ],
                            );
                          }
                          return Container();
                        },
                      ),
                      Visibility(
                          visible: _isvisible,
                          child: Column(
                            children: [
                              SizedBox(height: 20.0),
                              SizedBox(height: 400.0),
                            ],
                          )),
                    ]),
                  ),
                ))
          ]),
        ));
  }
}
