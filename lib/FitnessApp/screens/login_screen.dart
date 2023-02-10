import 'dart:isolate';

import 'package:firsstapp/FitnessApp/bloc/auth_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/auth_event.dart';
import 'package:firsstapp/FitnessApp/bloc/auth_state.dart';
import 'package:firsstapp/FitnessApp/screens/confirmation_screen.dart';
import 'package:firsstapp/FitnessApp/screens/forgot_screen.dart';
import 'package:firsstapp/FitnessApp/screens/plans/goal_ui.dart';
import 'package:firsstapp/FitnessApp/screens/signup_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

import 'home.dart';

class LoginScreen extends StatefulWidget {
  _LoginFormState createState() => _LoginFormState();
  static const routeName = '/';
  static final GetStorage box = GetStorage();
  ConfirmationEvent cEvent;
  bool successAccess;
  LoginScreen(
      [this.cEvent = const ConfirmationEvent(), this.successAccess = false]);
}

class _LoginFormState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _userCredential = {};
  ScrollController _scrollController = ScrollController();
  bool _tapped = false;
  bool _isvisible = false;
  bool _isDisabled = false;

  @override
  Widget build(BuildContext context) {
    //bool checker = widget.successAccess ?? false;
    if (widget.successAccess) {
      BlocProvider.of<AuthBloc>(context).add(widget.cEvent);
      setState(() {
        _isDisabled = true;
        _isvisible = true;
      });

      WidgetsBinding.instance!.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 500),
              curve: Curves.ease);
        }
      });
    }
    TextStyle defaultStyle = TextStyle(color: Colors.grey, fontSize: 20.0);
    TextStyle linkStyle = TextStyle(color: Colors.blue);

    return Scaffold(
        appBar: AppBar(
          title: Text('Login To Your Account'),
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
                      "Welcome To",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          fontFamily: "Mon"),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20.0, 160, 0, 0),
                    child: Text(
                      "Social Fitness",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          fontFamily: "Mon"),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(270, 150, 0, 0),
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
                key: _formKey,
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
                                this._userCredential["username"] = value;
                              });
                            }),
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.only(top: 20.0, right: 100),
                        child: TextFormField(
                            obscureText: true,
                            initialValue: '',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your password';
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
                              this._userCredential["password"] = value;
                            }),
                      ),
                      SizedBox(height: 5.0),
                      Container(
                        padding: EdgeInsets.fromLTRB(50.0, 25.0, 0.0, 0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(ForgotScreen.routeName);
                          },
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: "Mon",
                              fontWeight: FontWeight.bold,
                              color: Colors.cyan,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
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
                                    setState(() {
                                      _tapped = true;
                                    });
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    final form = _formKey.currentState;
                                    if (form!.validate()) {
                                      form.save();
                                      final LoginEvent event = LoginEvent(
                                          username:
                                              this._userCredential['username'],
                                          password:
                                              this._userCredential['password']);

                                      BlocProvider.of<AuthBloc>(context)
                                          .add(event);
                                      setState(() {
                                        _isvisible = true;
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
                                "LOGIN",
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
                      SizedBox(height: 20.0),
                      Container(
                        padding: EdgeInsets.only(right: 50.0),
                        height: 40.0,
                        color: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              style: BorderStyle.solid,
                              width: 1.0,
                            ),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              // Center(
                              //   child: ImageIcon(AssetImage('assets/images/trainerlogo5.jpg')),
                              // ),
                              // SizedBox(width: 10.0),

                              Center(
                                child: Text(
                                  'LogIn as a Trainer',
                                  style: TextStyle(
                                    fontFamily: 'Mon',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 35.0),
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (_, state) {
                          if (state is LoginFailure) {
                            String message =
                                state.message.replaceAll('Exception: ', '');

                            return Text(
                              '***$message',
                              style: TextStyle(color: Colors.red, fontSize: 15),
                            );
                          }
                          if (state is LoginInProgress) {
                            return CircularProgressIndicator();
                          }

                          if (state is LoginSuccess) {
                            WidgetsBinding.instance!.addPostFrameCallback((_) {
                              setState(() {
                                _isDisabled = true;
                              });
                            });

                            LoginScreen.box.write(
                                'username', this._userCredential['username']);
                            LoginScreen.box.write(
                                'password', this._userCredential['password']);

                            BlocProvider.of<AuthBloc>(context)
                                .add(ConfirmationEvent());
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
                            ConfirmationScreen cscreen =
                                ConfirmationScreen(token: state.token);
                            BlocProvider.of<AuthBloc>(context).add(
                                ConfirmationValidation(
                                    cscreen: cscreen, token: state.token));
                            return Column(
                              children: [
                                Text(
                                  'Enter confirmation code',
                                  style: TextStyle(
                                      color: Colors.cyan, fontSize: 17),
                                ),
                                cscreen
                              ],
                            );
                          }
                          if (state is ConfirmationSuccess) {
                            LoginScreen.box
                                .write('isconfirmed', state.isConfirmed);
                            if (state.isConfirmed) {
                              Future.delayed(Duration.zero, () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                  Goal.routeName,
                                  (route) => false,
                                );
                              });
                            } else {
                              BlocProvider.of<AuthBloc>(context).add(EmailEvent(
                                  email: LoginScreen.box.read('username')));
                            }
                          }
                          if (state is ConfirmationRight) {
                            BlocProvider.of<AuthBloc>(context).add(
                                FinalConfirmationEvent(cscreen: state.cscreen));
                          }
                          if (state is FinalConfirmation) {
                            Future.delayed(Duration.zero, () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                Goal.routeName,
                                (route) => false,
                              );
                            });
                          }

                          if (state is FinalConfirmationFailure) {
                            state.cscreen.controller1.text = '';
                            state.cscreen.controller2.text = '';
                            state.cscreen.controller3.text = '';
                            state.cscreen.controller4.text = '';
                            return Column(children: [
                              state.cscreen,
                              Text(
                                  'Unable to confirm, check your connection and try again'),
                            ]);
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
                          if (state is! SignupSuccess) {
                            return Column(children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context)
                                          .pushNamed(SignupScreen.routeName);
                                    },
                                    child: Text(
                                      "Sign Up",
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Mon',
                                        color: Colors.cyan,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 40,
                              )
                            ]);
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
