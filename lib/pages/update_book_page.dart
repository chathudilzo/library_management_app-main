import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:library_pc/controllers/db_helper.dart';
import 'package:library_pc/pages/profile.dart';
import 'package:library_pc/pages/view_book_page.dart';
import 'package:library_pc/pages/view_users.dart';

import '../admin_page.dart';
import 'issued_books.dart';

class UpdateBook extends StatelessWidget {
  UpdateBook(
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

  final _formKey = GlobalKey<FormState>();

  TextEditingController _bookIdController = TextEditingController();
  TextEditingController _entryDateController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _genreController = TextEditingController();
  TextEditingController _authorController = TextEditingController();
  TextEditingController _bookTitleController = TextEditingController();
  TextEditingController _publisherAddController = TextEditingController();
  TextEditingController _pubDateAndPrintController = TextEditingController();
  TextEditingController _noPagesController = TextEditingController();
  TextEditingController _supModeController = TextEditingController();
  TextEditingController _removeDateontroller = TextEditingController();
  TextEditingController _exDetailsController = TextEditingController();
  TextEditingController _availabilityController = TextEditingController();

  late DateTime _selectedEntryDate = DateTime.now();

  Future<void> _selectEntryDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedEntryDate,
        firstDate: DateTime(1990),
        lastDate: DateTime(2100));

    if (picked != null) {
      _selectedEntryDate = picked;
      _entryDateController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    _bookIdController.text = bookId;
    _entryDateController.text = entryDate;
    _priceController.text = price;
    _genreController.text = genre;
    _authorController.text = author;
    _bookTitleController.text = bookTitle;
    _publisherAddController.text = publisherAdd;
    _pubDateAndPrintController.text = pubDateAndPrint;
    _noPagesController.text = noPages;
    _supModeController.text = supMode;
    _removeDateontroller.text = removeDate;
    _exDetailsController.text = exDetails;
    _availabilityController.text = availability;

    return Scaffold(
      appBar: AppBar(
        title: Text('Update Book'),
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
              gradient: LinearGradient(
                  colors: [Colors.black, Color.fromARGB(255, 5, 40, 69)]),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [BoxShadow(blurRadius: 7)]),
          width: width * 0.8,
          height: height * 0.9,
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'BookID',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          Container(
                            width: width * 0.3,
                            height: height * 0.07,
                            decoration: BoxDecoration(
                                boxShadow: [BoxShadow(blurRadius: 10)],
                                color: Color.fromARGB(255, 188, 86, 7),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              enabled: false,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.book),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      )),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors
                                          .transparent, // Set the focused border color
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(10))),
                              controller: _bookIdController,
                            ),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'EntryDate',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          Container(
                            width: width * 0.3,
                            height: height * 0.07,
                            decoration: BoxDecoration(
                                boxShadow: [BoxShadow(blurRadius: 10)],
                                color: Color.fromARGB(255, 26, 28, 28),
                                borderRadius: BorderRadius.circular(10)),
                            child: GestureDetector(
                              onTap: () {
                                _selectEntryDate(context);
                              },
                              child: TextFormField(
                                enabled: false,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.input),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                        )),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors
                                            .transparent, // Set the focused border color
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                controller: _entryDateController,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Price',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          Container(
                            width: width * 0.3,
                            height: height * 0.07,
                            decoration: BoxDecoration(
                                boxShadow: [BoxShadow(blurRadius: 10)],
                                color: Color.fromARGB(255, 26, 28, 28),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Input Book Price';
                                }
                              },
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]'))
                              ],
                              decoration: InputDecoration(
                                  prefixText: 'Rs:',
                                  prefixIcon: Icon(Icons.attach_money_outlined),
                                  hintText: '500',
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      )),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors
                                          .transparent, // Set the focused border color
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(10))),
                              controller: _priceController,
                            ),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Genre',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          Container(
                            width: width * 0.3,
                            height: height * 0.07,
                            decoration: BoxDecoration(
                                boxShadow: [BoxShadow(blurRadius: 10)],
                                color: Color.fromARGB(255, 26, 28, 28),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Input Genre';
                                }
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.category),
                                  hintText: 'G01',
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      )),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors
                                          .transparent, // Set the focused border color
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(10))),
                              controller: _genreController,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Author',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          Container(
                            width: width * 0.3,
                            height: height * 0.07,
                            decoration: BoxDecoration(
                                boxShadow: [BoxShadow(blurRadius: 10)],
                                color: Color.fromARGB(255, 26, 28, 28),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Input Author';
                                }
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.person_pin_sharp),
                                  hintText: 'Arther xxx',
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      )),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors
                                          .transparent, // Set the focused border color
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(10))),
                              controller: _authorController,
                            ),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Book Title',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          Container(
                            width: width * 0.3,
                            height: height * 0.07,
                            decoration: BoxDecoration(
                                boxShadow: [BoxShadow(blurRadius: 10)],
                                color: Color.fromARGB(255, 26, 28, 28),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Input Book Title';
                                }
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.title),
                                  hintText: 'Clash of xxxx',
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      )),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors
                                          .transparent, // Set the focused border color
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(10))),
                              controller: _bookTitleController,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Publisher & Address',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          Container(
                            width: width * 0.3,
                            height: height * 0.07,
                            decoration: BoxDecoration(
                                boxShadow: [BoxShadow(blurRadius: 10)],
                                color: Color.fromARGB(255, 26, 28, 28),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Input Publisher & Address';
                                }
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.post_add),
                                  hintText: 'Mordern book ltd,London',
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      )),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors
                                          .transparent, // Set the focused border color
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(10))),
                              controller: _publisherAddController,
                            ),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Published Date & Print',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          Container(
                            width: width * 0.3,
                            height: height * 0.07,
                            decoration: BoxDecoration(
                                boxShadow: [BoxShadow(blurRadius: 10)],
                                color: Color.fromARGB(255, 26, 28, 28),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Input Publisher Date & Print';
                                }
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.date_range),
                                  hintText: '2021-06-29 (2)',
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      )),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors
                                          .transparent, // Set the focused border color
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(10))),
                              controller: _pubDateAndPrintController,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Number of Pages',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          Container(
                            width: width * 0.3,
                            height: height * 0.07,
                            decoration: BoxDecoration(
                                boxShadow: [BoxShadow(blurRadius: 10)],
                                color: Color.fromARGB(255, 26, 28, 28),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Input NUmber Of Pages';
                                }
                              },
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]'))
                              ],
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.numbers),
                                  hintText: '100',
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      )),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors
                                          .transparent, // Set the focused border color
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(10))),
                              controller: _noPagesController,
                            ),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Supply Mode',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          Container(
                            width: width * 0.3,
                            height: height * 0.07,
                            decoration: BoxDecoration(
                                boxShadow: [BoxShadow(blurRadius: 10)],
                                color: Color.fromARGB(255, 26, 28, 28),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Input Supply Mode';
                                }
                              },
                              decoration: InputDecoration(
                                  prefixIcon:
                                      Icon(Icons.call_received_outlined),
                                  hintText: 'Donation',
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      )),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors
                                          .transparent, // Set the focused border color
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(10))),
                              controller: _supModeController,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Remove Date',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          Container(
                            width: width * 0.3,
                            height: height * 0.07,
                            decoration: BoxDecoration(
                                boxShadow: [BoxShadow(blurRadius: 10)],
                                color: Color.fromARGB(255, 26, 28, 28),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Input Remove Date if have';
                                }
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.delete_forever),
                                  hintText: '2021-06-29',
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      )),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors
                                          .transparent, // Set the focused border color
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(10))),
                              controller: _removeDateontroller,
                            ),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Extra Details',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          Container(
                            width: width * 0.3,
                            height: height * 0.07,
                            decoration: BoxDecoration(
                                boxShadow: [BoxShadow(blurRadius: 10)],
                                color: Color.fromARGB(255, 26, 28, 28),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Input Extra Details if have';
                                }
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.details),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      )),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors
                                          .transparent, // Set the focused border color
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(10))),
                              controller: _exDetailsController,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Availability',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          Container(
                            width: width * 0.3,
                            height: height * 0.07,
                            decoration: BoxDecoration(
                                boxShadow: [BoxShadow(blurRadius: 10)],
                                color: Color.fromARGB(255, 26, 28, 28),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              enabled: false,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      )),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors
                                          .transparent, // Set the focused border color
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(10))),
                              controller: _availabilityController,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            // print(
                            //   '${_bookIdController.text} ${_entryDateController.text} ${_priceController.text} ${_genreController.text} ${_authorController.text} ${_bookTitleController.text}  ${_publisherAddController.text} ${_pubDateAndPrintController.text}${_noPagesController.text} ${_supModeController.text} ${_removeDateontroller.text}${_exDetailsController.text} ${_availabilityController.text}');

                            final result = await DBHelper.updateBook(
                                _bookIdController.text,
                                _entryDateController.text,
                                _genreController.text,
                                _authorController.text,
                                _bookTitleController.text,
                                _publisherAddController.text,
                                _pubDateAndPrintController.text,
                                _noPagesController.text,
                                _priceController.text,
                                _supModeController.text,
                                _removeDateontroller.text,
                                _exDetailsController.text,
                                _availabilityController.text);

                            if (result == true) {
                              Get.offAll(() => ViewBooks());
                            }
                          }
                        },
                        child: Container(
                          width: width * 0.125,
                          height: height * 0.06,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 40, 41, 49),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text('Update'),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }
}
