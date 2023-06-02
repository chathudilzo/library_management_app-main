import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:library_pc/controllers/db_helper.dart';
import 'package:library_pc/pages/view_users.dart';

import '../admin_page.dart';
import 'issued_books.dart';
import 'profile.dart';
import 'view_book_page.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({super.key});

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
//IndexNo,FullName,Class,Address,Parent_or_Guardian,charges,lastUpdatedDate

  TextEditingController _indexController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _classController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _parentController = TextEditingController();
  TextEditingController _chargesController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _tpnumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void reset() {
    _indexController.clear();
    _nameController.clear();
    _classController.clear();
    _addressController.clear();
    _parentController.clear();
    _chargesController.clear();
    _emailController.clear();
    _tpnumberController.clear();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Register User'),
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
          padding: const EdgeInsets.all(10),
          width: width / 2,
          height: height,
          child: Container(
            decoration: BoxDecoration(
                boxShadow: [BoxShadow(blurRadius: 7)],
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 22, 22, 32),
                  Color.fromARGB(255, 2, 39, 54)
                ])),
            child: Column(
              children: [
                Center(
                  child: Text(
                    'User Registration',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Color.fromARGB(255, 56, 70, 91)),
                  ),
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.06,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            FormFieldWid(
                              controller: _indexController,
                              labelText: 'Index No',
                              hintText: 'AAxxxx',
                              errText: 'Please Input Index No',
                              icon: Icon(
                                Icons.person_add,
                                color: Color.fromARGB(255, 165, 48, 5),
                              ),
                              isNumber: false,
                              canNull: false,
                            ),
                            SizedBox(
                              height: height * 0.15,
                            ),
                            FormFieldWid(
                              controller: _nameController,
                              labelText: 'FullName',
                              hintText: 'Dominic Rodrigo',
                              errText: 'Please Input Fullname',
                              icon: Icon(Icons.person,
                                  color: Color.fromARGB(255, 165, 48, 5)),
                              isNumber: false,
                              canNull: false,
                            ),
                            SizedBox(
                              height: height * 0.15,
                            ),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            FormFieldWid(
                              controller: _classController,
                              labelText: 'Class',
                              hintText: '10D',
                              errText: 'Please Input class',
                              icon: Icon(Icons.group,
                                  color: Color.fromARGB(255, 165, 48, 5)),
                              isNumber: false,
                              canNull: false,
                            ),
                            SizedBox(
                              height: height * 0.15,
                            ),
                            FormFieldWid(
                              controller: _addressController,
                              labelText: 'Address',
                              hintText: 'Yakdehiwatta-Pathakada',
                              errText: 'Please Input Address',
                              icon: Icon(Icons.post_add,
                                  color: Color.fromARGB(255, 165, 48, 5)),
                              isNumber: false,
                              canNull: false,
                            ),
                            SizedBox(
                              height: height * 0.15,
                            ),
                          ],
                        ),
                        //IndexNo,FullName,Class,Address,Parent_or_Guardian,charges,lastUpdatedDate
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            FormFieldWid(
                              controller: _parentController,
                              labelText: 'Parent OR Guardian',
                              hintText: 'M.L.R weerarathna',
                              errText: 'Please Input Parent OR Guardian Name',
                              icon: Icon(Icons.shield,
                                  color: Color.fromARGB(255, 165, 48, 5)),
                              isNumber: false,
                              canNull: false,
                            ),
                            SizedBox(
                              height: height * 0.15,
                            ),
                            FormFieldWid(
                              controller: _chargesController,
                              labelText: 'Charges RS:',
                              hintText: '20',
                              errText: 'Please Input charges in Rupees',
                              icon: Icon(Icons.attach_money,
                                  color: Color.fromARGB(255, 165, 48, 5)),
                              isNumber: true,
                              canNull: false,
                            ),
                            SizedBox(
                              height: height * 0.15,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            FormFieldWid(
                              controller: _emailController,
                              labelText: 'Email',
                              hintText: 'example@gmail.com',
                              errText: 'Please Input Email',
                              icon: Icon(Icons.email,
                                  color: Color.fromARGB(255, 165, 48, 5)),
                              isNumber: false,
                              canNull: true,
                            ),
                            SizedBox(
                              height: height * 0.15,
                            ),
                            FormFieldWid(
                              controller: _tpnumberController,
                              labelText: 'Contant Number',
                              hintText: '07x xxx xxxx',
                              errText: 'Please Input Mobile Number',
                              icon: Icon(Icons.mobile_screen_share,
                                  color: Color.fromARGB(255, 165, 48, 5)),
                              isNumber: true,
                              canNull: true,
                            ),
                            SizedBox(
                              height: height * 0.15,
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              final result = await DBHelper.addUser(
                                  _indexController.text,
                                  _nameController.text,
                                  _classController.text,
                                  _addressController.text,
                                  _parentController.text,
                                  _chargesController.text,
                                  _emailController.text,
                                  _tpnumberController.text);
                              if (result == true) {
                                setState(() {
                                  reset();
                                });
                              }
                            }
                          },
                          child: Container(
                            width: width * 0.4,
                            child: Row(
                              children: [
                                Expanded(child: Container()),
                                Container(
                                  width: width * 0.09,
                                  height: height * 0.05,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 53, 51, 45),
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [BoxShadow(blurRadius: 7)]),
                                  child: Center(
                                    child: Text(
                                      'Submit',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FormFieldWid extends StatelessWidget {
  const FormFieldWid(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.hintText,
      required this.errText,
      required this.icon,
      required this.isNumber,
      required this.canNull});

  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final String errText;
  final Icon icon;
  final bool isNumber;
  final bool canNull;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width / 5,
      height: height * 0.15,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 18, 165, 62)),
          ),
          Container(
            child: TextFormField(
              validator: !canNull
                  ? (value) {
                      if (value == null || value.isEmpty) {
                        return errText;
                      }
                    }
                  : null,
              keyboardType:
                  isNumber ? TextInputType.number : TextInputType.text,
              inputFormatters:
                  isNumber ? [FilteringTextInputFormatter.digitsOnly] : [],
              controller: controller,
              decoration: InputDecoration(
                  prefixIcon: icon,
                  hintText: hintText,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          )
        ],
      ),
    );
  }
}
