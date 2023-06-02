import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:library_pc/controllers/db_helper.dart';
import 'package:library_pc/pages/responsize_text.dart';
import 'package:library_pc/pages/update_book_page.dart';

import '../admin_page.dart';
import 'issued_books.dart';
import 'profile.dart';
import 'view_book_page.dart';
import 'view_users.dart';

class BookDetails extends StatefulWidget {
  const BookDetails(
      {super.key,
      required this.bookId,
      required this.entryDate,
      required this.genre,
      required this.author,
      required this.bookTitle,
      required this.publisherAdd,
      required this.pubDateAndPrint,
      required this.noPages,
      required this.price,
      required this.supMode,
      required this.removeDate,
      required this.exDetails,
      required this.availability});

  final bookId;
  final entryDate;
  final genre;
  final author;
  final bookTitle;
  final publisherAdd;
  final pubDateAndPrint;
  final noPages;
  final price;
  final supMode;
  final removeDate;
  final exDetails;
  final availability;

  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Book Details'),
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
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [BoxShadow(blurRadius: 7)],
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 75, 3, 3),
                Color.fromARGB(255, 75, 5, 174)
              ])),
          width: width * 0.9,
          height: height * 0.9,
          child: Row(
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      width: width * 0.3,
                      height: height * 0.7,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(blurRadius: 7, spreadRadius: 5)
                          ],
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromARGB(255, 38, 37, 36),
                          image: DecorationImage(
                              image: AssetImage('assets/book.jpg'),
                              fit: BoxFit.cover)),
                      child: Center(
                          child: ResponsiveText(
                        fontSize: 10,
                        text: widget.bookTitle,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      )),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: width * 0.1,
              ),
              Container(
                width: width * 0.40,
                height: height * 0.8,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ResponsiveText(
                        fontSize: 12,
                        text: widget.bookId,
                        color: Color.fromARGB(255, 244, 244, 244),
                        fontWeight: FontWeight.bold,
                      ),
                      Wrap(children: [
                        ResponsiveText(
                          fontSize: 8,
                          text: widget.bookTitle,
                          color: Color.fromARGB(255, 169, 168, 168),
                          fontWeight: FontWeight.bold,
                        ),
                      ]),
                      ResponsiveText(
                        fontSize: 6,
                        text: 'Author: ${widget.author}',
                        color: Color.fromARGB(255, 118, 118, 118),
                        fontWeight: FontWeight.bold,
                      ),
                      Row(
                        children: [
                          ResponsiveText(
                            fontSize: 5,
                            text: 'Genre: ',
                            color: Color.fromARGB(255, 10, 10, 10),
                            fontWeight: FontWeight.bold,
                          ),
                          ResponsiveText(
                            fontSize: 4,
                            text: '${widget.genre}',
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          ResponsiveText(
                            fontSize: 5,
                            text: 'Pages: ',
                            color: Color.fromARGB(255, 10, 10, 10),
                            fontWeight: FontWeight.bold,
                          ),
                          ResponsiveText(
                            fontSize: 5,
                            text: '${widget.noPages}',
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          ResponsiveText(
                            fontSize: 5,
                            text: 'Price: ',
                            color: Color.fromARGB(255, 10, 10, 10),
                            fontWeight: FontWeight.bold,
                          ),
                          ResponsiveText(
                            fontSize: 4,
                            text: '${widget.price}',
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          ResponsiveText(
                            fontSize: 5,
                            text: 'Publisher & Address: ',
                            color: Color.fromARGB(255, 10, 10, 10),
                            fontWeight: FontWeight.bold,
                          ),
                          ResponsiveText(
                            fontSize: 4,
                            text: '${widget.publisherAdd}',
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          ResponsiveText(
                            fontSize: 5,
                            text: 'Publisher & Address: ',
                            color: Color.fromARGB(255, 10, 10, 10),
                            fontWeight: FontWeight.bold,
                          ),
                          ResponsiveText(
                            fontSize: 4,
                            text: '${widget.pubDateAndPrint}',
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          ResponsiveText(
                            fontSize: 5,
                            text: 'Entry Date: ',
                            color: Color.fromARGB(255, 10, 10, 10),
                            fontWeight: FontWeight.bold,
                          ),
                          ResponsiveText(
                            fontSize: 4,
                            text: '${widget.entryDate}',
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          ResponsiveText(
                            fontSize: 5,
                            text: 'Remove Date: ',
                            color: Color.fromARGB(255, 10, 10, 10),
                            fontWeight: FontWeight.bold,
                          ),
                          ResponsiveText(
                            fontSize: 4,
                            text: '${widget.removeDate}',
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                      Wrap(
                        children: [
                          ResponsiveText(
                            fontSize: 5,
                            text: 'Supply Mode: ',
                            color: Color.fromARGB(255, 10, 10, 10),
                            fontWeight: FontWeight.bold,
                          ),
                          ResponsiveText(
                            fontSize: 4,
                            text: '${widget.supMode}',
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                      Wrap(
                        children: [
                          ResponsiveText(
                            fontSize: 5,
                            text: 'Details: ',
                            color: Color.fromARGB(255, 10, 10, 10),
                            fontWeight: FontWeight.bold,
                          ),
                          ResponsiveText(
                            fontSize: 4,
                            text: 'Details:${widget.exDetails}',
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: width * 0.09,
                            height: height * 0.04,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [BoxShadow(blurRadius: 7)],
                                gradient: widget.availability == 'Available'
                                    ? LinearGradient(
                                        colors: [Colors.green, Colors.blue])
                                    : LinearGradient(colors: [
                                        Color.fromARGB(255, 145, 16, 7),
                                        Color.fromARGB(255, 255, 247, 0)
                                      ])),
                            child: Center(
                              child: ResponsiveText(
                                fontSize: 4,
                                text: widget.availability,
                                color: Color.fromARGB(255, 15, 15, 15),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Get.to(() => UpdateBook(
                                bookId: widget.bookId,
                                entryDate: widget.entryDate,
                                genre: widget.genre,
                                author: widget.author,
                                bookTitle: widget.bookTitle,
                                publisherAdd: widget.publisherAdd,
                                pubDateAndPrint: widget.pubDateAndPrint,
                                noPages: widget.noPages,
                                price: widget.price,
                                supMode: widget.supMode,
                                removeDate: widget.removeDate,
                                exDetails: widget.exDetails,
                                availability: widget.availability)),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 9, 179, 60),
                                  borderRadius: BorderRadius.circular(10)),
                              width: width * 0.07,
                              height: height * 0.05,
                              child: Center(
                                child: Text('Update'),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Confirm delete book'),
                                      content: Text(
                                          'Do you want to delete book ${widget.bookId} from books'),
                                      actions: [
                                        ElevatedButton(
                                            onPressed: () async {
                                              final res = await DBHelper
                                                  .deleteBookByBookid(
                                                      widget.bookId);
                                              if (res) {
                                                Get.to(ViewBooks());
                                              }
                                              //Navigator.of(context).pop();
                                            },
                                            child: Text('Yes')),
                                        ElevatedButton(
                                            onPressed: () async {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('No')),
                                      ],
                                    );
                                  });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10)),
                              width: width * 0.07,
                              height: height * 0.05,
                              child: Center(
                                child: Text('Delete'),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
