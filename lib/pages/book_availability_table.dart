import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:library_pc/controllers/bar_chart_controller.dart';
import 'package:library_pc/controllers/db_helper.dart';

import '../admin_page.dart';
import 'issued_books.dart';
import 'profile.dart';
import 'view_book_page.dart';
import 'view_users.dart';

class AvailabilityTable extends StatefulWidget {
  const AvailabilityTable({super.key});

  @override
  State<AvailabilityTable> createState() => _AvailabilityTableState();
}

class _AvailabilityTableState extends State<AvailabilityTable> {
  late List<Map<String, dynamic>> _books = [];
  late List<int> _stat = [];
  final BarChartController _controller = Get.put(BarChartController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadBooks();
    _loadInfo();
  }

  Future<void> _loadBooks() async {
    final books = await DBHelper.getallBooksAvailability();
    setState(() {
      _books = books;
      //print(_books);
    });
  }

  Future<void> _loadInfo() async {
    final stat = await DBHelper.getBookAvailabilityInfo();
    setState(() {
      _stat = stat;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text('Book Availability'),
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
        body: _books == null
            ? CircularProgressIndicator()
            : Column(
                children: [
                  Container(
                    width: width,
                    height: height * 0.05,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Total Books: ${_controller.booksAvailibilityData[1]} |',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Available Books: ${_controller.booksAvailibilityData[0]} |',
                          style: TextStyle(
                              color: Color.fromARGB(255, 9, 193, 113),
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'CheckedOut Books: ${_controller.booksAvailibilityData[2]} |',
                          style: TextStyle(
                              color: Color.fromARGB(255, 243, 68, 33),
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: width,
                    height: height * 0.8,
                    padding: const EdgeInsets.all(20),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 3 / 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                      ),
                      itemCount: _books.length,
                      itemBuilder: (BuildContext ctx, index) {
                        final book = _books[index];
                        return buildBookItem(book);
                      },
                    ),
                  ),
                ],
              ));
  }

  Widget buildBookItem(Map<String, dynamic> book) {
    final bookId = book['Book_id'];
    final title = book['Book_Title'];
    final availability = book['Availability'];
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(blurRadius: 7)],
        gradient: availability == 'Available'
            ? LinearGradient(colors: [
                Color.fromARGB(255, 5, 126, 25),
                Color.fromARGB(255, 3, 64, 124)
              ])
            : LinearGradient(colors: [Colors.red, Colors.orange]),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                bookId,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )
              //Text('Availability: $availability'),
            ],
          ),
        ),
      ),
    );
  }
}
