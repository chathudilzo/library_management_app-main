import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_pc/admin_page.dart';
import 'package:library_pc/controllers/db_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  late List<Map<String, dynamic>> _admins;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadAdminCredentials();
  }

  Future<void> loadAdminCredentials() async {
    _admins = await DBHelper.getAdmins();
  }

  Future<void> login(String username, String password) async {
    //Get.snackbar('details', '$_admins');
    // if (_admins.isEmpty) {
    //   SharedPreferences prefs = await SharedPreferences.getInstance();

    //   await prefs.setString('session_token', 'token_here');
    //   Get.offAll(() => AdminPage());
    //   return;
    // }
    for (final admin in _admins) {
      // Get.snackbar('details', '${admin['username']} ${admin['password']}');

      if (admin['username'] == username && admin['password'] == password) {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        await prefs.setString('session_token', 'token_here');
        Get.offAll(() => AdminPage());
        Get.snackbar('Login Successfull', 'You have successfully logged in.',
            backgroundColor: Colors.green);
        return;
      }

      Get.snackbar('Login Failed', 'Invalid username or password!',
          backgroundColor: Colors.red);
    }
  }
}
