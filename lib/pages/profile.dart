import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:library_pc/controllers/db_helper.dart';
import 'package:library_pc/pages/admin_cred_add_pop.dart';
import 'package:library_pc/pages/admin_cred_update_pop.dart';

import '../admin_page.dart';
import 'issued_books.dart';
import 'view_book_page.dart';
import 'view_users.dart';

class ProfileSetting extends StatefulWidget {
  const ProfileSetting({super.key});

  @override
  State<ProfileSetting> createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
  bool _credExists = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkCredExist();
  }

  void checkCredExist() async {
    var res = await DBHelper.isAdminCredentialsSet();
    if (res != null) {
      setState(() {
        _credExists = res;
        // print(_credExists);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
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
      body: Container(
        child: Center(
          child: Container(
            margin: const EdgeInsets.only(top: 20, bottom: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 61, 4, 68),
                  Color.fromARGB(255, 33, 41, 48)
                ])),
            width: width * 0.8,
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Text(
                    'Introduction',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 21, 130, 163),
                        fontSize: 25,
                        fontFamily: 'Roboto'),
                  ),
                  Text(
                      'Our library management app is your go-to solution for managing your library books and users data. With our easy-to-use interface, admins can efficiently manage user and book data. Our app allows admins to view all necessary data and perform any required actions seamlessly.We understand that managing a library can be time-consuming, so our app aims to simplify the process for you. You can easily manage user data and book data without any hassle. The app is designed to provide a seamless experience and ensure all your library management needs are met.With our app, admins can send emails to users effortlessly. Our email feature is designed to make communication with users seamless and efficient. No more logging in and out of email accounts, our app ensures you can send emails from within the app, providing a hassle-free experience.Our app is developed by Chathura Dilshan, a skilled developer dedicated to providing you with an excellent user experience. So why not give our app a try and simplify your library management tasks today!'),
                  Text(
                    'Setting Up Email Functionality',
                    style: TextStyle(
                        color: Color.fromARGB(255, 21, 163, 85),
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                      'If you want to use email functionality in the app, you need to add your Gmail account that has two-step verification enabled. When you enable two-step verification, Google will ask for a verification code in addition to your password when you sign in. However, since this code is sent to your phone, you cannot use it when sending emails from your app. Instead, you will need to create an app password that is specific to your app. This password is not the same as your Gmail password and should be kept secure. By using the app password, your app can authenticate with Google and send emails on your behalf'),
                  Container(
                    child: Text(
                      '\nIMPORTANT: PLEASE AVOID USING YOUR PERSONAL GMAIL ACCOUNT FOR THIS APPLICATION. IT IS RECOMMENDED TO CREATE A NEW GMAIL ACCOUNT SPECIFICALLY FOR THIS PURPOSE.',
                      style: TextStyle(
                          color: Color.fromARGB(255, 187, 20, 8),
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(top: 20),
                          padding: const EdgeInsets.all(20),
                          width: width * 0.3,
                          height: height * 0.7,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(10)),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Create & use app passwords\n\n",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 41, 79, 176)),
                                ),
                                TextSpan(
                                  text:
                                      "Important: To create an app password, you need 2-Step Verification on your Google Account.\n\n"
                                      "If you use 2-Step-Verification and get a password incorrect error when you sign in, you can try to use an app password.\n\n"
                                      "Go to your Google Account.\n\n"
                                      "Select Security.\n\n"
                                      "Under Signing in to Google, select 2-Step Verification.\n\n"
                                      "At the bottom of the page, select App passwords.\n\n"
                                      "Enter a name that helps you remember where you’ll use the app password.\n\n"
                                      "Select Generate.\n\n"
                                      "To enter the app password, follow the instructions on your screen. The app password is the 16-character code that generates on your device.\n\n"
                                      "Select Done.\n\n"
                                      "If you’ve set up 2-Step Verification but can’t find the option to add an app password, it might be because:\n\n"
                                      "Your Google Account has 2-Step Verification set up only for security keys.\n\n"
                                      "You’re logged into a work, school, or another organization account.\n\n"
                                      "Your Google Account has Advanced Protection.\n\n"
                                      "Tip: Usually, you’ll need to enter an app password once per app or device.",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 61, 138, 186)),
                                ),
                              ],
                            ),
                          )),
                      Container(
                          padding: const EdgeInsets.all(20),
                          width: width * 0.3,
                          height: height * 0.5,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [BoxShadow(blurRadius: 7)],
                              color: Color.fromARGB(255, 22, 22, 22)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: width * 0.28,
                                height: height * 0.07,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color.fromARGB(255, 27, 33, 34)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Gmail & App password Exists',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 64, 179, 255)),
                                    ),
                                    Container(
                                      width: 100,
                                      height: 25,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1,
                                              color: Color.fromARGB(
                                                  255, 222, 216, 224)),
                                          boxShadow: [BoxShadow(blurRadius: 7)],
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: _credExists
                                              ? Color.fromARGB(255, 8, 141, 12)
                                              : Color.fromARGB(
                                                  255, 151, 22, 12)),
                                      child: Center(
                                          child:
                                              Text(_credExists ? 'Yes' : 'No')),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                  width: width * 0.28,
                                  height: height * 0.07,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color.fromARGB(255, 27, 33, 34)),
                                  child: _credExists
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Update Gmail & App Password',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromARGB(
                                                        255, 64, 179, 255))),
                                            Expanded(child: Container()),
                                            GestureDetector(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return GmailAppPwPop();
                                                    });
                                              },
                                              child: Container(
                                                width: 100,
                                                height: 25,
                                                decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(blurRadius: 7)
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: Colors.blueAccent),
                                                child: Center(
                                                    child: Text('Update')),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Add Gmail & App Password',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromARGB(
                                                        255, 64, 179, 255))),
                                            GestureDetector(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return GmailAppPwAddPop();
                                                    });
                                              },
                                              child: Container(
                                                width: 100,
                                                height: 25,
                                                decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(blurRadius: 7)
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: Color.fromARGB(
                                                        255, 51, 199, 71)),
                                                child:
                                                    Center(child: Text('Add')),
                                              ),
                                            ),
                                          ],
                                        )),
                              GestureDetector(
                                onTap: () async {
                                  await DBHelper.downloadAllTables();
                                },
                                child: Container(
                                    width: width * 0.28,
                                    height: height * 0.07,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: LinearGradient(colors: [
                                          Color.fromARGB(255, 5, 15, 107),
                                          Color.fromARGB(255, 8, 172, 82)
                                        ])),
                                    child: Center(
                                      child: Text('Download Tables',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 29, 30, 31))),
                                    )),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                              'Confirm Database Resetting'),
                                          content: Text(
                                              'Do you want to download tables before reset tables?'),
                                          actions: [
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.red),
                                                onPressed: () async {
                                                  final res = await DBHelper
                                                      .resetDatabase();
                                                  // ignore: use_build_context_synchronously
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text(
                                                    'Continue without Downloading')),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Color.fromARGB(
                                                            255, 21, 199, 21)),
                                                onPressed: () async {
                                                  await DBHelper
                                                      .downloadAllTables();
                                                  await DBHelper
                                                      .resetDatabase();
                                                  // ignore: use_build_context_synchronously
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text(
                                                    'Download and Continue'))
                                          ],
                                        );
                                      });
                                },
                                child: Container(
                                    width: width * 0.28,
                                    height: height * 0.07,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: LinearGradient(colors: [
                                          Color.fromARGB(255, 107, 12, 5),
                                          Color.fromARGB(255, 172, 101, 8)
                                        ])),
                                    child: Center(
                                      child: Text('Reset Database',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 16, 32, 48))),
                                    )),
                              ),
                            ],
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
