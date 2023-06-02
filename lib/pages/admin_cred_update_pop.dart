import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:library_pc/controllers/db_helper.dart';

class GmailAppPwPop extends StatefulWidget {
  const GmailAppPwPop({super.key});

  @override
  State<GmailAppPwPop> createState() => _GmailAppPwPopState();
}

class _GmailAppPwPopState extends State<GmailAppPwPop> {
  final _formKey = GlobalKey<FormState>();
  final _gmailController = TextEditingController();
  final _PWController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Update Gmail & APP Pasword'),
      content: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _gmailController,
                    decoration: InputDecoration(
                        labelText: 'Gmail', hintText: 'example.gmail.com'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter your Gmail';
                      }
                    },
                  ),
                  TextFormField(
                    controller: _PWController,
                    decoration: InputDecoration(
                        labelText: 'App Password',
                        hintText: 'nyop xxxx xxxx xxxx'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter your App Password';
                      }
                    },
                  ),
                ],
              ))),
      actions: [
        ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final res = await DBHelper.updateAdminCred(
                    _gmailController.text, _PWController.text);
                Navigator.of(context).pop();
              }
            },
            child: Text('Update')),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'))
      ],
    );
  }
}
