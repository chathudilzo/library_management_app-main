import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:library_pc/admin_page.dart';
import 'package:library_pc/controllers/book_issue_controller.dart';
import 'package:library_pc/controllers/db_helper.dart';
import 'package:library_pc/pages/issued_books.dart';

import 'profile.dart';
import 'view_book_page.dart';
import 'view_users.dart';

class IssueBook extends StatefulWidget {
  const IssueBook({super.key});

  @override
  State<IssueBook> createState() => _IssueBookState();
}

class _IssueBookState extends State<IssueBook> {
  final _issueDayController = TextEditingController();
  final _maturityDayController = TextEditingController();

  final _indexNoController = TextEditingController();
  final _bookIdController = TextEditingController();
  final _charges = 0;

  late DateTime _selectedIssueDateTime;
  late DateTime _selectedMaturityDateTime;

  final _formKey = GlobalKey<FormState>();

  Future<void> _selectMaturityDate(BuildContext content) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedMaturityDateTime,
        firstDate: DateTime(2018, 8),
        lastDate: DateTime(2100, 8));
    if (picked != null) {
      _selectedMaturityDateTime = picked;
      _maturityDayController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  Future<void> _selectIssueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedIssueDateTime,
        firstDate: DateTime(2018),
        lastDate: DateTime(2100));
    if (picked != null) {
      _selectedIssueDateTime = picked;
      _issueDayController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedIssueDateTime = DateTime.now();
    _selectedMaturityDateTime = DateTime.now().add(Duration(days: 14));
    _maturityDayController.text =
        DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: 14)));
    _issueDayController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Issue Book'),
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
        decoration: BoxDecoration(
            // image: DecorationImage(
            //     image: AssetImage('assets/issueimg.jpg'), fit: BoxFit.cover)
            ),
        child: Center(
          child: Container(
            padding: EdgeInsets.only(
              left: width * 0.08,
              right: width * 0.08,
              top: 40,
            ),
            width: width * 0.8,
            height: height * 0.7,
            decoration: BoxDecoration(
                boxShadow: [BoxShadow(blurRadius: 7)],
                gradient: LinearGradient(colors: [
                  Color.fromARGB(66, 17, 6, 168),
                  Color.fromARGB(255, 3, 94, 22)
                ]),
                borderRadius: BorderRadius.circular(20)),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    //padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        boxShadow: [BoxShadow(blurRadius: 7)],
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromARGB(255, 88, 87, 87)),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Index No';
                        }
                      },
                      controller: _indexNoController,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: 'Index No',
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 96, 94, 94)),
                              borderRadius: BorderRadius.circular(20)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 164, 164, 164)),
                              borderRadius: BorderRadius.circular(20)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 255, 255, 255)),
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    //padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        boxShadow: [BoxShadow(blurRadius: 7)],
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromARGB(255, 88, 88, 88)),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Input BookID';
                        }
                      },
                      controller: _bookIdController,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.book),
                          hintText: 'BookID',
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 96, 94, 94)),
                              borderRadius: BorderRadius.circular(20)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 164, 164, 164)),
                              borderRadius: BorderRadius.circular(20)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 255, 255, 255)),
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            boxShadow: [BoxShadow(blurRadius: 7)],
                            gradient: LinearGradient(colors: [
                              Color.fromARGB(255, 7, 15, 20),
                              Color.fromARGB(255, 47, 2, 68)
                            ]),
                            borderRadius: BorderRadius.circular(10)),
                        width: 200,
                        child: Column(
                          children: [
                            Text(
                              'Issue Date',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextFormField(
                              controller: _issueDayController,
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.fromLTRB(50, 0, 0, 0),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent)),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent))),
                            ),
                            TextButton(
                                onPressed: () => _selectIssueDate(context),
                                child: Text(
                                  'select',
                                  style: TextStyle(color: Colors.white),
                                ))
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            boxShadow: [BoxShadow(blurRadius: 7)],
                            gradient: LinearGradient(colors: [
                              Color.fromARGB(255, 104, 10, 3),
                              Color.fromARGB(255, 123, 115, 6)
                            ]),
                            borderRadius: BorderRadius.circular(10)),
                        width: 200,
                        child: Column(
                          children: [
                            Text(
                              'Maturity Date',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextFormField(
                              controller: _maturityDayController,
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.fromLTRB(50, 0, 0, 0),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent)),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent))),
                            ),
                            TextButton(
                                onPressed: () => _selectMaturityDate(context),
                                child: Text(
                                  'select',
                                  style: TextStyle(color: Colors.white),
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.1,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          //print(
                          //   '${_bookIdController.text} ${_indexNoController.text} ${_maturityDayController.text} ${_issueDayController.text}');
                          final res = await DBHelper.issueBook(
                              _bookIdController.text,
                              _indexNoController.text,
                              _issueDayController.text,
                              _maturityDayController.text,
                              _charges.toString());
                          if (res) {
                            Get.offAll(() => IssuedBooks());
                          }
                        }
                      },
                      child: Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                            boxShadow: [BoxShadow(blurRadius: 7)],
                            color: Color.fromARGB(255, 209, 73, 9),
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                            child: Text(
                          'ISSUE',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
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
