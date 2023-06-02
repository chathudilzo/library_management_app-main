import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:library_pc/controllers/db_helper.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../admin_page.dart';
import 'profile.dart';
import 'view_book_page.dart';
import 'view_users.dart';

class IssuedBooks extends StatefulWidget {
  const IssuedBooks({super.key});

  @override
  State<IssuedBooks> createState() => _IssuedBooksState();
}

class _IssuedBooksState extends State<IssuedBooks> {
  late List<Map<String, dynamic>> _issuedBooks = [];
  List<Map<String, dynamic>> _filteredBooks = [];
  bool isButtonDissabled = false;
  bool _isLoading = true;
  bool _isEmpty = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadIssuedBooksData();
  }

  Future<void> _loadIssuedBooksData() async {
    final iBooks = await DBHelper.getIssuedbooks1();
    //print(iBooks);
    setState(() {
      _issuedBooks = iBooks.cast<Map<String, dynamic>>();
      _filteredBooks = _issuedBooks;
      _isLoading = false;
      if (_filteredBooks.isNotEmpty) {
        _isEmpty = false;
      }
    });
  }

  void _filterBooks(String query) {
    setState(() {
      _filteredBooks = _issuedBooks.where((book) {
        final bookId = book['Book_id'].toLowerCase();
        final indexNo = book['IndexNo'].toLowerCase();
        final dateOfIssue = book['DateofIssue'].toLowerCase();
        final maturityDate = book['MaturityDay'].toLowerCase();

        return bookId.contains(query.toLowerCase()) ||
            indexNo.contains(query.toLowerCase()) ||
            dateOfIssue.contains(query.toLowerCase()) ||
            maturityDate.contains(query.toLowerCase());
      }).toList();
      if (_filteredBooks.isNotEmpty) {
        _isEmpty = false;
      } else {
        _isEmpty = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        appBar: isButtonDissabled
            ? null
            : AppBar(
                title: Text('Issued Books'),
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
        body: _issuedBooks == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : isButtonDissabled
                ? Center(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(colors: [
                            Color.fromARGB(255, 0, 0, 0),
                            Color.fromARGB(255, 0, 0, 0)
                          ])),
                      width: width * 0.5,
                      height: height * 0.5,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            LoadingAnimationWidget.discreteCircle(
                                color: Colors.red, size: 100),
                            Text(
                              'Please wait until the email sending process is completed. This may take a moment.',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(
                    width: width,
                    height: height,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.only(bottom: 10, top: 20),
                              width: width * 0.3,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 53, 75, 93),
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextField(
                                onChanged: (query) {
                                  _filterBooks(query);
                                },
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.search),
                                    hintText: 'Search Issued Books',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                              ),
                            ),
                            GestureDetector(
                              onTap: isButtonDissabled
                                  ? null
                                  : () async {
                                      setState(() {
                                        isButtonDissabled = true;
                                      });
                                      // final receivePort = ReceivePort();
                                      // await Isolate.spawn(DBHelper.sendMailsIsolate,
                                      //     receivePort.sendPort);

                                      // await receivePort.first;
                                      await DBHelper.sendMails();
                                      setState(() {
                                        isButtonDissabled = false;
                                      });
                                    },
                              child: Container(
                                width: width * 0.1,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: isButtonDissabled
                                        ? Colors.grey
                                        : Colors.green,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(child: Text('Send Reminders')),
                              ),
                            )
                          ],
                        ),
                        Container(
                          width: width * 0.8,
                          height: height * 0.1,
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                'Book ID',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              )),
                              Expanded(
                                  child: Text(
                                'Index No',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              )),
                              Expanded(
                                  child: Text(
                                'Date Of Issue',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              )),
                              Expanded(
                                  child: Text(
                                'Maturity Date',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              )),
                              Expanded(
                                  child: Text(
                                'Charges',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ))
                            ],
                          ),
                        ),
                        Expanded(
                            child: _isLoading
                                ? LoadingAnimationWidget.dotsTriangle(
                                    color: Color.fromARGB(255, 7, 206, 100),
                                    size: 50,
                                  )
                                : _isEmpty
                                    ? Center(
                                        child: Column(
                                          children: [
                                            Container(
                                              width: 200,
                                              height: 200,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          'assets/searchgirl.gif'),
                                                      fit: BoxFit.cover)),
                                            ),
                                            Text('No data to show'),
                                          ],
                                        ),
                                      )
                                    : Container(
                                        width: width * 0.8,
                                        child: ListView.builder(
                                            itemCount: _filteredBooks.length,
                                            itemBuilder: (context, index) {
                                              final book =
                                                  _filteredBooks[index];
                                              print(book['charges']);
                                              return Container(
                                                margin: const EdgeInsets.only(
                                                    bottom: 10),
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    boxShadow: [
                                                      BoxShadow(blurRadius: 7)
                                                    ],
                                                    gradient: LinearGradient(
                                                        colors: [
                                                          Color.fromARGB(
                                                              255, 98, 5, 5),
                                                          Color.fromARGB(
                                                              255, 5, 71, 125)
                                                        ])),
                                                width: width * 0.8,
                                                height: height * 0.08,
                                                child: Row(children: [
                                                  Expanded(
                                                      child: Text(
                                                          book['Book_id']
                                                              .toString())),
                                                  Expanded(
                                                      child: Text(
                                                          book['IndexNo']
                                                              .toString())),
                                                  Expanded(
                                                      child: Text(
                                                          book['DateofIssue']
                                                              .toString())),
                                                  Expanded(
                                                      child: Text(
                                                          book['MaturityDay']
                                                              .toString())),
                                                  Expanded(
                                                      child: Text(
                                                          book['charges']
                                                              .toString()))
                                                ]),
                                              );
                                            }),
                                      ))
                      ],
                    ),
                  ));
  }
}
