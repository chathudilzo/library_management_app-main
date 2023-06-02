import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:library_pc/controllers/bar_chart_controller.dart';
import 'package:library_pc/controllers/pie_chart_controller.dart';
import 'package:library_pc/pages/issued_books.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DBHelper {
  static late Database _database;

  static Future<void> init() async {
    //// Initialize the sqflite_ffi database factory
    sqfliteFfiInit();

    // Set the default database factory to use sqflite_ffi
    databaseFactory = databaseFactoryFfi;

    //open db

    final dbPath = join(await getDatabasesPath(), 'my_database.db');
    _database = await databaseFactory.openDatabase(dbPath);

    //await _database.execute('DROP TABLE IF EXISTS users');
    //await _database.execute('DROP TABLE IF EXISTS issuedBooks');
    //await _database.execute('DROP TABLE IF EXISTS books');
    //await _database.execute('DROP TABLE IF EXISTS days');
    //await _database.execute('DROP TABLE IF EXISTS admins');

    await _database.execute('''
CREATE TABLE IF NOT EXISTS emailUpdating(
  id INTEGER PRIMARY KEY,
  date TEXT
)
 ''');

    await _database.execute('''
CREATE TABLE IF NOT EXISTS emailStats(
id INTEGER PRIMARY KEY,
indexNo TEXT,
bookId TEXT,
email TEXT,
charges TEXT,
send TEXT
)
''');

    await _database.execute('''
    CREATE TABLE IF NOT EXISTS admins(
      id INTEGER PRIMARY KEY,
      username TEXT,
      password TEXT,
      gmail TEXT,
      gpassword TEXT
    )
    ''');

    //create tables IndexNo,FullName,Class,Address,Parent/Guardian,charges,lastUpdatedDate
    await _database.execute('''
      CREATE TABLE IF NOT EXISTS users(
        id INTEGER PRIMARY KEY,
        IndexNo TEXT,
        FullName TEXT,
        Class TEXT,
        Address TEXT,
        Parent_or_Guardian TEXT,
        charges TEXT DEFAULT 0.0,
        lastUpdatedDate TEXT,
        Email TEXT,
        TP TEXT
      )
      ''');
    await _database.execute('''
CREATE TABLE IF NOT EXISTS days(
  id INTEGER PRIMARY KEY,
  day TEXT,
  
  issued INTEGER,
  returned INTEGER, 
  updatedDate TEXT
)
 ''');

    //Book_id,Title,Author,ISBN,Genre,Published Year
    await _database.execute('''
    CREATE TABLE IF NOT EXISTS books(
      id INTEGER PRIMARY KEY,
      Book_id TEXT,
      Date_of_Entry TEXT,
      Genre_No TEXT,
      Author TEXT,
      Book_Title TEXT,
      Publisher_and_Address TEXT,
      Date_of_published_and_print TEXT,
      Number_of_Pages TEXT,
      Price TEXT,
      Mode_of_supply TEXT,
      Date_of_remove TEXT,
      Extra_details TEXT,
      Availability TEXT

    )
    ''');
    //Book_id,IndexNo,Date of Issue,Maturity Day,Charges
    await _database.execute('''
    CREATE TABLE IF NOT EXISTS issuedBooks(
    id INTEGER PRIMARY KEY,
    Book_id TEXT,
    IndexNo TEXT,
    DateofIssue TEXT,
    MaturityDay TEXT,
    charges TEXT DEFAULT 0.0

    )''');
  }

  static Future<List<Map<String, dynamic>>> getDays() async {
    try {
      DBHelper.dateDataSetup();
      final days = await _database.query('days');
      return days.map((day) {
        return day;
      }).toList();
    } catch (e) {
      //print(e.toString());
      return [];
    }
  }

  // static Future<List<Map<String, dynamic>>> getDays() async {
  //   try {
  //     final days = await _database.query('days');
  //     return days;
  //   } catch (e) {
  //     print(e.toString());
  //     return [];
  //   }
  // }
  // static Future<List<Map<String, dynamic>>> getDays() async {
  //   // Replace this with your actual database query
  //   await Future.delayed(Duration(seconds: 1));

  //   return [
  //     {'day': 'Mon', 'issued': 5, 'returned': 3},
  //     {'day': 'Tue', 'issued': 10, 'returned': 5},
  //     {'day': 'Wed', 'issued': 8, 'returned': 4},
  //     {'day': 'Thu', 'issued': 12, 'returned': 7},
  //     {'day': 'Fri', 'issued': 6, 'returned': 2},
  //     {'day': 'Sat', 'issued': 4, 'returned': 3},
  //     {'day': 'Sun', 'issued': 7, 'returned': 5},
  //   ];
  // }
  // static void sendMailsIsolate(SendPort sendPort) async {
  //   await sendMails();

  //   sendPort.send('completed');
  // }

  static Future<void> isDaysEmpty() async {
    try {
      final results = await _database.rawQuery('SELECT COUNT(*) FROM days');
      final count = results[0]['COUNT(*)'] as int;
      //print('date count:$count');
      if (count == 0) {
        final daysOfweek = [
          'Sunday',
          'Monday',
          'Tuesday',
          'Wednesday',
          'Thursday',
          'Friday',
          'Saturday'
        ];
        for (final day in daysOfweek) {
          await _database
              .insert('days', {'day': day, 'issued': 0, 'returned': 0});
        }
        final count1 = await _database.rawQuery('SELECT COUNT(*) FROM days');
        //print('updated date count:$count1');
        DateTime today = DateTime.now();
        DateTime sunday;
        if (today.weekday == DateTime.sunday) {
          sunday = today;
        } else {
          sunday = today.subtract(Duration(days: today.weekday));
        }
        await _database.rawUpdate('UPDATE days SET updatedDate=? WHERE day=?',
            [sunday.toString(), 'Sunday']);
      }
    } catch (e) {
      Get.snackbar(
          backgroundColor: Color.fromARGB(255, 105, 10, 4),
          'Error',
          e.toString());
    }
  }

  static Future<void> dateDataSetup() async {
    try {
      await DBHelper.isDaysEmpty();
      await DBHelper.checkSunday();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  static Future<void> checkSunday() async {
    try {
      final List<Map<String, dynamic>> result = await _database.query('days',
          where: 'day=?', whereArgs: ['Sunday'], limit: 1);
      DateTime currentSundayDate;

      if (result.isNotEmpty) {
        final Row = result.first;
        currentSundayDate = DateTime.parse(Row['updatedDate']);
        final nextSundayDate = currentSundayDate.add(Duration(days: 7));
        final currentDate = DateTime.now();

        if (currentDate.isAfter(nextSundayDate) ||
            currentDate == nextSundayDate) {
          await _database.delete('days');
          await DBHelper.isDaysEmpty();
        }
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  static Future<void> setDates(DateTime date, String job) async {
    try {
      int dayOfWeek = date.weekday;
      String dayName;
      await DBHelper.isDaysEmpty();

      switch (dayOfWeek) {
        case 1:
          dayName = 'Monday';
          break;
        case 2:
          dayName = 'Tuesday';
          break;
        case 3:
          dayName = 'Wednesday';
          break;
        case 4:
          dayName = 'Thursday';
          break;
        case 5:
          dayName = 'Friday';
          break;
        case 6:
          dayName = 'Saturday';
          break;
        case 7:
          dayName = 'Sunday';
          break;
        default:
          dayName = 'Invalid Day';
          break;
      }
      if (job == 'issued') {
        await _database.rawUpdate(
            'UPDATE days SET issued=issued+1 WHERE day=?', [dayName]);
        print(_database.query('days'));
      } else if (job == 'returned') {
        await _database.rawUpdate(
            'UPDATE days SET returned=returned+1 WHERE day=?', [dayName]);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  static Future<void> sendMails() async {
    try {
      final res = await DBHelper.isAdminCredentialsSet();
      //print(res);
      if (res) {
        final dateResult =
            await _database.query('emailUpdating', where: 'id = 1');

        final date = dateResult.isNotEmpty ? dateResult.first['date'] : '';
        // print('Before date: $date');
        if (date != DateFormat('yyyy-MM-dd').format(DateTime.now())) {
          await DBHelper.clearMailStateTable();

          final issuedBooksData = await _database
              .query('issuedBooks', columns: ['IndexNo', 'Book_id', 'charges']);

          for (final bookData in issuedBooksData) {
            final indexNo = bookData['IndexNo'] as String;
            final bookId = bookData['Book_id'] as String;
            final charges = bookData['charges'] as String;

            final usersWithEmail = await _database.query('users',
                columns: ['Email'], where: 'IndexNo=?', whereArgs: [indexNo]);

            if (usersWithEmail.isNotEmpty) {
              final email = usersWithEmail[0]['Email'] as String;

              await _database.insert('emailStats', {
                'indexNo': indexNo,
                'bookId': bookId,
                'email': email,
                'charges': charges,
                'send': 'false'
              });
            }
          }
          final currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
          await _database.delete('emailUpdating', where: '1');

          await _database.insert('emailUpdating', {'date': currentDate});
          final dateResultafter =
              await _database.query('emailUpdating', where: 'id = 1');
          //print('After date: $dateResultafter');
        }
        final isEmpty = await DBHelper.isEmailStatsTableEmpty(_database);

        if (!isEmpty) {
          String username = '';
          String password = '';

          String _message = '';
          String _recEmail = '';
          String _subj = '';
          final mailData = await DBHelper.getAdminCredentials();
          username = mailData['gmail'].toString();
          password = mailData['gpassword'].toString();
          final List<Map<String, dynamic>> allEmailStats =
              await DBHelper.getEmailStats();
          //print('All emails Stats: $allEmailStats');
          for (final emailStat in allEmailStats) {
            // print('${emailStat['send'].toString()}');
            // print('${emailStat['email'].toString()}');
            // print('emailstat:$emailStat');

            if (emailStat['send'].toString() == 'true' ||
                emailStat['send'].toString() == 'false') {
              //print('yes');
              _message =
                  'Dear ${emailStat['indexNo'].toString()},\n\nWe would like to inform you that you have an outstanding charge of Rs ${emailStat['charges'].toString()} for the book with ID ${emailStat['bookId'].toString()}. This charge is due to exceeding the maturity date. To ensure a smooth experience for all library users, we kindly request you to return the book as soon as possible.\n\nYour cooperation is greatly appreciated.\n\nPlease note that this is an automated email. Kindly refrain from replying to this message.';

              _recEmail = emailStat['email'].toString();
              _subj = 'Reminder:Maturity Charges';

              final success = await DBHelper.sendMailFunc(
                  username, password, _message, _recEmail, _subj);
              print('Message sent success or not $success');
              if (success) {
                await _database.update('emailStats', {'send': 'true'},
                    where: 'id = ?', whereArgs: [emailStat['id']]);
                //Get.snackbar('Success', 'Done');
              } else {
                await _database.update(
                  'emailStats',
                  {'send': 'false'},
                  where: 'id = ?',
                  whereArgs: [emailStat['id']],
                );
                //Get.snackbar(backgroundColor: Colors.red,'Error', 'Not Done');
              }
            }
          }
          final List<Map<String, dynamic>> allEmailStatsafter =
              await DBHelper.getEmailStats();

          ///print('All emails Stats: $allEmailStatsafter');
        }
      } else {
        Get.snackbar(
            'Error', 'You need to add App Password and Gmail to the app ',
            backgroundColor: Color.fromARGB(255, 131, 18, 10));
      }
    } catch (e) {
      //print('Error sending mail $e');
      Get.snackbar('Error', e.toString(),
          backgroundColor: Color.fromARGB(255, 131, 18, 10));
    }
  }

  static Future<bool> sendMailFunc(String username, String password,
      String mailMessage, String recEmail, String subj) async {
    try {
      print('$username and $password');
      final smtpServer = gmail(username, password);
      final message = Message()
        ..from = Address(username, 'LM System')
        ..recipients.add(recEmail)
        ..subject = subj
        ..text = mailMessage;

      final SendReport = await send(message, smtpServer);
      print('Message send:' + SendReport.toString());
      Get.snackbar('Details', SendReport.toString(),
          backgroundColor: Colors.green);
      return true;
    } catch (e) {
      //print(e.toString());
      return false;
    }
  }

  static Future<bool> checkAdmin() async {
    try {
      final result = await _database.rawQuery('SELECT COUNT(*) FROM admins');
      final count = result[0]['COUNT(*)'] as int;
      if (count == 0) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return false;
    }
  }

  static Future<void> insertAdmin(List<Map<String, dynamic>> admins) async {
    try {
      final results = await _database.rawQuery('SELECT COUNT(*) FROM admins');
      final count = results[0]['COUNT(*)'] as int;

      ///print(count);
//
      if (count == 0) {
        print('admin added again');
        final batch = _database.batch();
        for (final admin in admins) {
          batch.insert('admins', admin);
        }

        await batch.commit();
      }
    } catch (e) {
      Get.snackbar(
          backgroundColor: Color.fromARGB(255, 102, 13, 7),
          'Error',
          e.toString());
    }
  }

  static Future<void> insertUsers(List<Map<String, dynamic>> users) async {
    try {
      final results = await _database.rawQuery('SELECT COUNT(*) FROM users');
      final count = results[0]['COUNT(*)'] as int;
      //print(count);

      if (count == 0) {
        print('users added again');
        final batch = _database.batch();
        for (final user in users) {
          batch.insert('users', user);
        }

        await batch.commit();
      }
    } catch (e) {
      Get.snackbar(backgroundColor: Colors.red, 'Error', e.toString());
    }
  }

  static Future<void> insertIssuedBooks(
      List<Map<String, dynamic>> issuedBooks) async {
    try {
      final results =
          await _database.rawQuery('SELECT COUNT(*) FROM issuedBooks');
      final count = results[0]['COUNT(*)'] as int;
      //print(count);

      if (count == 0) {
        // print('new issuedbooks added');
        final batch = _database.batch();
        for (final issuedBook in issuedBooks) {
          batch.insert('issuedBooks', issuedBook);
        }
        await batch.commit();
      }
    } catch (e) {
      Get.snackbar('Success', e.toString());
    }
  }

  static Future<void> clearMailStateTable() async {
    try {
      await _database.delete('emailStats', where: '1');
    } catch (e) {
      Get.snackbar(backgroundColor: Colors.red, 'Error', e.toString());
    }
  }

  static Future<List<Map<String, dynamic>>> getEmailStats() async {
    try {
      final List<Map<String, dynamic>> emailStats =
          await _database.query('emailStats');
      return emailStats;
    } catch (e) {
      //print(e);
      return [];
    }
  }

  static Future<bool> isEmailStatsTableEmpty(Database database) async {
    final result = await database.rawQuery('SELECT COUNT(*) FROM emailStats');
    final count = result[0]['COUNT(*)'] as int;
    return count == 0;
  }

  static Future<void> insertBooks(List<Map<String, dynamic>> books) async {
    final results = await _database.rawQuery('SELECT COUNT(*) FROM books');
    final count = results[0]['COUNT(*)'] as int;
    //print(count);

    if (count == 0) {
      //print('books added again');
      final batch = _database.batch();
      //print(books);
      for (final book in books) {
        batch.insert('books', book);
      }

      await batch.commit();
    }
  }

  static Future<List<Map<String, dynamic>>> getUsers() async {
    try {
      final users = await _database.query('users');
      //print(users);
      return users.map((user) {
        // print('user data');
        //print(user);
        return user;
      }).toList();
    } catch (e) {
      // print(e);
      return [];
    }
  }

  static Future<List<Map<String, dynamic>>> getBooks() async {
    try {
      await DBHelper.updateBookAvailability();
      final books = await _database.query('books');
      // print(books);
      return books.map((book) {
        //print(book);
        return book;
      }).toList();
    } catch (e) {
      //print(e);
      return [];
    }
  }

  static Future<List<Map<String, dynamic>>> getAdmins() async {
    final admins = await _database.query('admins');
    return admins.map((admin) {
      return admin;
    }).toList();
  }

  // static Future<List<Map<String, dynamic>>> getIssuedbooks() async {
  //   final issuedBooks = await _database.query('issuedBooks');

  //   final updatedIssuedBooks = await Future.wait(issuedBooks.map((book) async {
  //     final maturityDay = DateTime.parse(book['MaturityDay']! as String);
  //     final differenceInDays = DateTime.now().difference(maturityDay).inDays;

  //     var charges = 0;
  //     if (differenceInDays > 0) {
  //       charges = 5 * differenceInDays;
  //     }
  //     // Create a new map with the updated values
  //     final updatedBook = {...book, 'charges': charges.toString()};

  //     await _database.update('issuedBooks', updatedBook,
  //         where: 'id =?', whereArgs: [book['id']]);

  //     return updatedBook;
  //   }));

  //   // Group updated issued books by IndexNo
  //   final issuedBooksByIndexNo = <String, List<Map<String, dynamic>>>{};
  //   for (final book in updatedIssuedBooks) {
  //     final indexNo = book['IndexNo'] as String;
  //     issuedBooksByIndexNo.putIfAbsent(indexNo, () => []).add(book);
  //   }

  //   // Update user charges for each group of issued books
  //   for (final indexNo in issuedBooksByIndexNo.keys) {
  //     final books = issuedBooksByIndexNo[indexNo]!;
  //     var totalCharges = 0;
  //     for (final book in books) {
  //       totalCharges += int.parse(book['charges'] as String);
  //     }
  //     final usersWithIndexNo = await _database
  //         .query('users', where: 'IndexNo=?', whereArgs: [indexNo]);
  //     if (usersWithIndexNo.isNotEmpty) {
  //       final currentCharge =
  //           double.parse(usersWithIndexNo[0]['charges'] as String);
  //       final currentDate = DateTime.now().toString().substring(0, 10);
  //       final lastUpdatedDate =
  //           usersWithIndexNo[0]['lastUpdatedDate'] as String?;

  //       if (lastUpdatedDate != currentDate) {
  //         final newCharges = currentCharge + totalCharges;
  //         await _database.update(
  //             'users',
  //             {
  //               'charges': newCharges.toString(),
  //               'lastUpdatedDate': currentDate
  //             },
  //             where: 'IndexNo= ?',
  //             whereArgs: [indexNo]);
  //       }
  //     }
  //   }

  //   return updatedIssuedBooks;
  // }

  static Future<bool> registerAdmin(
      String userName, String password, String adminGmail, String appPw) async {
    try {
      await _database.insert('admins', {
        'username': userName,
        'password': password,
        'gmail': adminGmail,
        'gpassword': appPw,
      });
      return true;
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return false;
    }
  }

//IndexNo,FullName,Class,Address,Parent_or_Guardian,charges,lastUpdatedDate
  static Future<bool> addUser(
      String indexNo,
      String fullName,
      String classn,
      String address,
      String parent,
      String charges,
      String email,
      String tp) async {
    // print(indexNo);
    // print(fullName);
    // print(classn);
    // print(address);
    // print(parent);
    // print(charges);
    // print(email);
    // print(tp);
    try {
      final existingUser = await _database
          .query('users', where: 'IndexNo=?', whereArgs: [indexNo]);

      if (existingUser.isNotEmpty) {
        Get.snackbar(
            backgroundColor: Colors.red,
            'Error',
            'User with index $indexNo already exists');
        return false;
      } else {
        await _database.insert('users', {
          'IndexNo': indexNo,
          'FullName': fullName,
          'Class': classn,
          'Address': address,
          'Parent_or_Guardian': parent,
          'charges': charges,
          'Email': email,
          'TP': tp
        });

        Get.snackbar(
            'Success', 'User $fullName with $indexNo successfully Registered!',
            backgroundColor: Colors.green);
        return true;
      }
    } catch (e) {
      Get.snackbar(backgroundColor: Colors.red, 'Error', e.toString());
      return false;
    }
  }

//Book_id,Date_of_Entry,Genre_No,Author,Book_Title,Publisher_and_Address,Date_of_published_and_print,
  //Number_of_Pages,Price,Mode_of_supply,Date_of_remove,Extra_details,Availability
  static Future<bool> addBook(
      String bookid,
      String entryDate,
      String genre,
      String author,
      String title,
      String publisher,
      String publishedDate,
      String pages,
      String price,
      String supMode,
      String removeDate,
      String details,
      String availability) async {
    try {
      //print(
      //    '$bookid $entryDate $genre $author $title $publisher $publishedDate $pages $price $supMode $removeDate $details $availability');
      final existingBook = await _database
          .query('books', where: 'Book_id=?', whereArgs: [bookid]);
      if (existingBook.isNotEmpty) {
        Get.snackbar(
            backgroundColor: Colors.red, 'Error', '$bookid Already exists!');
        return false;
      } else {
        final res = await _database.insert('books', {
          'Book_id': bookid,
          'Date_of_Entry': entryDate,
          'Genre_No': genre,
          'Author': author,
          'Book_Title': title,
          'Publisher_and_Address': publisher,
          'Date_of_published_and_print': publishedDate,
          'Number_of_Pages': pages,
          'Price': price,
          'Mode_of_supply': supMode,
          'Date_of_remove': removeDate,
          'Extra_details': details,
          'Availability': availability
        });
        DBHelper.updateBookAvailability();
        Get.snackbar('Success', '$title Book Successfully Added',
            backgroundColor: Colors.green);
      }
      return true;
    } catch (e) {
      Get.snackbar(backgroundColor: Colors.red, 'Error', e.toString());
      return false;
    }
  }

//Book_id,IndexNo,Date of Issue,Maturity Day,Charges
  static Future<bool> issueBook(String Book_id, String IndexNo,
      String DateofIssue, String MaturityDay, String Charges) async {
    //print('..............................................');
    //print('$Book_id $IndexNo $DateofIssue $MaturityDay $Charges');

    try {
      await DBHelper.updateBookAvailability();

      final usersWithIndexNo = await _database
          .query('users', where: 'IndexNo=?', whereArgs: [IndexNo]);
      //print(usersWithIndexNo);
      final booksWithBookid = await _database
          .query('books', where: 'Book_id=?', whereArgs: [Book_id]);

      final availableCheck = await _database.query('books',
          where: 'Book_id=? AND Availability=?',
          whereArgs: [Book_id, 'Available']);

      bool isAfterDAte(DateTime maturitytDate, DateTime issuedDate) {
        return maturitytDate.isAfter(issuedDate);
      }

      bool isVAlid = isAfterDAte(DateFormat('yyyy-MM-dd').parse(MaturityDay),
          DateFormat('yyyy-MM-dd').parse(DateofIssue));

      if (usersWithIndexNo.isEmpty) {
        Get.snackbar(
            backgroundColor: Color.fromARGB(255, 163, 19, 8),
            'Error',
            'Invalid IndexNo');
        return false;
      } else if (booksWithBookid.isEmpty) {
        Get.snackbar(
            backgroundColor: Color.fromARGB(255, 126, 15, 7),
            'Error',
            'Invalid BookID');
        return false;
      } else if (availableCheck.isEmpty) {
        Get.snackbar(
            backgroundColor: Colors.red,
            'Error',
            'Book Not Currently Available!');
        return false;
      } else if (!isVAlid) {
        Get.snackbar(
          'Date Issue',
          'Maturity Date must be a date after issue Date',
          backgroundColor: Colors.red,
        );
        return false;
      } else {
        final usersIssuedBooks = await _database
            .query('issuedBooks', where: 'IndexNo=?', whereArgs: [IndexNo]);
        if (usersIssuedBooks.length > 0) {
          Get.snackbar(
            'Warning',
            'User already have a issued book',
            backgroundColor: Colors.amberAccent,
          );
        }
        await _database.insert('issuedBooks', {
          'Book_id': Book_id,
          'IndexNo': IndexNo,
          'DateofIssue': DateofIssue,
          'MaturityDay': MaturityDay,
          'Charges': Charges
        });
        await DBHelper.updateBookAvailability();

        Get.snackbar('Success', '$Book_id issued to $IndexNo Successfully',
            backgroundColor: Colors.green);
        await DBHelper.setDates(DateTime.now(), 'issued');
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> getIssuedBookDetails(
      String Book_id) async {
    try {
      await DBHelper.getIssuedbooks1();
      final List<Map<String, dynamic>> results = await _database.query(
          'issuedBooks',
          where: 'Book_id=?',
          whereArgs: [Book_id.toUpperCase()]);
      if (results.isEmpty) {
        Get.snackbar('Error', 'Book Not Found');
      }
      return results;
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return [];
    }
  }

  static Future<bool> returnBook(
      String IndexNo, String BookID, String paycharges) async {
    try {
      await DBHelper.getIssuedbooks1();
      await DBHelper.updateBookAvailability();

      //print('$IndexNo $BookID $paycharges');
      final List<Map<String, dynamic>> book = await _database
          .query('issuedBooks', where: 'Book_id=?', whereArgs: [BookID]);

      if (book.isEmpty) {
        Get.snackbar(backgroundColor: Colors.red, 'Error', 'Book Not Found');
        return false;
      } else {
        final bookIndex = book[0]['IndexNo'] as String;
        print(bookIndex.toUpperCase());
        if (bookIndex.toUpperCase() != IndexNo) {
          Get.snackbar(backgroundColor: Colors.red, 'Error', 'Invalid IndexNo');
          return false;
        } else {
          final List<Map<String, dynamic>> user = await _database
              .query('users', where: 'IndexNo=?', whereArgs: [IndexNo]);

          if (user.isNotEmpty) {
            // print(user);
            final currentCharges = double.parse(user[0]['charges'] as String);

            //// print(currentCharges);
            if (paycharges.isNotEmpty && paycharges != null) {
              final updatedCharges = currentCharges - double.parse(paycharges);
              print('updatedCharges $updatedCharges');
              await _database.update('users', {'charges': updatedCharges},
                  where: 'IndexNo=?', whereArgs: [IndexNo]);
            }
            await _database
                .delete('issuedBooks', where: 'Book_id=?', whereArgs: [BookID]);

            Get.snackbar('Success', 'Book Successfully Accepted!',
                backgroundColor: Colors.green);
            await DBHelper.updateBookAvailability();
            await DBHelper.setDates(DateTime.now(), 'returned');
            return true;
          }
          return false;
        }
      }
    } catch (e) {
      Get.snackbar(backgroundColor: Colors.red, 'Error', e.toString());
      return false;
    }
  }

  static Future<void> updateBookAvailability() async {
    try {
      final issuedBooks = await _database.query('issuedBooks');
      final checkedOutBooks =
          issuedBooks.map((book) => book['Book_id'] as String);

      final books = await _database.query('books');
      for (final book in books) {
        final bookId = book['Book_id'] as String;
        final availability =
            checkedOutBooks.contains(bookId) ? 'Checked Out' : 'Available';

        await _database.update('books', {'Availability': availability},
            where: 'Book_id=?', whereArgs: [bookId]);
        BarChartController.onDataUpdated();
        PieChartController.onDataUpdated();
      }
    } catch (e) {
      //print(e);
      Get.snackbar('Error', e.toString());
    }
  }

  static Future<List<Map<String, dynamic>>> getIssuedbooks1() async {
    try {
      final issuedBooks = await _database.query('issuedBooks');

      final issuedBooksByIndexNo = <String, List<Map<String, dynamic>>>{};
      for (final book in issuedBooks) {
        final IndexNo = book['IndexNo'] as String;
        issuedBooksByIndexNo.putIfAbsent(IndexNo, () => []).add(book);
      }
      //print('issuedindexses $issuedBooksByIndexNo');

      for (final IndexNo in issuedBooksByIndexNo.keys) {
        final books = issuedBooksByIndexNo[IndexNo]!;
        var totalPreviousCharges = 0;
        var totalNewCharges = 0;

        for (final book in books) {
          totalPreviousCharges += int.tryParse(book['charges'] as String) ?? 0;
          final maturityDay = DateTime.parse(book['MaturityDay'] as String);
          final differenceInDays =
              DateTime.now().difference(maturityDay).inDays;
          final newCharges = differenceInDays > 0 ? 5 * differenceInDays : 0;
          totalNewCharges += newCharges;

          await _database.update(
            'issuedBooks',
            {'charges': newCharges.toString()},
            where: 'id=?',
            whereArgs: [book['id']],
          );
        }
        final usersWithIndexNo = await _database
            .query('users', where: 'IndexNo=?', whereArgs: [IndexNo]);

        if (usersWithIndexNo.isNotEmpty) {
          final currentCharge =
              double.tryParse(usersWithIndexNo[0]['charges'] as String) ?? 0;
          final currentDate = DateTime.now().toString().substring(0, 10);
          final lastUpdatedDate =
              usersWithIndexNo[0]['lastUpdatedDate'] as String;
          var newCharge =
              currentCharge - totalPreviousCharges + totalNewCharges;

          if (lastUpdatedDate != null && lastUpdatedDate == currentDate) {
            newCharge = currentCharge;
          }

          await _database.update(
              'users',
              {
                'charges': newCharge.toString(),
                'lastUpdatedDate': currentDate,
              },
              where: 'IndexNo=?',
              whereArgs: [IndexNo]);
        }
      }
      return await _database.query('issuedBooks');
    } finally {}
  }

  static Future<List<Map<String, dynamic>>> getallBooksAvailability() async {
    try {
      final books = await _database
          .query('books', columns: ['Book_id', 'Book_Title', 'Availability']);
      return books;
    } catch (e) {
      Get.snackbar(backgroundColor: Colors.red, 'Error', e.toString());
      return [];
    }
  }

  static Future<List<String?>> getLastBookid() async {
    final result = await _database.rawQuery(
      'SELECT Book_id FROM books ORDER BY Book_id DESC LIMIT 1',
    );
    final result1 = await _database.rawQuery(
      'SELECT Book_id FROM books ORDER BY id DESC LIMIT 1',
    );
    String? id1;
    String? id2;

    if (result.isNotEmpty) {
      id1 = result.first['Book_id'] as String?;
    }
    if (result1.isNotEmpty) {
      id2 = result1.first['Book_id'] as String?;
    }
    return [id1, id2];
  }

  static Future<List<Map<String, dynamic>>> getGenreList() async {
    try {
      return await _database.rawQuery(
          '''SELECT Genre_No, COUNT(*) as Count FROM books GROUP BY Genre_No ''');
    } catch (e) {
      //print(e);
      return [];
    }
  }

  static Future<List<int>> getBookAvailabilityInfo() async {
    final List<int> stats = [];

    try {
      final availableCount = await _database.rawQuery(
          'SELECT COUNT(*) FROM books WHERE Availability="Available"');

      stats.add(availableCount.first.values.first as int);

      final totalCount = await _database.rawQuery('SELECT COUNT(*) FROM books');
      stats.add(totalCount.first.values.first as int);

      final checkedOutCount = await _database.rawQuery(
          'SELECT COUNT(*) FROM books WHERE Availability="Checked Out"');
      stats.add(checkedOutCount.first.values.first as int);

      //print(stats);
      return stats;
    } catch (e) {
      Get.snackbar(backgroundColor: Colors.red, 'Error', e.toString());
      return [];
    }
  }

  static Future<Map<String, String>> getAdminCredentials() async {
    Database db = await _database;
    List<Map<String, dynamic>> rows =
        await db.rawQuery('SELECT gmail, gpassword FROM admins LIMIT 1');
    if (rows.length == 1) {
      String gmail = rows[0]['gmail'];
      String gpassword = rows[0]['gpassword'];
      return {'gmail': gmail, 'gpassword': gpassword};
    } else {
      return {};
    }
  }

  static Future<bool> updateAdminCred(String gmail, String gpassword) async {
    try {
      final int rowsAffected = await _database.rawUpdate(
          'UPDATE admins SET gmail=?,gpassword=? WHERE id=1',
          [gmail, gpassword]);
      Get.snackbar('Success', 'Admin Updated Successfully');
      return rowsAffected > 0;
    } catch (e) {
      Get.snackbar(
          backgroundColor: Colors.red,
          'Error',
          'Error Updating Adming Credentials: $e');
    }
    return false;
  }

  static Future<bool> isAdminCredentialsSet() async {
    try {
      final result = await _database
          .rawQuery('SELECT gmail, gpassword FROM admins LIMIT 1');
      // print(result);
      if (result.isEmpty) {
        return false;
      }
      if (result.isNotEmpty) {
        final Map<String, dynamic> row = result.first;
        final gmail = row['gmail'] as String;
        final gpassword = row['gpassword'] as String;
        return gmail != null &&
            gpassword != null &&
            gmail.isNotEmpty &&
            gpassword.isNotEmpty;
      }
    } catch (e) {
      // print('error checking admin cred $e');
      return false;
    }
    return false;
  }

  static Future<void> addAdmin(
      String username, String password, String gmail, String gpassword) async {
    try {
      await _database.rawDelete('DELETE FROM admins');

      await _database.rawInsert(
        'INSERT INTO admins(username,password,gmail,gpassword)'
        'VALUES (?,?,?,?)',
        [username, password, gmail, gpassword],
      );

      Get.snackbar('Success', 'Admin credentials added successfully.',
          backgroundColor: Colors.green);
    } catch (e) {
      Get.snackbar(
          backgroundColor: Colors.red,
          'ERROR',
          'Failed to add admin credentials.');
    }
  }

  static Future<void> downloadAllTables() async {
    try {
      final List<String> tableNames = ['users', 'books', 'issuedBooks'];
      for (final String tableName in tableNames) {
        final List<Map<String, dynamic>> rows =
            await _database.rawQuery('SELECT * FROM $tableName');
        final String csvHeader = rows[0].keys.join(',');
        final List<List<dynamic>> csvRows =
            rows.map((row) => row.values.toList()).toList();

        final Directory? downloadsDirectory = await getDownloadsDirectory();
        if (downloadsDirectory == null) {
          // print('Error: could not find Downloads directory');
          return;
        }
        final String savePath =
            '${downloadsDirectory.path}/MyApp/$tableName.csv';
        final File csvFile = File(savePath);
        if (!await csvFile.parent.exists()) {
          await csvFile.parent.create(recursive: true);
        }

        final IOSink sink = csvFile.openWrite();
        sink.writeln(csvHeader);
        for (final List<dynamic> row in csvRows) {
          sink.writeln(row.join(','));
        }
        await sink.close();

        Get.snackbar('Success', 'Data tables saved to $savePath',
            backgroundColor: Colors.green);
      }
    } catch (e) {
      Get.snackbar(backgroundColor: Colors.red, 'Error', e.toString());
    }
  }

  static Future<bool> updateUser(
      String indexNo,
      String Name,
      String classn,
      String address,
      String guardian,
      String charges,
      String email,
      String tp) async {
    try {
      final user = await _database
          .query('users', where: 'IndexNo=?', whereArgs: [indexNo]);
      if (user.isEmpty) {
        Get.snackbar(
            backgroundColor: Colors.red,
            'Error',
            'Invalid IndexNo,Something went wrong');
        return false;
      } else {
        await _database.update(
            'users',
            {
              'FullName': Name,
              'Class': classn,
              'Address': address,
              'Parent_or_Guardian': guardian,
              'charges': charges,
              'Email': email,
              'TP': tp
            },
            where: 'IndexNo=?',
            whereArgs: [indexNo]);
        Get.snackbar("Success", '$indexNo User Updated Successfully',
            backgroundColor: Colors.green);
        return true;
      }
    } catch (e) {
      Get.snackbar(backgroundColor: Colors.red, 'Error', '$e');
      return false;
    }
  }

  static Future<bool> updateBook(
      String bookId,
      String entryDate,
      String genre,
      String author,
      String bookTitle,
      String publisherAdd,
      String pubDateAndPrint,
      String noPages,
      String price,
      String supMode,
      String removeDate,
      String exDetails,
      String availability) async {
    try {
      final book = await _database
          .query('books', where: 'Book_id=?', whereArgs: [bookId]);

      if (book.isEmpty) {
        Get.snackbar(backgroundColor: Colors.red, 'Error', 'Book Not Found');
        return false;
      } else {
        await _database.update(
            'books',
            {
              'Book_id': bookId,
              'Date_of_Entry': entryDate,
              'Genre_No': genre,
              'Author': author,
              'Book_Title': bookTitle,
              'Publisher_and_Address': publisherAdd,
              'Date_of_published_and_print': pubDateAndPrint,
              'Number_of_Pages': noPages,
              'Price': price,
              'Mode_of_supply': supMode,
              'Date_of_remove': removeDate,
              'Extra_details': exDetails,
              'Availability': availability
            },
            where: 'Book_id=?',
            whereArgs: [bookId]);
        DBHelper.updateBookAvailability();
        Get.snackbar(
            backgroundColor: Color.fromARGB(255, 24, 158, 57),
            'Success',
            '$bookId Book Updated Successfully!');
        return true;
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
      return false;
    }
  }

  static Future<void> deleteAllUsers() async {
    try {
      await _database.delete('users');
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
    }
  }

  static Future<void> deleteAllBooks() async {
    try {
      await _database.delete('books');
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
    }
  }

  static Future<void> deleteAllIssuedBooks() async {
    try {
      await _database.delete('issuedBooks');
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
    }
  }

  static Future<void> deleteAllDays() async {
    try {
      await _database.delete('days');
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
    }
  }

  static Future<bool> resetDatabase() async {
    try {
      await DBHelper.deleteAllBooks();
      await DBHelper.deleteAllIssuedBooks();
      await DBHelper.deleteAllUsers();
      await DBHelper.deleteAllDays();

      BarChartController.onDataUpdated();
      PieChartController.onDataUpdated();
      Get.snackbar('Success', 'Database Reseted',
          backgroundColor: Colors.green);
      return true;
    } catch (e) {
      Get.snackbar(backgroundColor: Colors.red, 'Error', e.toString());
      return false;
    }
  }

  static Future<bool> deleteUserByIndex(String indexNo) async {
    try {
      final users = await _database.query('users');
      final List<Map<String, dynamic>> userList =
          users.cast<Map<String, dynamic>>();

      final indexExistsUsers =
          userList.any((user) => user['IndexNo'] == indexNo);

      final issuedBooks = await DBHelper.getIssuedbooks1();
      final List<String> indexNos =
          issuedBooks.map((book) => book['IndexNo'] as String).toList();
      final indexExistsIssued = indexNos.contains(indexNo);
      if (indexExistsUsers) {
        if (indexExistsIssued) {
          Get.snackbar(
              backgroundColor: Colors.red,
              'Error',
              'Cannot delete user has issued books');
          return false;
        } else {
          await _database
              .delete('users', where: 'IndexNo=?', whereArgs: [indexNo]);
          Get.snackbar(
              'Success', 'User with $indexNo successfully removed from users',
              backgroundColor: Colors.green);
          return true;
        }
      } else {
        Get.snackbar(
            backgroundColor: Colors.red, 'Error', 'Invalid Index Number');
        return false;
      }
    } catch (e) {
      Get.snackbar(backgroundColor: Colors.red, 'Error', '${e.toString()}');
      return false;
    }
  }

  static Future<bool> deleteBookByBookid(String bookId) async {
    try {
      final books = await _database.query('books');
      final List<Map<String, dynamic>> bookList =
          books.cast<Map<String, dynamic>>();

      final bookidExistsBooks =
          bookList.any((book) => book['Book_id'] == bookId);

      final issuedBooks = await DBHelper.getIssuedbooks1();
      final List<String> bookIds =
          issuedBooks.map((book) => book['Book_id'] as String).toList();
      final bookidExistsIssued = bookIds.contains(bookId);
      if (bookidExistsBooks) {
        if (bookidExistsIssued) {
          Get.snackbar(
              backgroundColor: Colors.red,
              'Error',
              'Cannot delete book is issued to a user');
          return false;
        } else {
          await _database
              .delete('books', where: 'Book_id=?', whereArgs: [bookId]);
          DBHelper.updateBookAvailability();
          Get.snackbar(
              backgroundColor: Colors.green,
              'Success',
              'User with $bookId successfully removed from books');
          return true;
        }
      } else {
        Get.snackbar(backgroundColor: Colors.red, 'Error', 'Invalid BookId');
        return false;
      }
    } catch (e) {
      Get.snackbar(backgroundColor: Colors.red, 'Error', '${e.toString()}');
      return false;
    }
  }
}
