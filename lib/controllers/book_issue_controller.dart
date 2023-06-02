// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:csv/csv.dart';
// import 'dart:io';

// import 'package:path_provider/path_provider.dart';

// class BookIssueController extends GetxController {
//   late List<List<dynamic>> _usersList;
//   late List<List<dynamic>> _booksList;
//   late List<List<dynamic>> _issuedBooksList;

//   @override
//   void onInit() {
//     super.onInit();
//     _loadData();
//   }

//   void _loadData() async {
//     // Load users.csv
//     final usersFile =
//         File('${(await getApplicationDocumentsDirectory()).path}/Users.csv');
//     final usersData = await usersFile.readAsString();
//     _usersList = CsvToListConverter().convert(usersData);

//     // Load books.csv
//     final booksFile =
//         File('${(await getApplicationDocumentsDirectory()).path}/Books.csv');
//     final booksData = await booksFile.readAsString();
//     _booksList = CsvToListConverter().convert(booksData);

//     // Load issuedbooks.csv
//     final issuedBooksFile = File(
//         '${(await getApplicationDocumentsDirectory()).path}/Issuedbooks.csv');
//     final issuedBooksData = await issuedBooksFile.readAsString();
//     _issuedBooksList = CsvToListConverter().convert(issuedBooksData);
//   }

//   Future<void> issueBook(String user_id, String bookId, String issueDate,
//       String maturityDate) async {
//     // print('User List: $_usersList');
//     // print('Books List: $_booksList');
//     // print('Issued Books List: $_issuedBooksList');

//     print(user_id);
//     print(bookId);
//     // Check if user exists in users.csv
//     final user = _usersList.firstWhere((row) {
//       print(row[0]);
//       return row[0].toString() == user_id.trim();
//     }, orElse: () => []);

//     //print(_usersList);
//     print(user);
//     if (user.isEmpty) {
//       Get.snackbar('Error', 'User not found.');
//       return;
//     }

//     // Check if book exists in books.csv
//     final book = _booksList.firstWhere((row) => row[0].toString() == bookId,
//         orElse: () => []);
//     if (book.isEmpty) {
//       Get.snackbar('Error', 'Book not found.');
//       return;
//     }

//     // Check if user has already issued two books
//     final userIssuedBooks = _issuedBooksList.where((row) {
//       final bool isUserMatch = row[1].toString() == user_id;
//       print(row[1].toString());
//       if (isUserMatch) {
//         print(row);
//       }
//       return isUserMatch;
//     }).toList();
//     print(userIssuedBooks);
//     if (userIssuedBooks.length >= 2) {
//       Get.snackbar('Error', 'User has already issued two books.');
//       return;
//     }

//     // Add new book to issued books list
//     List<dynamic> newIssuedBook = [
//       bookId,
//       user_id,
//       issueDate,
//       maturityDate,
//       0.0
//     ];
//     _issuedBooksList.add(newIssuedBook);

//     // Save data to issuedbooks.csv
//     final issuedBooksFile = File(
//         '${(await getApplicationDocumentsDirectory()).path}/Issuedbooks.csv');
//     issuedBooksFile
//         .writeAsString(const ListToCsvConverter().convert(_issuedBooksList));
//     Get.snackbar('Success', 'Book issued successfully.');
//   }
// }
