import 'package:firsstapp/FitnessApp/bloc/auth_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/auth_event.dart';
import 'package:firsstapp/FitnessApp/bloc/auth_state.dart';
import 'package:firsstapp/FitnessApp/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';

import 'package:flutter_email_sender/flutter_email_sender.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
  static const routeName = '/signupscreen';
}

class _SignupState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _tapped = false;
  final _formFieldKey = GlobalKey<FormFieldState>();
  ScrollController _scrollController = ScrollController();
  final Map<String, dynamic> _registerData = {};
  bool _isvisible = false;
  Random random = Random();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.cyan),
        title: Text('Account Registration'),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(children: [
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(0.0, 45, 0, 0),
                  child: Text(
                    "Sign",
                    style: TextStyle(
                      fontFamily: 'Mon',
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0.0, 95, 0, 0),
                  child: Text(
                    "Up",
                    style: TextStyle(
                      fontFamily: 'Mon',
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(70, 95, 0, 0),
                  child: Text(
                    "!",
                    style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Mon',
                        color: Colors.cyan),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(40.0, 25.0, 0.0, 0.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(right: 50),
                    child: TextFormField(
                        initialValue: '',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }

                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Name',
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
                            this._registerData["username"] = value;
                          });
                        }),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20, right: 50),
                    child: TextFormField(
                        initialValue: '',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter email';
                          }

                          String exp =
                              r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
                          if (!RegExp(exp).hasMatch(value)) {
                            return 'Invalid email address';
                          }

                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Email',
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
                            this._registerData["email"] = value;
                          });
                        }),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20, right: 50),
                    child: TextFormField(
                        obscureText: true,
                        key: _formFieldKey,
                        initialValue: '',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter password';
                          }
                          if (value.length < 8) {
                            return 'Invalid password';
                          }

                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Password',
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
                            this._registerData["password"] = value;
                          });
                        }),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20, right: 50),
                    child: TextFormField(
                        obscureText: true,
                        initialValue: '',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter password confirmation';
                          }
                          if (_formFieldKey.currentState!.value != value) {
                            return 'Passwords must match';
                          }

                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
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
                            this._registerData["cpassword"] = value;
                          });
                        }),
                  ),
                  SizedBox(height: 40.0),
                  Container(
                    // padding: const EdgeInsets.symmetric(vertical: 16.0),
                    padding: EdgeInsets.only(right: 50.0),
                    height: 40.0,
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      shadowColor: Colors.cyanAccent,
                      color:
                          _tapped ? Colors.cyan.withOpacity(0.6) : Colors.cyan,
                      elevation: 4.0,
                      child: GestureDetector(
                        onTap: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          setState(() {
                            _tapped = true;
                          });
                          final form = _formKey.currentState;
                          if (form!.validate()) {
                            form.save();
                            final ValidationEvent vevent = ValidationEvent(
                                username: this._registerData['username'],
                                email: this._registerData['email']);

                            BlocProvider.of<AuthBloc>(context).add(vevent);
                            setState(() {
                              _isvisible = true;
                            });
                            WidgetsBinding.instance!.addPostFrameCallback((_) {
                              _scrollController.animateTo(
                                  _scrollController.position.maxScrollExtent,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease);
                            });
                          }

                          Future.delayed(const Duration(milliseconds: 100), () {
                            setState(() {
                              _tapped = false;
                            });
                          });
                        },
                        child: Center(
                          child: Text(
                            "Create Account",
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
                          width: 1.0,
                          style: BorderStyle.solid,
                        ),
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: Text(''),
                          ),
                          SizedBox(width: 10.0),
                          Center(
                            child: Text(
                              "Signup with Facebook",
                              style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: 'Mon',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                            fontFamily: 'Mon',
                            fontSize: 15.0,
                            color: Colors.black),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(LoginScreen.routeName);
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Mon',
                            fontWeight: FontWeight.bold,
                            color: Colors.cyan,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      )
                    ],
                  ),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (_, state) {
                      if (state is SignupFailure) {
                        return Text(state.message);
                      }

                      if (state is SignupSuccess) {
                        Navigator.of(context).pop();
                      }

                      if (state is SignupInProgress) {
                        return CircularProgressIndicator();
                      }
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
                              style: TextStyle(color: Colors.red, fontSize: 15),
                            ),
                          ],
                        );
                      }
                      if (state is ValidationSuccess) {
                        final SignupEvent event = SignupEvent(
                            email: this._registerData['email'],
                            username: this._registerData['username'],
                            password: this._registerData['password']);
                        BlocProvider.of<AuthBloc>(context).add(event);
                      }
                      return Text('');
                    },
                  ),
                  Visibility(
                      visible: _isvisible,
                      child: Column(
                        children: [
                          SizedBox(height: 20.0),
                          SizedBox(height: 200.0),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
