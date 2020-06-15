import 'package:covted_app/custom_widgets/display.dart';
import 'package:covted_app/models/PageData.dart';
import 'package:covted_app/models/UserModel.dart';
import 'package:covted_app/notifiers/page_notifier.dart';
import 'package:covted_app/notifiers/user_notifier.dart';
import 'package:covted_app/pages/Dashboard.dart';
import 'package:covted_app/utils/form_fields.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    PageNotifier _pageNotifier = Provider.of<PageNotifier>(context);
    UserNotifier _userNotifier = Provider.of<UserNotifier>(context);

    bool isLoading = _pageNotifier.getIsLoading;
    
    return Container(
      // decoration: BoxDecoration(
      //   image: DecorationImage(
      //     image: AssetImage('assets/images/image.png'),
      //     fit: BoxFit.cover,
      //   )
      // ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
              key: _loginFormKey,
              child: Container(
                padding: const EdgeInsets.all(32.0),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CircleAvatar(
                        child: Icon(Icons.lock_open, size: 70, color: Colors.amber,),
                        radius: 70
                      ),
                    ),
                    buildEmailFormField(controller: _emailController),
                    buildPasswordFormField(controller: _passwordController),
                    isLoading ? CircularProgressIndicator() :
                    buildSubmitButton(
                      label: 'Login',
                      onClick: () async {
                        if (_loginFormKey.currentState.validate()) {
                          _pageNotifier.changeLoading();
                          User userData = User(email: _emailController.text, name: 'Kabir toyyib');
                          User user = await _userNotifier.login(userData);
                          if (user != null) {
                            _pageNotifier.changeScreen(context, PageData(page_title: 'DashBoard', screen: DashBoard()));
                          } else {
                            _pageNotifier.changeLoading();
                          }
                        }
                      },
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