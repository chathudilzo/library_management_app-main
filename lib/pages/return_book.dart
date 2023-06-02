import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:library_pc/controllers/db_helper.dart';
import 'package:library_pc/pages/issued_books.dart';

import '../admin_page.dart';
import 'profile.dart';
import 'view_book_page.dart';
import 'view_users.dart';

class ReturnBook extends StatefulWidget {
  const ReturnBook({super.key});

  @override
  State<ReturnBook> createState() => _ReturnBookState();
}

class _ReturnBookState extends State<ReturnBook> {
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  final _indexNoController = TextEditingController();
  final _bookIdController = TextEditingController();
  final _chargesController = TextEditingController();

  final _bookSearchIdController = TextEditingController();
  late List<Map<String, dynamic>> _results = [];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 42, 41, 41),
      appBar: AppBar(
        title: Text('Return Book'),
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
      body: Column(
        children: [
          Container(
            width: width,
            height: height * 0.23,
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            decoration: BoxDecoration(
                boxShadow: [BoxShadow(blurRadius: 6, spreadRadius: 5)],
                gradient: LinearGradient(colors: [Colors.black, Colors.blue])),
            child: Center(
              child: Container(
                width: width / 2,
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Search Issued Books',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                                hintText: 'B004',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            controller: _bookSearchIdController,
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          GestureDetector(
                            onTap: () async {
                              final results = await DBHelper()
                                  .getIssuedBookDetails(
                                      _bookSearchIdController.text);
                              print(results);

                              setState(() {
                                _results = results;
                              });
                              // to rebuild the UI with the updated results
                            },
                            child: Container(
                              child: Center(
                                  child: Text(
                                'Search',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              )),
                              width: width * 0.07,
                              height: height * 0.05,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 7, 15, 51),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.08,
          ),
          Container(
            width: width,
            height: height * 0.6,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 42, 41, 41),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: width / 2,
                  height: height * 0.7,
                  child: _results != null && _results.isNotEmpty
                      ? DataTable(
                          columns: <DataColumn>[
                              DataColumn(label: Text('Book_id')),
                              DataColumn(label: Text('Index No')),
                              DataColumn(label: Text('Date Of Issue')),
                              DataColumn(label: Text('Maturity Date')),
                              DataColumn(label: Text('Charges'))
                            ],
                          rows: _results.map((data) {
                            return DataRow(cells: <DataCell>[
                              DataCell(Text(data['Book_id'].toString())),
                              DataCell(Text(data['IndexNo'].toString())),
                              DataCell(Text(data['DateofIssue'].toString())),
                              DataCell(Text(data['MaturityDay'].toString())),
                              DataCell(Text(data['charges'].toString()))
                            ]);
                          }).toList())
                      : Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/booo1.png'),
                                  fit: BoxFit.cover)),
                        ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  width: width * 0.3,
                  height: height * 0.55,
                  decoration: BoxDecoration(
                      boxShadow: [BoxShadow(blurRadius: 5)],
                      gradient: LinearGradient(colors: [
                        Color.fromARGB(255, 117, 5, 5),
                        Color.fromARGB(255, 0, 0, 1)
                      ]),
                      borderRadius: BorderRadius.circular(10)),
                  child: Form(
                    key: _formKey2,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                'Book Return Form',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Input IndexNo';
                              }
                            },
                            controller: _indexNoController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                hintText: 'IndexNo',
                                prefixIcon: Icon(Icons.person)),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Input BookID';
                              }
                            },
                            controller: _bookIdController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                hintText: 'BookID',
                                prefixIcon: Icon(Icons.book)),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller: _chargesController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                hintText: 'Charges RS:',
                                prefixIcon: Icon(Icons.attach_money)),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (_formKey2.currentState!.validate()) {
                              final res = await DBHelper.returnBook(
                                  _indexNoController.text.toUpperCase(),
                                  _bookIdController.text.toUpperCase(),
                                  _chargesController.text);
                              // print(res);
                              if (res == true) {
                                Get.to(IssuedBooks());
                              }
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [BoxShadow(blurRadius: 5)],
                                gradient: LinearGradient(colors: [
                                  Color.fromARGB(255, 5, 41, 117),
                                  Color.fromARGB(255, 72, 6, 130)
                                ])),
                            width: width * 0.095,
                            height: height * 0.06,
                            child: Center(
                                child: Text(
                              'Accept',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            )),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
