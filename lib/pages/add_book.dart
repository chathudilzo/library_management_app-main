import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:library_pc/admin_page.dart';
import 'package:library_pc/controllers/db_helper.dart';
import 'package:library_pc/pages/availabilityDropdown.dart';
import 'package:library_pc/pages/issued_books.dart';
import 'package:library_pc/pages/profile.dart';
import 'package:library_pc/pages/view_book_page.dart';
import 'package:library_pc/pages/view_users.dart';

class AddBook extends StatefulWidget {
  const AddBook({super.key});

  @override
  State<AddBook> createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
//Book_id,Date_of_Entry,Genre_No,Author,Book_Title,Publisher_and_Address,Date_of_published_and_print,
  //Number_of_Pages,Price,Mode_of_supply,Date_of_remove,Extra_details,Availability

  TextEditingController _bookIdController = TextEditingController();
  TextEditingController _entryDateController = TextEditingController();
  TextEditingController _genNoController = TextEditingController();
  TextEditingController _authorController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _publisherController = TextEditingController();
  TextEditingController _publishDateController = TextEditingController();
  TextEditingController _noPagesController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _supplyModeController = TextEditingController();
  TextEditingController _removeDateController = TextEditingController();
  TextEditingController _extraDetailsController = TextEditingController();
  TextEditingController _availabilityController = TextEditingController();
  late DateTime _selectedDateTime;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDateTime,
        firstDate: DateTime(1980, 1),
        lastDate: DateTime(2100, 8));
    if (picked != null) {
      _selectedDateTime = picked;
      _entryDateController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  void reset() {
    _bookIdController.clear();
    _entryDateController.clear();
    _genNoController.clear();
    _authorController.clear();
    _titleController.clear();
    _publisherController.clear();
    _publishDateController.clear();
    _noPagesController.clear();
    _priceController.clear();
    _supplyModeController.clear();
    _removeDateController.clear();
    _extraDetailsController.clear();
    getBookId();
    _selectedDateTime = DateTime.now();
  }

  final _formKey = GlobalKey<FormState>();
  late List<String?> _lastBookId = [null, null];
  late String? _lastEntered = '';
  late String? _lastId = '';
  late String _selectedStatus = 'Available';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBookId();
    _selectedDateTime = DateTime.now();
  }

  void getBookId() async {
    var lastBookId = await DBHelper.getLastBookid();
    //print(lastBookId);
    setState(() {
      _lastEntered = lastBookId[1];
      _lastId = lastBookId[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Book'),
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
        width: width,
        height: height,
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 26, 85, 173).withOpacity(0.3),
                Color.fromARGB(255, 6, 26, 60).withOpacity(0.7),
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadiusDirectional.circular(10)),
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    Text('Register New Book'),
                    SizedBox(
                      height: height * 0.01,
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: width * 0.25,
                                child: Text(
                                  'LAST ENTERED BOOKID : $_lastEntered \nHIGHEST BOOKID $_lastId',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              FormFieldWid(
                                isNumber: false,
                                controller: _bookIdController,
                                errText: 'Please Input BookId',
                                hintText: 'BookID',
                                labelText: 'Book ID',
                              ),
                              GestureDetector(
                                onTap: () => _selectDate(context),
                                child: Container(
                                  width: width / 5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Entry Date',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Color.fromARGB(
                                                  255, 20, 113, 213))),
                                      TextFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            print('Entry date cannot be empty');
                                          }
                                        },
                                        enabled: false,
                                        decoration: InputDecoration(
                                            prefixIcon:
                                                Icon(Icons.calendar_month)),
                                        controller: _entryDateController,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              FormFieldWid(
                                isNumber: false,
                                controller: _genNoController,
                                errText: 'Please Input Genre No',
                                hintText: 'Genre No',
                                labelText: 'Genre No',
                              ),

                              //Book_id,Title,Author,ISBN,Genre,Published_Year
                            ],
                          ),
                          Row(
                            //Book_id,Date_of_Entry,Genre_No,Author,Book_Title,Publisher_and_Address,Date_of_published_and_print,
                            //Number_of_Pages,Price,Mode_of_supply,Date_of_remove,Extra_details,Availability
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              FormFieldWid(
                                  isNumber: false,
                                  controller: _authorController,
                                  errText: 'Please Input Author Name',
                                  hintText: 'Author',
                                  labelText: 'Author'),
                              FormFieldWid(
                                  isNumber: false,
                                  controller: _titleController,
                                  errText: 'Please Input Book Title',
                                  hintText: 'Title',
                                  labelText: 'Title'),
                              FormFieldWid(
                                  isNumber: false,
                                  controller: _publisherController,
                                  errText:
                                      'Please Input Publishe Name and Address',
                                  hintText: 'Publisher-Address',
                                  labelText: 'Publisher and Address')
                              //Book_id,Title,Author,ISBN,Genre,Published_Year
                            ],
                          ),
                          Row(
                            //Book_id,Date_of_Entry,Genre_No,Author,Book_Title,Publisher_and_Address,Date_of_published_and_print,
                            //Number_of_Pages,Price,Mode_of_supply,Date_of_remove,Extra_details,Availability
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              FormFieldWid(
                                isNumber: false,
                                controller: _publishDateController,
                                errText:
                                    'Please Input Date of published and print',
                                hintText: 'yyyy-MM-dd-print',
                                labelText: 'Date of published and print',
                              ),
                              FormFieldWid(
                                  isNumber: true,
                                  controller: _noPagesController,
                                  errText: 'Please Input No of Pages',
                                  hintText: 'No of Pages',
                                  labelText: 'No of Pages'),
                              FormFieldWid(
                                  isNumber: true,
                                  controller: _priceController,
                                  errText: 'Please Input Book Price',
                                  hintText: 'Price',
                                  labelText: 'Price')
                              //Book_id,Title,Author,ISBN,Genre,Published_Year
                            ],
                          ),
                          Row(
                            //Book_id,Date_of_Entry,Genre_No,Author,Book_Title,Publisher_and_Address,Date_of_published_and_print,
                            //Number_of_Pages,Price,Mode_of_supply,Date_of_remove,Extra_details,Availability
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              FormFieldWid(
                                isNumber: false,
                                controller: _supplyModeController,
                                errText: 'Please Input Mode of supply',
                                hintText: 'Mode of supply',
                                labelText: 'Mode of supply',
                              ),
                              FormFieldWid(
                                  isNumber: false,
                                  controller: _removeDateController,
                                  errText: 'Please Input Date of remove',
                                  hintText: 'yyyy-MM-dd',
                                  labelText: 'Date of remove'),
                              FormFieldWid(
                                  isNumber: false,
                                  controller: _extraDetailsController,
                                  errText: 'Please Input Extra_details',
                                  hintText: 'Extra_details',
                                  labelText: 'Extra_details')
                              //Book_id,Title,Author,ISBN,Genre,Published_Year
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                  width: width * 0.20,
                                  margin: const EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Availability',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Color.fromARGB(
                                                255, 20, 113, 213)),
                                      ),
                                      DropdownButtonFormField(
                                          decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20))),
                                          value: _selectedStatus,
                                          items: [
                                            DropdownMenuItem(
                                                value: 'Available',
                                                child: Text('Available')),
                                            DropdownMenuItem(
                                                value: 'Checked Out',
                                                child: Text('Checked Out'))
                                          ],
                                          onChanged: (value) {
                                            setState(() {
                                              _selectedStatus = value!;
                                              print(_selectedStatus);
                                            });
                                          })
                                    ],
                                  )),
                              GestureDetector(
                                onTap: () async {
                                  if (_formKey.currentState!.validate()) {
                                    final result = await DBHelper.addBook(
                                        _bookIdController.text,
                                        _entryDateController.text,
                                        _genNoController.text,
                                        _authorController.text,
                                        _titleController.text,
                                        _publisherController.text,
                                        _publishDateController.text,
                                        _noPagesController.text,
                                        _priceController.text,
                                        _supplyModeController.text,
                                        _removeDateController.text,
                                        _extraDetailsController.text,
                                        _availabilityController.text);
                                    print(result);
                                    if (result == true) {
                                      setState(() {
                                        reset();
                                      });
                                    } else {
                                      print(false);
                                    }
                                  }
                                },
                                child: Container(
                                  width: width * 0.1,
                                  height: height * 0.05,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 55, 104, 160),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                    child: Text('ADD'),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FormFieldWid extends StatelessWidget {
  const FormFieldWid(
      {super.key,
      required this.isNumber,
      required this.controller,
      required this.errText,
      required this.hintText,
      required this.labelText});

  final TextEditingController controller;
  final String errText;
  final String hintText;
  final String labelText;
  final bool isNumber;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
        width: width / 5,
        margin: const EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              labelText,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 20, 113, 213)),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextFormField(
                keyboardType:
                    isNumber ? TextInputType.number : TextInputType.text,
                inputFormatters:
                    isNumber ? [FilteringTextInputFormatter.digitsOnly] : [],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return errText;
                  }
                },
                controller: controller,
                decoration: InputDecoration(
                    hintText: hintText,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.black)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.black)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            )
          ],
        ));
  }
}
