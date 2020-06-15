import 'package:covted_app/notifiers/auth_page_notifier.dart';
import 'package:covted_app/notifiers/page_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/form_fields.dart';

class RegisterPage extends StatelessWidget {
  
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _full_nameController = TextEditingController();
  final TextEditingController _phone_numberController = TextEditingController();
  GlobalKey<FormState> _regFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      width: 1000,
      color: Colors.amber,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
              key: _regFormKey,
              child: Container(
                padding: const EdgeInsets.all(32.0),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    buildFullNameFormField(
                      controller: _full_nameController,
                    ),
                    // Email
                    buildEmailFormField(controller: _emailController),
                    // Phone Number
                    buildPhoneNumberFormField(controller: _phone_numberController),
                    // Password
                    buildPasswordFormField(controller: _passwordController),
                    // Control Button
                    buildSubmitButton(
                      label: 'Register',
                      onClick: () {
                        if (_regFormKey.currentState.validate()) {
                          print(_emailController.text);
                          print(_passwordController.text);
                          print(_phone_numberController.text);
                          print(_full_nameController.text);
                        }
                      }
                    ),
                  ]
                ),
              )
            ),
          ]
        ),
      ),
    );
  }
}