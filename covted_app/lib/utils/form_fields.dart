import 'package:flutter/material.dart';

Widget buildFullNameFormField({controller}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      controller: controller,
      keyboardType: TextInputType.text,
      decoration: _inputDecoration('Full name'),
      validator: (value) {
        if (value == '') {
          return 'Full name is required';
        }
      },
    ),
  );
}

Widget buildEmailFormField({controller}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      decoration: _inputDecoration('Email Address'),
      validator: (value) {
        if (value == '') {
          return 'Email is required';
        } else if (!value.contains('@')) {
          return 'Enter a valid Email';
        }
      },
    ),
  );
}

Widget buildPasswordFormField({controller}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      controller: controller,
      keyboardType: TextInputType.visiblePassword,
      decoration: _inputDecoration('Password'),
      obscureText: true,
      validator: (value) {
        if (value == '') {
          return 'Password is required';
        }
      },
    ),
  );
}

Widget buildPhoneNumberFormField({controller}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
      child: TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: _inputDecoration('Phone Number'),
      validator: (value) {
        if (value == '') {
          return 'Phone Number Is required';
        }
      },
    ),
  );
}


Widget buildSubmitButton({Function onClick, label}) {
  return InkWell(
    hoverColor: Colors.amber,
    splashColor: Colors.amber,
    onTap: onClick,
    child: RaisedButton(
      onPressed: null,
      child: Text(label, style: TextStyle(color: Colors.white),),
    ),
  );
}

InputDecoration _inputDecoration(label) {
  return InputDecoration(
    focusedBorder: OutlineInputBorder(),
    focusColor: Colors.greenAccent,
    hintText: label,
    labelText: label,
    border: OutlineInputBorder()
  );
}