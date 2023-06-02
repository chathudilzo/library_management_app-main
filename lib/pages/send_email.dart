import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:library_pc/controllers/db_helper.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

import '../admin_page.dart';
import 'issued_books.dart';
import 'profile.dart';
import 'view_book_page.dart';
import 'view_users.dart';

class SendMail extends StatefulWidget {
  const SendMail({super.key});

  @override
  State<SendMail> createState() => _SendMailState();
}

class _SendMailState extends State<SendMail> {
  String username = '';
  String password = '';

  String _message = '';
  String _recgmail = '';
  String _subj = '';

  TextEditingController _emailController = TextEditingController();
  TextEditingController _subjController = TextEditingController();
  TextEditingController _msgController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCredentials();
  }

  void sendEmail() async {
    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'LM System')
      ..recipients.add(_recgmail)
      ..subject = _subj
      ..text = _message;

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
      Get.snackbar('Success', sendReport.toString());
    } catch (e) {
      print('Error sending email: $e');
      Get.snackbar('ERROR',
          'You need to add Gmail and App Password to the app to use this functionality');
      Get.snackbar('Error', e.toString());
    }
  }

  void getCredentials() async {
    final data = await DBHelper.getAdminCredentials();
    setState(() {
      username = data['gmail'].toString();
      password = data['gpassword'].toString();
    });
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 35, 42, 54),
        appBar: AppBar(
          title: Text('Send Gmail'),
          actions: [
            IconButton(
                hoverColor: Color.fromARGB(255, 96, 102, 104),
                tooltip: 'Home',
                onPressed: () => Get.to(() => AdminPage()),
                icon: Icon(Icons.home)),
            IconButton(
                hoverColor: Color.fromARGB(255, 96, 102, 104),
                tooltip: 'View Books',
                onPressed: () => Get.to(() => ViewBooks()),
                icon: Icon(Icons.book)),
            IconButton(
                hoverColor: Color.fromARGB(255, 96, 102, 104),
                tooltip: 'View Users',
                onPressed: () => Get.to(() => ViewUsers()),
                icon: Icon(Icons.person)),
            IconButton(
                hoverColor: Color.fromARGB(255, 96, 102, 104),
                tooltip: 'View Issued Books',
                onPressed: () => Get.to(() => IssuedBooks()),
                icon: Icon(Icons.menu_book_sharp)),
            IconButton(
                hoverColor: Color.fromARGB(255, 96, 102, 104),
                tooltip: 'Settings',
                onPressed: () => Get.to(() => ProfileSetting()),
                icon: Icon(Icons.settings))
          ],
        ),
        body: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  width: width / 2,
                  height: height / 1.5,
                  decoration: BoxDecoration(
                      boxShadow: [BoxShadow(blurRadius: 7, spreadRadius: 5)],
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(colors: [
                        Colors.blueAccent,
                        Color.fromARGB(255, 23, 18, 109)
                      ])),
                  child: Center(
                    child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FormF(
                                controller: _emailController,
                                pricon: Icon(Icons.email),
                                errt: 'Please Input Receiver Email Address',
                                hintt: 'example.gmail.com',
                                label: 'Receiver Email'),
                            FormF(
                                label: 'Subtitle',
                                controller: _subjController,
                                pricon: Icon(Icons.title),
                                errt: 'Please Input Email Subtitle',
                                hintt: 'Something to be done'),
                            FormF(
                                label: 'Text Message',
                                controller: _msgController,
                                pricon: Icon(Icons.text_fields_outlined),
                                errt: 'Please Input Your Message',
                                hintt: 'lorem ipsam'),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        _recgmail = _emailController.text;
                                        _message = _msgController.text;
                                        _subj = _subjController.text;
                                        sendEmail();
                                        // print('$_recgmail $_subj $_message');
                                      });
                                    }
                                  },
                                  child: Container(
                                    width: width * 0.1,
                                    height: height * 0.05,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 5, spreadRadius: 2)
                                        ],
                                        borderRadius: BorderRadius.circular(10),
                                        color:
                                            Color.fromARGB(255, 39, 39, 181)),
                                    child: Center(child: Text('Send')),
                                  ),
                                )
                              ],
                            )
                          ],
                        )),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class FormF extends StatelessWidget {
  const FormF(
      {super.key,
      required this.controller,
      required this.pricon,
      required this.errt,
      required this.hintt,
      required this.label});

  final TextEditingController controller;
  final Icon pricon;
  final String hintt;
  final String errt;
  final String label;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width / 4,
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
                color: Color.fromARGB(255, 5, 18, 40),
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
          TextFormField(
            controller: controller,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return errt;
              }
            },
            decoration: InputDecoration(
                hintText: hintt,
                prefixIcon: pricon,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
        ],
      ),
    );
  }
}
