import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:library_pc/controllers/book_data.dart';
import 'package:library_pc/controllers/db_helper.dart';
import 'package:library_pc/pages/add_book.dart';
import 'package:library_pc/pages/calculator_page.dart';
import 'package:library_pc/pages/issued_books.dart';
import 'package:library_pc/pages/meet_dev.dart';
import 'package:library_pc/pages/pie_chart.dart';
import 'package:library_pc/pages/pie_chart_wid.dart';
import 'package:library_pc/pages/profile.dart';
import 'package:library_pc/pages/register_user.dart';
import 'package:library_pc/pages/return_book.dart';
import 'package:library_pc/pages/send_email.dart';
import 'package:library_pc/pages/view_book_page.dart';
import 'package:library_pc/pages/view_users.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:library_pc/pages/bar_chart.dart';

import 'controllers/day_chart.dart';
import 'pages/issue_book.dart';
import 'pages/transactionpage.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  bool _showImages = false;
  int _imageIndex = 0;
  late Timer _timer;

  bool _isMeetDevHovers = false;
  bool _isMailHoverd = false;
  bool _isProfileHoverd = false;
  bool _isThemeHoverd = false;

  List<String> _backgroundImages = [
    'assets/back1.jpg',
    'assets/back2.jpg',
    'assets/back3.jpg',
    'assets/back4.jpg',
    'assets/back5.jpg',
    'assets/micro.jpg'
  ];

  List<int> _bookAvailableData = [0, 0, 0];
  int available = 0;
  int total = 0;
  int checked = 0;

  Future<void> getData() async {
    final bookAvailableData = await DBHelper.getBookAvailabilityInfo();
    //print(bookAvailableData);
    setState(() {
      _bookAvailableData = bookAvailableData;
      available = bookAvailableData[0];
      total = bookAvailableData[1];
      checked = bookAvailableData[2];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Start the timer that will change the background image every 10 seconds
    _timer = Timer.periodic(Duration(seconds: 10), (Timer timer) {
      setState(() {
        _imageIndex = (_imageIndex + 1) % _backgroundImages.length;
      });
    });
    getData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getData();
  }

  @override
  void dispose() {
    _timer
        .cancel(); // Cancel the timer to prevent calling setState() after dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    List<Widget> _backgroundWidgets = _backgroundImages.map((image) {
      int index = _backgroundImages.indexOf(image);
      return AnimatedOpacity(
        duration: Duration(seconds: 5),
        opacity: _showImages ? (_imageIndex == index ? 1.0 : 0.0) : 1.0,
        child: Container(
          decoration: BoxDecoration(
            color: _showImages ? null : Color.fromARGB(255, 12, 10, 44),
            image: _showImages
                ? DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  )
                : DecorationImage(
                    image: AssetImage('assets/368311.jpg'), fit: BoxFit.cover),
          ),
          child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(top: 0),
              child: Column(
                children: [
                  Container(
                    child: Row(
                      children: [
                        RichText(
                            text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: 'Libra',
                              style: TextStyle(
                                  fontSize: 28,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue)),
                          TextSpan(
                            text: 'Ease',
                            style: TextStyle(
                              //fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color.fromARGB(255, 243, 173, 33),
                            ),
                          )
                        ])),
                        Expanded(child: Container()),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          onEnter: (_) {
                            setState(() {
                              _isMailHoverd = true;
                            });
                          },
                          onExit: (_) {
                            setState(() {
                              _isMailHoverd = false;
                            });
                          },
                          child: GestureDetector(
                              onTap: () {
                                Get.to(() => SendMail());
                              },
                              child: Center(
                                  child: Container(
                                decoration: _isMailHoverd
                                    ? BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.blue,
                                                width: 2.0)))
                                    : null,
                                child: Text(
                                  ' Send Email ',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 72, 75, 73),
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.bold),
                                ),
                              ))),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          onEnter: (_) {
                            setState(() {
                              _isThemeHoverd = true;
                            });
                          },
                          onExit: (_) {
                            setState(() {
                              _isThemeHoverd = false;
                            });
                          },
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _showImages = !_showImages;
                              });
                            },
                            child: Center(
                              child: Container(
                                decoration: _isThemeHoverd
                                    ? BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.blue,
                                                width: 2.0)))
                                    : null,
                                child: Text(
                                  _showImages
                                      ? ' Disable Theme '
                                      : ' Enable Theme ',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 72, 75, 73),
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          onEnter: (_) {
                            setState(() {
                              _isProfileHoverd = true;
                            });
                          },
                          onExit: (_) {
                            setState(() {
                              _isProfileHoverd = false;
                            });
                          },
                          child: GestureDetector(
                              onTap: () {
                                Get.to(() => ProfileSetting());
                              },
                              child: Row(
                                children: [
                                  Container(
                                    decoration: _isProfileHoverd
                                        ? BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.blue,
                                                    width: 2.0)))
                                        : null,
                                    child: Text(
                                      ' Profile ',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 72, 75, 73),
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              )),
                        ),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          onEnter: (_) {
                            setState(() {
                              _isMeetDevHovers = true;
                            });
                          },
                          onExit: (_) {
                            setState(() {
                              _isMeetDevHovers = false;
                            });
                          },
                          child: GestureDetector(
                              onTap: () {
                                Get.to(() => MeetDev());
                              },
                              child: Container(
                                decoration: _isMeetDevHovers
                                    ? BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.blue,
                                                width: 2.0)))
                                    : null,
                                child: Text(
                                  '  Meet Developers 🚀',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 72, 75, 73),
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: width / 5,
                        height: height * 0.9,
                        padding: const EdgeInsets.only(top: 12),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(blurRadius: 7, spreadRadius: 5)
                            ],
                            color: Color.fromARGB(133, 36, 32, 32),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 5,
                                      color: Color.fromARGB(255, 109, 0, 212)),
                                  borderRadius: BorderRadius.circular(500),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/original-641e2d4320e1f0f08db05cacdcf8fed2.gif'),
                                      fit: BoxFit.cover)),
                            ),
                            // Container(
                            //     height: height * 0.05,
                            //     decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.circular(5)),
                            //     child: Container(
                            //       decoration: BoxDecoration(
                            //         image: DecorationImage(
                            //             image: AssetImage(
                            //                 'assets/Untitled design-fotor-bg-remover-20230517131915.png')),
                            //       ),
                            //     )
                            //     // child: Text('LM System',
                            //     //     style: GoogleFonts.lato(
                            //     //       color: Color.fromARGB(255, 101, 39, 227),
                            //     //       fontSize: 30,
                            //     //       fontWeight: FontWeight.w700,
                            //     //       fontStyle: FontStyle.italic,
                            //     //     )),
                            //     ),
                            Container(
                              width: width / 5,
                              height: height * 0.5,
                              padding: const EdgeInsets.only(top: 12),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(blurRadius: 7, spreadRadius: 5)
                                  ],
                                  color: Color.fromARGB(133, 94, 105, 109),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  CardButton(
                                    width: width,
                                    height: height,
                                    text: 'View Books',
                                    widget: Container(child: ViewBooks()),
                                  ),
                                  CardButton(
                                    width: width,
                                    height: height,
                                    text: 'View Users',
                                    widget: Container(child: ViewUsers()),
                                  ),
                                  CardButton(
                                    width: width,
                                    height: height,
                                    text: 'Issued Books',
                                    widget: Container(child: IssuedBooks()),
                                  ),
                                  CardButton(
                                    width: width,
                                    height: height,
                                    text: 'Issue Book',
                                    widget: Container(child: IssueBook()),
                                  ),
                                  CardButton(
                                    width: width,
                                    height: height,
                                    text: 'Add Book',
                                    widget: Container(child: AddBook()),
                                  ),
                                  CardButton(
                                    width: width,
                                    height: height,
                                    text: 'Register User',
                                    widget: Container(child: RegisterUser()),
                                  ),
                                  CardButton(
                                    width: width,
                                    height: height,
                                    text: 'Return Book',
                                    widget: Container(child: ReturnBook()),
                                  ),
                                  CardButton(
                                    width: width,
                                    height: height,
                                    text: 'Transactions',
                                    widget: Container(
                                      child: TransChart(),
                                    ),
                                  ),
                                  CardButton(
                                    width: width,
                                    height: height,
                                    text: 'Calculator',
                                    widget: Container(child: CalculatorPage()),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: height * 0.9,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              width: width / 4,
                              height: height * 0.4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(blurRadius: 9, spreadRadius: 5)
                                ],
                                color: Color.fromARGB(255, 14, 16, 17),
                              ),
                              child: PieChartScreen(),
                            ),
                            Text(
                              'Book Summary',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 116, 112, 118),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                                padding: const EdgeInsets.all(10),
                                width: width / 4,
                                height: height * 0.42,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(blurRadius: 7, spreadRadius: 5)
                                    ],
                                    borderRadius:
                                        BorderRadiusDirectional.circular(20),
                                    color: Color.fromARGB(255, 20, 20, 20)),
                                child: BarChartWid()),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 20),
                        child: BookInfo(),
                      ),
                    ],
                  ),
                ],
              )),
        ),
      );
    }).toList();
    return Scaffold(body: Stack(children: _backgroundWidgets));
  }

  // GestureDetector Card_button(
  //     double width, double height, String text, Color color, Widget widget) {
  //   return GestureDetector(
  //     onTap: () {
  //       Get.to(() => widget);
  //     },
  //     child: Container(
  //       width: width * 0.2,
  //       height: height * 0.2,
  //       child: Center(
  //           child: Text(
  //         text,
  //         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  //       )),
  //       decoration: BoxDecoration(
  //           color: color, borderRadius: BorderRadius.circular(10)),
  //     ),
  //   );
  // }
}

class CardButton extends StatefulWidget {
  final double width;
  final double height;
  final String text;
  final Widget widget;

  CardButton({
    required this.width,
    required this.height,
    required this.text,
    required this.widget,
  });

  @override
  _CardButtonState createState() => _CardButtonState();
}

class _CardButtonState extends State<CardButton> {
  late List<Color> _colors;
  late int _index;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _colors = _getRandomColors(10);
    _index = 0;
    _timer = Timer.periodic(Duration(seconds: 15), (_) {
      setState(() {
        _index = (_index + 1) % _colors.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  List<Color> _getRandomColors(int count) {
    final random = Random();
    final primaries = Colors.primaries.toList()..shuffle(random);
    return List.generate(
        count,
        (_) =>
            primaries[random.nextInt(primaries.length)] as Color? ??
            Colors.black);
  }

  @override
  Widget build(BuildContext context) {
    final colorTween = ColorTween(
        begin: _colors[_index], end: _colors[(_index + 1) % _colors.length]);
    bool _isHovering = false;
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => widget.widget));
        },
        child: Container(
          decoration: BoxDecoration(
            color: _isHovering ? Colors.blue : null,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: _isHovering ? Colors.grey : Colors.transparent,
                blurRadius: 3,
                offset: Offset(1, 1),
              ),
            ],
          ),
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            width: 200,
            height: widget.height * 0.04,
            child: Center(
              child: Text(
                widget.text,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(blurRadius: 8, spreadRadius: 3)],
              gradient: LinearGradient(
                colors: [
                  colorTween.begin!.withOpacity(0.5),
                  colorTween.end!.withOpacity(0.5),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ),
    );
  }
}
