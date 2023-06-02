import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_pc/admin_page.dart';
import 'package:library_pc/controllers/db_helper.dart';
import 'package:library_pc/controllers/load_csv.dart';
import 'package:library_pc/controllers/pie_chart_controller.dart';
import 'package:library_pc/pages/log_in_page.dart';
import 'dart:io';
import 'package:window_size/window_size.dart';

import 'controllers/bar_chart_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.init();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('LibraEase 1.0');

    setWindowMinSize(const Size(1000, 1000));
  }

  Get.put(BarChartController());
  Get.put(PieChartController());
  //final admins = await loadloginData('assets/admin.csv');
  //final users = await loadUserCsvData('assets/Users.csv');
  //final books = await loadBooksCsvData('assets/Books.csv');
  //final issuedBooks = await loadIssuedBooksData('assets/Issuedbooks.csv');

  //await DBHelper.insertAdmin(admins);
  //await DBHelper.insertUsers(users);
  //await DBHelper.insertBooks(books);
  //await DBHelper.insertIssuedBooks(issuedBooks);
  await DBHelper.updateBookAvailability();
  await DBHelper.dateDataSetup();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'LibraEase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color.fromARGB(255, 25, 24, 24),
      ),
      home: LoginPage(),
      routes: {'/admin': (context) => AdminPage()},
    );
  }
}
