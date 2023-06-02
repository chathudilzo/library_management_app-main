import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:csv/csv.dart';

Future<List<Map<String, dynamic>>> loadUserCsvData(String path) async {
  final userCsvString = await rootBundle.loadString(path);

  //parse csv
  final csv = CsvToListConverter().convert(userCsvString);

  // skip the first row (headers)
  csv.removeAt(0);

  //Map csv data to list of user objects IndexNo,FullName,Class,Address,Parent/Guardian,charges,lastUpdatedDate
  final users = csv.map((row) {
    return {
      'IndexNo': row[0],
      'FullName': row[1],
      'Class': row[2],
      'Address': row[3],
      'Parent_or_Guardian': row[4],
      'charges': (row[5] ?? 0.0).toString(),
      'lastUpdatedDate': row[6],
      'Email': row[7],
      'TP': row[8]
    };
  }).toList();
  print(users);
  return users;
}

Future<List<Map<String, dynamic>>> loadBooksCsvData(String path) async {
  final bookCsvString = await rootBundle.loadString(path);

  final csv = CsvToListConverter().convert(bookCsvString);

  csv.removeAt(0);
//Book_id,Date_of_Entry,Genre_No,Author,Book_Title,Publisher_and_Address,Date_of_published_and_print,
//Number_of_Pages,Price,Mode_of_supply,Date_of_remove,Extra_details,Availability

  final books = csv.map((row) {
    return {
      'Book_id': row[0],
      'Date_of_Entry': row[1],
      'Genre_No': row[2],
      'Author': row[3],
      'Book_Title': row[4],
      'Publisher_and_Address': row[5],
      'Date_of_published_and_print': row[6],
      'Number_of_Pages': row[7].toString(),
      'Price': row[8].toString(),
      'Mode_of_supply': row[9],
      'Date_of_remove': row[10],
      'Extra_details': row[11],
      'Availability': row[12]
    };
  }).toList();
  return books;
}

Future<List<Map<String, dynamic>>> loadIssuedBooksData(String path) async {
  final ibookCsvString = await rootBundle.loadString(path);

  final csv = CsvToListConverter().convert(ibookCsvString);

  csv.removeAt(0);

  final issuedBooks = csv.map((row) {
    //Book_id,IndexNo,Date of Issue,Maturity Day,Charges
    return {
      'Book_id': row[0],
      'IndexNo': row[1],
      'DateofIssue': row[2],
      'MaturityDay': row[3],
      'Charges': (row[4] ?? 0.0).toString()
    };
  }).toList();
  return issuedBooks;
}

Future<List<Map<String, dynamic>>> loadloginData(String path) async {
  final logCsvString = await rootBundle.loadString(path);

  final csv = CsvToListConverter().convert(logCsvString);

  csv.removeAt(0);

  final adminLog = csv.map((row) {
    return {
      'username': row[0],
      'password': row[1],
      'gmail': row[2],
      'gpassword': row[3]
    };
  }).toList();
  return adminLog;
}
