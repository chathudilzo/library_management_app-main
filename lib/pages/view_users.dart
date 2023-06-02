import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_pc/pages/update_user_page.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../admin_page.dart';
import '../controllers/db_helper.dart';
import 'issued_books.dart';
import 'profile.dart';
import 'view_book_page.dart';

class ViewUsers extends StatefulWidget {
  const ViewUsers({Key? key}) : super(key: key);

  @override
  _ViewUsersState createState() => _ViewUsersState();
}

class _ViewUsersState extends State<ViewUsers> {
  Future<void> _reloadUserData() async {
    await _loadUserData();
  }

  late List<Map<String, dynamic>> _users = [];
  List<Map<String, dynamic>> _filteredUsers = [];
  bool _isLoading = true;
  bool _isEmpty = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final users = await DBHelper.getUsers();
    //print(users);
    setState(() {
      _users = users;
      _filteredUsers = users;
      _isLoading = false;
      if (_filteredUsers.length > 0) {
        _isEmpty = false;
      }
    });
  }

//IndexNo,FullName,Class,Address,Parent_or_Guardian,charges,lastUpdatedDate
  void _filterUsers(String query) {
    setState(() {
      _filteredUsers = _users.where((user) {
        final userIndex = user['IndexNo'].toLowerCase();
        final fullName = user['FullName'].toLowerCase();
        final classn = user['Class'].toLowerCase();
        final address = user['Address'].toLowerCase();
        final guard = user['Parent_or_Guardian'].toLowerCase();
        final cahrg = user['charges'].toLowerCase();
        final email = user['Email'].toLowerCase();
        final tp = user['TP'].toLowerCase();
        return userIndex.contains(query.toLowerCase()) ||
            fullName.contains(query.toLowerCase()) ||
            classn.contains(query.toLowerCase()) ||
            address.contains(query.toLowerCase()) ||
            guard.contains(query.toLowerCase()) ||
            cahrg.contains(query.toLowerCase()) ||
            email.contains(query.toLowerCase()) ||
            tp.contains(query.toLowerCase());
      }).toList();
      if (_filteredUsers.length > 0) {
        _isEmpty = false;
      } else {
        _isEmpty = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
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
      body: _users == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/1_gf-RT3N6-ACDUENNPRi_RQ.png'),
                      fit: BoxFit.cover)),
              child: Container(
                width: width * 0.8,
                height: height,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 224, 224, 232).withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, top: 20, bottom: 20),
                      width: width * 0.3,
                      decoration: BoxDecoration(
                          boxShadow: [BoxShadow(blurRadius: 7)],
                          color: Color.fromARGB(255, 28, 125, 181),
                          borderRadius: BorderRadius.circular(20)),
                      child: TextField(
                          onChanged: (query) => _filterUsers(query),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              hintText: 'Search Users',
                              prefixIcon: Icon(Icons.search))),
                    ),
                    Container(
                      width: width * 0.95,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'IndexNo',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'FullName',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Class',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Address',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Guardian',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'charges',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Email',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Tp-Number',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Update',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Delete',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: _isLoading
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
                                      Text(
                                        'No data to show',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(
                                  width: width * 0.95,
                                  child: ListView.builder(
                                      itemCount: _filteredUsers.length,
                                      itemBuilder: (context, index) {
                                        final user = _filteredUsers[index];
                                        print(user['IndexNo']);
                                        return Container(
                                            height: height * 0.08,
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            margin: const EdgeInsets.only(
                                                bottom: 10),
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                    colors: [
                                                      Color.fromARGB(
                                                          255, 71, 71, 72),
                                                      Color.fromARGB(
                                                          255, 21, 84, 135)
                                                    ]),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Expanded(
                                                    child: Text(user['IndexNo']
                                                        .toString()),
                                                  ),
                                                  Expanded(
                                                    child: Text(user['FullName']
                                                        .toString()),
                                                  ),
                                                  Expanded(
                                                    child: Text(user['Class']
                                                        .toString()),
                                                  ),
                                                  Expanded(
                                                    child: Text(user['Address']
                                                        .toString()),
                                                  ),
                                                  Expanded(
                                                    child: Text(user[
                                                            'Parent_or_Guardian']
                                                        .toString()),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                        '      ${user['charges'].toString()}'),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                        '      ${user['Email'].toString()}'),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                        '      ${user['TP'].toString()}'),
                                                  ),
                                                  Expanded(
                                                      child: ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  backgroundColor:
                                                                      Color.fromARGB(
                                                                          255,
                                                                          60,
                                                                          60,
                                                                          58)),
                                                          child: Text('Update'),
                                                          onPressed: () =>
                                                              Get.to(() =>
                                                                  UpdateUser(
                                                                    IndexNo: user[
                                                                            'IndexNo']
                                                                        .toString(),
                                                                    FullName: user[
                                                                            'FullName']
                                                                        .toString(),
                                                                    Class: user[
                                                                            'Class']
                                                                        .toString(),
                                                                    Address: user[
                                                                            'Address']
                                                                        .toString(),
                                                                    Guardian: user[
                                                                            'Parent_or_Guardian']
                                                                        .toString(),
                                                                    Charges: user[
                                                                            'charges']
                                                                        .toString(),
                                                                    email: user[
                                                                            'Email']
                                                                        .toString(),
                                                                    tp: user[
                                                                            'TP']
                                                                        .toString(),
                                                                  )))),
                                                  Expanded(
                                                      child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                Color.fromARGB(
                                                                    255,
                                                                    151,
                                                                    19,
                                                                    10)),
                                                    onPressed: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              title: Text(
                                                                  'Confirm user delete'),
                                                              content: Text(
                                                                  'Do you want to delete user ${user['IndexNo']} from users'),
                                                              actions: [
                                                                ElevatedButton(
                                                                    onPressed:
                                                                        () async {
                                                                      final res =
                                                                          await DBHelper.deleteUserByIndex(
                                                                              user['IndexNo']);
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();

                                                                      _loadUserData();
                                                                    },
                                                                    child: Text(
                                                                        'Yes')),
                                                                ElevatedButton(
                                                                    onPressed:
                                                                        () async {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                    child: Text(
                                                                        'No')),
                                                              ],
                                                            );
                                                          });
                                                    },
                                                    child: Text('Delete'),
                                                  ))
                                                ]));
                                      })),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
