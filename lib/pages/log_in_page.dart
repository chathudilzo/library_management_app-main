import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:library_pc/admin_page.dart';
import 'package:library_pc/controllers/db_helper.dart';

import '../controllers/login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final _regUsernameController = TextEditingController();
  final _regPasswordController = TextEditingController();
  final _regGmailController = TextEditingController();
  final _regAppPwController = TextEditingController();

  final controller = Get.put(LoginController());
  bool _adminExists = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkAdmin();
  }

  void checkAdmin() async {
    final adminExists = await DBHelper.checkAdmin();

    setState(() {
      _adminExists = adminExists;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        width: width,
        height: height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/wall.jpg'), fit: BoxFit.cover),
            gradient: LinearGradient(colors: [
              Color.fromARGB(31, 12, 12, 12),
              Color.fromARGB(255, 14, 13, 13)
            ])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  height: 75,
                  width: 75,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/Libra-fotor-bg-remover-2023052613621.png'),
                          fit: BoxFit.cover)),
                ),
                RichText(
                    text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: 'Libra',
                      style: TextStyle(
                          fontSize: 28,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue)),
                  TextSpan(
                    text: 'Ease',
                    style: TextStyle(
                      //fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color.fromARGB(255, 243, 173, 33),
                    ),
                  )
                ])),
              ],
            )
            // Align(
            //   alignment: Alignment.topLeft,
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       Container(
            //         width: width * 0.2,
            //         height: height * 0.18,
            //         decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(20),
            //             image: DecorationImage(
            //                 image: AssetImage('assets/logo.png'),
            //                 fit: BoxFit.cover)),
            //       ),
            //       Text(
            //         'LM System',
            //         style: GoogleFonts.roboto(
            //             fontSize: 30,
            //             fontWeight: FontWeight.bold,
            //             color: Color.fromARGB(255, 216, 109, 9)),
            //       )
            //     ],
            //   ),
            // ),
            ,
            Container(
              //color: Colors.amber,
              width: width * 0.9,
              height: height * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: width * 0.25,
                        height: height * 0.45,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              child: Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/loggif1.gif'))),
                                ),
                              ),
                              width: width * 0.2,
                              height: height * 0.2,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Color.fromARGB(255, 12, 112, 194),
                                    Color.fromARGB(255, 12, 61, 167)
                                        .withOpacity(0.6)
                                  ]),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            Container(
                              child: Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/loggif2.gif'))),
                                ),
                              ),
                              width: width * 0.2,
                              height: height * 0.2,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Color.fromARGB(255, 12, 112, 194),
                                    Color.fromARGB(255, 12, 61, 167)
                                        .withOpacity(0.6)
                                  ]),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: width * 0.25,
                        height: height * 0.45,
                        //color: Colors.red,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              child: Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/loggif3.gif'))),
                                ),
                              ),
                              width: width * 0.2,
                              height: height * 0.2,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Color.fromARGB(255, 12, 112, 194),
                                    Color.fromARGB(255, 12, 61, 167)
                                        .withOpacity(0.6)
                                  ]),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            Container(
                              child: Center(
                                child: RichText(
                                    text: TextSpan(children: <TextSpan>[
                                  TextSpan(
                                      text: 'Wel',
                                      style: TextStyle(
                                          fontSize: 28,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue)),
                                  TextSpan(
                                    text: 'come',
                                    style: TextStyle(
                                      //fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 243, 173, 33),
                                    ),
                                  )
                                ])),
                              ),
                              width: width * 0.2,
                              height: height * 0.2,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Color.fromARGB(255, 12, 112, 194),
                                    Color.fromARGB(255, 12, 61, 167)
                                        .withOpacity(0.6)
                                  ]),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.only(
                              top: 5, bottom: 5, left: 20, right: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              // boxShadow: [
                              //   BoxShadow(
                              //       blurRadius: 5,
                              //       spreadRadius: 7,
                              //       offset: Offset(1, 3),
                              //       color: Color.fromARGB(255, 20, 20, 20))
                              // ],
                              color: Color.fromARGB(255, 49, 58, 107)
                                  .withOpacity(0.5)
                              // gradient: LinearGradient(colors: [
                              //   Color.fromARGB(255, 4, 21, 99),
                              //   Color.fromARGB(255, 26, 23, 23)
                              //]
                              //)
                              ),
                          width: width / 3.4,
                          height: height * 0.7,
                          child: _adminExists
                              ? Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Login',
                                          style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 182, 158, 21),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Center(
                                      child: Container(
                                        width: 110,
                                        height: 150,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/logowl.png'),
                                                fit: BoxFit.fill)),
                                      ),
                                    ),
                                    SizedBox(height: height * 0.1),
                                    Form(
                                        key: _formKey,
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              controller: _usernameController,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please Input username';
                                                }
                                              },
                                              decoration: InputDecoration(
                                                  hintText: 'Username',
                                                  prefixIcon:
                                                      Icon(Icons.person),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10))),
                                            ),
                                            SizedBox(
                                              height: height * 0.02,
                                            ),
                                            TextFormField(
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please input your password';
                                                }
                                              },
                                              controller: _passwordController,
                                              decoration: InputDecoration(
                                                  hintText: 'Password',
                                                  prefixIcon: Icon(
                                                      Icons.remove_red_eye),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10))),
                                            ),
                                            SizedBox(
                                              height: height * 0.02,
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  await controller
                                                      .loadAdminCredentials();
                                                  final result =
                                                      await controller.login(
                                                          _usernameController
                                                              .text,
                                                          _passwordController
                                                              .text);
                                                }
                                              },
                                              child: Container(
                                                child: Center(
                                                  child: Text('Login'),
                                                ),
                                                width: width * 0.1,
                                                height: height * 0.06,
                                                decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                          blurRadius: 5,
                                                          color: Color.fromARGB(
                                                              255, 15, 4, 75))
                                                    ],
                                                    color: Color.fromARGB(
                                                            255, 10, 52, 87)
                                                        .withOpacity(0.6),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                              ),
                                            )
                                          ],
                                        ))
                                  ],
                                )
                              : SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Create Your Admin Account',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.amber,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: height * 0.02,
                                      ),
                                      Center(
                                        child: Container(
                                          width: 70,
                                          height: 100,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/logowl.png'),
                                                  fit: BoxFit.fill)),
                                        ),
                                      ),
                                      Form(
                                          key: _formKey1,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              TextFormField(
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Username cannot be empty';
                                                  }
                                                },
                                                controller:
                                                    _regUsernameController,
                                                decoration: InputDecoration(
                                                    hintText: 'Username',
                                                    prefixIcon:
                                                        Icon(Icons.person),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.black),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10)),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.black),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10)),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10))),
                                              ),
                                              SizedBox(
                                                height: height * 0.02,
                                              ),
                                              TextFormField(
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Password cannot be empty';
                                                  }
                                                },
                                                controller:
                                                    _regPasswordController,
                                                decoration: InputDecoration(
                                                    hintText: 'Password',
                                                    prefixIcon: Icon(
                                                        Icons.remove_red_eye),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.black),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10)),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.black),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10))),
                                              ),
                                              SizedBox(
                                                height: height * 0.02,
                                              ),
                                              TextFormField(
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                controller: _regGmailController,
                                                decoration: InputDecoration(
                                                    hintText: 'Gmail',
                                                    prefixIcon: Icon(
                                                        Icons.email_outlined),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.black),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10)),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.black),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10))),
                                              ),
                                              SizedBox(
                                                height: height * 0.02,
                                              ),
                                              TextFormField(
                                                // validator: (value) {
                                                //   if (value != null||value.isNotEmpty) {
                                                //     if (value.length < 16) {
                                                //       return 'APP Password must have 16digits';
                                                //     }
                                                //   }
                                                // },
                                                controller: _regAppPwController,
                                                decoration: InputDecoration(
                                                    hintText: 'APP Password',
                                                    prefixIcon:
                                                        Icon(Icons.password),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.black),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10)),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.black),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10))),
                                              ),
                                              SizedBox(
                                                height: height * 0.02,
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  if (_formKey1.currentState!
                                                      .validate()) {
                                                    final res = await DBHelper
                                                        .registerAdmin(
                                                            _regUsernameController
                                                                .text,
                                                            _regPasswordController
                                                                .text,
                                                            _regGmailController
                                                                .text,
                                                            _regAppPwController
                                                                .text);
                                                    if (res) {
                                                      Get.offAll(
                                                          () => AdminPage());
                                                    }
                                                  }
                                                },
                                                child: Container(
                                                  child: Center(
                                                    child: Text('Create'),
                                                  ),
                                                  width: width * 0.1,
                                                  height: height * 0.06,
                                                  decoration: BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                            blurRadius: 5,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    7,
                                                                    7,
                                                                    6))
                                                      ],
                                                      color: Color.fromARGB(
                                                              255, 7, 186, 218)
                                                          .withOpacity(0.6),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                ),
                                              ),
                                              TextButton(
                                                  onPressed: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title: Text(
                                                                'App Password'),
                                                            content:
                                                                SingleChildScrollView(
                                                              child: Container(
                                                                width:
                                                                    width * 0.5,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                      'If you want to use email functionality in the app, you need to add your Gmail account that has two-step verification enabled. When you enable two-step verification, Google will ask for a verification code in addition to your password when you sign in. However, since this code is sent to your phone, you cannot use it when sending emails from your app. Instead, you will need to create an app password that is specific to your app. This password is not the same as your Gmail password and should be kept secure. By using the app password, your app can authenticate with Google and send emails on your behalf',
                                                                      style: TextStyle(
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              237,
                                                                              240,
                                                                              240),
                                                                          fontSize:
                                                                              16),
                                                                    ),
                                                                    Container(
                                                                      child:
                                                                          Text(
                                                                        '\nIMPORTANT: PLEASE AVOID USING YOUR PERSONAL GMAIL ACCOUNT FOR THIS APPLICATION. IT IS RECOMMENDED TO CREATE A NEW GMAIL ACCOUNT SPECIFICALLY FOR THIS PURPOSE.',
                                                                        style: TextStyle(
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                160,
                                                                                41,
                                                                                5),
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize: 22),
                                                                      ),
                                                                    ),
                                                                    RichText(
                                                                      text:
                                                                          TextSpan(
                                                                        children: [
                                                                          TextSpan(
                                                                            text:
                                                                                "Create & use app passwords\n\n",
                                                                            style: TextStyle(
                                                                                fontSize: 20,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Color.fromARGB(255, 8, 8, 8)),
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
                                                                                color: Colors.amber),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                        'Google it for get more information about APP Password'),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        });
                                                  },
                                                  child: Text(
                                                      'What is APP Password?'))
                                            ],
                                          ))
                                    ],
                                  ),
                                )),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
