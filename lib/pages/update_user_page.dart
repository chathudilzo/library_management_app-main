import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:library_pc/controllers/db_helper.dart';
import 'package:library_pc/pages/view_users.dart';

import '../admin_page.dart';
import 'issued_books.dart';
import 'profile.dart';
import 'view_book_page.dart';

class UpdateUser extends StatelessWidget {
  UpdateUser(
      {super.key,
      required this.IndexNo,
      required this.FullName,
      required this.Class,
      required this.Address,
      required this.Guardian,
      required this.Charges,
      required this.email,
      required this.tp});

  final String IndexNo;
  final String FullName;
  final String Class;
  final String Address;
  final String Guardian;
  final String Charges;
  final String email;
  final String tp;
  final _formKey = GlobalKey<FormState>();

  TextEditingController _indexController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _classController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _guardianController = TextEditingController();
  TextEditingController _chargesController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _tpController = TextEditingController();

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    _indexController.text = IndexNo;
    _nameController.text = FullName;
    _classController.text = Class;
    _addressController.text = Address;
    _guardianController.text = Guardian;
    _chargesController.text = Charges;
    _emailController.text = email;
    _tpController.text = tp;

    return Scaffold(
      appBar: AppBar(
        title: Text('Update User'),
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
          padding: const EdgeInsets.only(top: 10),
          width: width * 0.7,
          height: height * 0.9,
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(blurRadius: 5)],
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 70, 80, 75),
                Color.fromARGB(255, 25, 8, 136)
              ])),
          child: Column(children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              width: width * 0.15,
              height: height * 0.20,
              decoration: BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage('assets/change.png'))),
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TField(
                            canNull: false,
                            errtxt: 'Index Number Cannot Be Empty.',
                            hinttxt: 'AAxxxx',
                            icn: Icon(Icons.person_add),
                            controller: _indexController,
                            editable: false),
                        TField(
                            canNull: false,
                            errtxt: 'Full Name  Cannot Be Empty.',
                            hinttxt: 'John Ibraham',
                            icn: Icon(Icons.person),
                            controller: _nameController,
                            editable: true)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TField(
                            canNull: false,
                            errtxt: 'Class Cannot Be Empty.',
                            hinttxt: '11C',
                            icn: Icon(Icons.group),
                            controller: _classController,
                            editable: true),
                        TField(
                            canNull: false,
                            errtxt: 'Address Cannot Be Empty.',
                            hinttxt: 'Yakdehiwatta Niwithigala',
                            icn: Icon(Icons.post_add),
                            controller: _addressController,
                            editable: true),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TField(
                            canNull: false,
                            errtxt: 'Guardian Cannot Be Empty.',
                            hinttxt: 'S.W. Sirixxxx',
                            icn: Icon(Icons.shield),
                            controller: _guardianController,
                            editable: true),
                        TField(
                            canNull: false,
                            errtxt: 'Charges Cannot Be Empty.',
                            hinttxt: '20',
                            icn: Icon(Icons.attach_money_outlined),
                            controller: _chargesController,
                            editable: true),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TField(
                            canNull: true,
                            errtxt: 'Email Cannot Be Empty.',
                            hinttxt: 'xxxexample@gmail.com',
                            icn: Icon(Icons.email),
                            controller: _emailController,
                            editable: true),
                        TField(
                            canNull: true,
                            errtxt: 'Contact Number Cannot Be Empty.',
                            hinttxt: '07xxxxxxxx',
                            icn: Icon(Icons.mobile_screen_share),
                            controller: _tpController,
                            editable: true),
                      ],
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          final res = await DBHelper.updateUser(
                              _indexController.text,
                              _nameController.text,
                              _classController.text,
                              _addressController.text,
                              _guardianController.text,
                              _chargesController.text,
                              _emailController.text,
                              _tpController.text);

                          if (res == true) {
                            Get.offAll(() => ViewUsers());
                          }
                        }
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: width * 0.08,
                              height: height * 0.055,
                              decoration: BoxDecoration(
                                  boxShadow: [BoxShadow(blurRadius: 7)],
                                  color: Color.fromARGB(255, 84, 4, 149),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                  child: Text(
                                'Update',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                            ),
                            // SizedBox(
                            //   width: width * 0.1,
                            // ),
                            // ElevatedButton(
                            //   style: ElevatedButton.styleFrom(
                            //       backgroundColor:
                            //           Color.fromARGB(255, 151, 19, 10)),
                            //   onPressed: () {
                            //     showDialog(
                            //         context: context,
                            //         builder: (BuildContext context) {
                            //           return AlertDialog(
                            //             title: Text('Confirm user delete'),
                            //             content: Text(
                            //                 'Do you want to delete user $IndexNo from users'),
                            //             actions: [
                            //               ElevatedButton(
                            //                   onPressed: () async {
                            //                     await DBHelper
                            //                         .deleteUserByIndex(IndexNo);
                            //                     Navigator.of(context).pop();
                            //                   },
                            //                   child: Text('Yes')),
                            //               ElevatedButton(
                            //                   onPressed: () async {
                            //                     Navigator.of(context).pop();
                            //                   },
                            //                   child: Text('No')),
                            //             ],
                            //           );
                            //         });
                            //   },
                            //   child: Text('Delete'),
                            // )
                          ]),
                    )
                  ],
                )),
          ]),
        ),
      ),
    );
  }
}

class TField extends StatelessWidget {
  TField(
      {super.key,
      required this.errtxt,
      required this.hinttxt,
      required this.icn,
      required this.controller,
      required this.editable,
      required this.canNull});

  String errtxt;
  String hinttxt;
  Icon icn;
  TextEditingController controller;
  final bool editable;
  final bool canNull;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: width * 0.25,
      height: height * 0.07,
      decoration: BoxDecoration(
          boxShadow: [BoxShadow(blurRadius: 5)],
          color: editable == false
              ? Color.fromARGB(255, 111, 31, 25)
              : Color.fromARGB(255, 89, 76, 100),
          borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        enabled: editable,
        validator: !canNull
            ? (value) {
                if (value!.isEmpty) {
                  return errtxt;
                }
              }
            : null,
        controller: controller,
        decoration: InputDecoration(
            hintText: hinttxt,
            prefixIcon: icn,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}
