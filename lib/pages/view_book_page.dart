import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:library_pc/controllers/db_helper.dart';
import 'package:library_pc/pages/book_availability_table.dart';
import 'package:library_pc/pages/book_details_page.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../admin_page.dart';
import 'issued_books.dart';
import 'profile.dart';
import 'view_users.dart';

class ViewBooks extends StatefulWidget {
  const ViewBooks({Key? key}) : super(key: key);

  @override
  _ViewBooksState createState() => _ViewBooksState();
}

class _ViewBooksState extends State<ViewBooks> {
  late List<Map<String, dynamic>> _books = [];
  List<Map<String, dynamic>> _filteredBooks = [];
  List<String> _headers = [
    'Book ID',
    'Entry Date',
    'Genre No',
    'Author',
    'Book Title',
    'Publisher & Address',
    'Published Date And print',
    'No of Pages',
    'Price',
    'Mode_of_supply',
    'Date_of_remove',
    'Extra_details',
    'Availability'
  ];
  int _hoverdIndex = -1;
  bool _isLoading = true;
  bool _isEmpty = false;

  @override
  void initState() {
    super.initState();
    _loadBookData();
  }

  Future<void> _loadBookData() async {
    final books = await DBHelper.getBooks();
    //print(books);

    setState(() {
      _books = books;
      _filteredBooks = books;
      _isLoading = false;
      if (books.isEmpty) {
        _isEmpty = true;
      }
    });
  }

  void _filterBooks(String query) {
    //Book_id,Date_of_Entry,Genre_No,Author,Book_Title,Publisher_and_Address,
    //Date_of_published_and_print,Number_of_Pages,Price,Mode_of_supply,
    //Date_of_remove,Extra_details,Availability
    setState(() {
      _filteredBooks = _books.where((book) {
        final Book_Title = book['Book_Title'].toLowerCase();
        final Author = book['Author'].toLowerCase();
        final Genre_No = book['Genre_No'].toLowerCase();
        final Mode_of_supply = book['Mode_of_supply'].toLowerCase();
        final Availability = book['Availability'].toLowerCase();
        final Book_id = book['Book_id'].toLowerCase();
        final Publisher_and_Address =
            book['Publisher_and_Address'].toLowerCase();
        final Extra_details = book['Extra_details'].toLowerCase();
        return Book_Title.contains(query.toLowerCase()) ||
            Author.contains(query.toLowerCase()) ||
            Genre_No.contains(query.toLowerCase()) ||
            Mode_of_supply.contains(query.toLowerCase()) ||
            Availability.contains(query.toLowerCase()) ||
            Book_id.contains(query.toLowerCase()) ||
            Publisher_and_Address.contains(query.toLowerCase()) ||
            Extra_details.contains(query.toLowerCase());
      }).toList();

      if (_filteredBooks.isEmpty) {
        _isEmpty = true;
      } else {
        _isEmpty = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 3, 3, 3),
        appBar: AppBar(
          title: Text('All Books'),
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
        body: Column(children: [
          Container(
            width: width,
            height: height * 0.2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  // borderRadius: BorderRadius.circular(30)

                  // padding:
                  //     const EdgeInsets.only(top: 1, bottom: 1, left: 1, right: 1),
                  width: width * 0.3,
                  height: height * 0.2,
                  child: Center(
                    child: Container(
                      width: width * 0.2,
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: 'Search',
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30))),
                        onChanged: (query) => _filterBooks(query),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () => Get.to(() => AvailabilityTable()),
                    child: Text('AvailabilityTable')),
              ],
            ),
          ),
          //to here
          _books == null
              ? Center(child: CircularProgressIndicator())
              : Container(
                  width: width,
                  height: height * 0.7,
                  child: Column(
                    children: [
                      Container(
                        width: width * 0.98,
                        height: height * 0.09,
                        child: ListView.builder(
                            itemCount: 1,
                            itemBuilder: (content, index) {
                              return Container(
                                  height: height * 0.09,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: LinearGradient(colors: [
                                        Color.fromARGB(255, 97, 98, 101),
                                        Color.fromARGB(255, 25, 27, 29)
                                      ])),
                                  padding:
                                      const EdgeInsets.only(left: 10, right: 5),
                                  child: Row(
                                      children: _headers.map((header) {
                                    return Expanded(
                                        child: Container(
                                      decoration: BoxDecoration(
                                          //     border: Border.all(
                                          //   width: 1,
                                          // )

                                          ),
                                      //padding:  const EdgeInsets.only(left: , right: 10),
                                      child: Text(
                                        header,
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ));
                                  }).toList()));
                            }),
                      ),
                      _isLoading
                          ? Center(
                              child: LoadingAnimationWidget.dotsTriangle(
                                color: Color.fromARGB(255, 7, 206, 100),
                                size: 50,
                              ),
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
                                                    'assets/notfoundpenguine.gif'),
                                                fit: BoxFit.cover)),
                                      ),
                                      Text('No data to show'),
                                    ],
                                  ),
                                )
                              : Container(
                                  height: height * 0.6,
                                  width: width * 0.98,
                                  child: ListView.builder(
                                      itemCount: _filteredBooks.length,
                                      itemBuilder: (context, index) {
                                        final book = _filteredBooks[index];
                                        return Container(
                                          height: height * 0.08,
                                          margin:
                                              const EdgeInsets.only(bottom: 5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              gradient: LinearGradient(colors: [
                                                Color.fromARGB(
                                                    255, 27, 63, 117),
                                                Color.fromARGB(255, 20, 22, 25)
                                              ])),
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: GestureDetector(
                                            onTap: () {
                                              Get.to(() => BookDetails(
                                                  bookId: book['Book_id'],
                                                  entryDate:
                                                      book['Date_of_Entry'],
                                                  genre: book['Genre_No'],
                                                  author: book['Author'],
                                                  bookTitle: book['Book_Title'],
                                                  publisherAdd: book[
                                                      'Publisher_and_Address'],
                                                  pubDateAndPrint: book[
                                                      'Date_of_published_and_print'],
                                                  noPages:
                                                      book['Number_of_Pages'],
                                                  price: book['Price'],
                                                  supMode:
                                                      book['Mode_of_supply'],
                                                  removeDate:
                                                      book['Date_of_remove'],
                                                  exDetails:
                                                      book['Extra_details'],
                                                  availability:
                                                      book['Availability']));
                                            },
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    child: Text(
                                                  book['Book_id'],
                                                  style: TextStyle(),
                                                )),
                                                Expanded(
                                                    child: Text(
                                                  book['Date_of_Entry'],
                                                  style: TextStyle(),
                                                )),
                                                Expanded(
                                                    child: Text(
                                                  book['Genre_No'],
                                                  style: TextStyle(),
                                                )),
                                                Expanded(
                                                    child: Text(
                                                  book['Author'],
                                                  style: TextStyle(),
                                                )),
                                                Expanded(
                                                    child: Text(
                                                  book['Book_Title'],
                                                  style: TextStyle(),
                                                )),
                                                Expanded(
                                                    child: Text(
                                                  book['Publisher_and_Address'],
                                                  style: TextStyle(),
                                                )),
                                                Expanded(
                                                    child: Text(
                                                  book[
                                                      'Date_of_published_and_print'],
                                                  style: TextStyle(),
                                                )),
                                                Expanded(
                                                    child: Text(
                                                  book['Number_of_Pages'],
                                                  style: TextStyle(),
                                                )),
                                                Expanded(
                                                    child: Text(
                                                  book['Price'],
                                                  style: TextStyle(),
                                                )),
                                                Expanded(
                                                    child: Text(
                                                  book['Mode_of_supply'],
                                                  style: TextStyle(),
                                                )),
                                                Expanded(
                                                    child: Text(
                                                  book['Date_of_remove'],
                                                  style: TextStyle(),
                                                )),
                                                Expanded(
                                                    child: Text(
                                                  book['Extra_details'],
                                                  style: TextStyle(),
                                                )),
                                                Expanded(
                                                    child: Text(
                                                  book['Availability'],
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          book['Availability'] ==
                                                                  'Available'
                                                              ? Colors.green
                                                              : Colors.red),
                                                ))
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                )
                    ],
                  ),
                )
        ]));
  }
}
