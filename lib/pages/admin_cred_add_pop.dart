import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:library_pc/controllers/db_helper.dart';

class GmailAppPwAddPop extends StatefulWidget {
  const GmailAppPwAddPop({super.key});

  @override
  State<GmailAppPwAddPop> createState() => _GmailAppPwAddPopState();
}

class _GmailAppPwAddPopState extends State<GmailAppPwAddPop> {
  final _formKey = GlobalKey<FormState>();
  final _gmailController = TextEditingController();
  final _PwController = TextEditingController();
  final _usernameController = TextEditingController();
  final _currentPwController = TextEditingController();
  final _currentusernameController = TextEditingController();

  final _upwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Email & App Password'),
      content: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Input Current Username';
                    }
                  },
                  controller: _currentusernameController,
                  decoration: InputDecoration(
                      hintText: 'admin',
                      label: Text('Current Username'),
                      prefixIcon: Icon(Icons.person)),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Input Current Password';
                    }
                  },
                  controller: _currentPwController,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      label: Text('Current Password'),
                      prefixIcon: Icon(Icons.remove_red_eye)),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Input Username';
                    }
                  },
                  controller: _usernameController,
                  decoration: InputDecoration(
                      hintText: 'admin',
                      label: Text('Username'),
                      prefixIcon: Icon(Icons.person)),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Input Password';
                    }
                  },
                  controller: _upwController,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      label: Text('Password'),
                      prefixIcon: Icon(Icons.remove_red_eye)),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Input Gmail Address';
                    }
                    if (!value.contains('@gmail.com')) {
                      return 'Invalid Gmail Address';
                    }
                  },
                  controller: _gmailController,
                  decoration: InputDecoration(
                      hintText: 'example@gmail.com',
                      label: Text('Email'),
                      prefixIcon: Icon(Icons.email)),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Input App Password';
                    }
                    if (value.length < 16) {
                      return 'App Password must have 16 digits.';
                    }
                  },
                  controller: _PwController,
                  decoration: InputDecoration(
                      hintText: 'xxxx xxxx xxxx xxxx',
                      label: Text('App Password'),
                      prefixIcon: Icon(Icons.password)),
                )
              ],
            )),
      ),
      actions: [
        ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                DBHelper.addAdmin(
                    _currentusernameController.text,
                    _currentPwController.text,
                    _usernameController.text,
                    _upwController.text,
                    _gmailController.text,
                    _PwController.text);
                Navigator.of(context).pop();
              }
            },
            child: Text('Add')),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'))
      ],
    );
  }
}
