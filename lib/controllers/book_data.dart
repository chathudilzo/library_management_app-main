import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter/material.dart';
import 'package:google_books_api/google_books_api.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class BookInfo extends StatefulWidget {
  const BookInfo({Key? key}) : super(key: key);

  @override
  State<BookInfo> createState() => _BookInfoState();
}

class _BookInfoState extends State<BookInfo> {
  late Timer _timer = Timer(Duration.zero, () {});
  late List<Book> _books = [];
  int _currentIndex = 0;
  late Map<String, Uri> _images = {};
  bool _isLoading = true;
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;
  bool _hasFetchedBooks = false;
  bool _hasInternetConnection = false;

  Future<void> _getBooks(List<String> categories) async {
    final String query = categories.join(" OR ");
    try {
      final List<Book> books = await GoogleBooksApi().searchBooks(
        query,
        maxResults: 40,
        printType: PrintType.books,
        orderBy: OrderBy.relevance,
      );
      setState(() {
        _books = books;
        // print(_books.length);
        _isLoading = false;
        _hasFetchedBooks = true;
      });
    } catch (e) {
      //print('Error fetching books $e');

      _isLoading = true;
    }
  }

  @override
  void initState() {
    super.initState();
    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen((result) {
      print(result);
      if (!_hasFetchedBooks &&
          (result == ConnectivityResult.wifi ||
              result == ConnectivityResult.mobile)) {
        // Internet connection is available, and books haven't been fetched yet
        _getBooks([
          'science',
          'history',
          'geography',
          'mathematics',
          'fiction',
          'business',
          'self-help',
          'biography',
          'art',
          'technology'
        ]);

        // Set the flag to true
      }
      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        _hasInternetConnection = true;
      } else {
        _hasInternetConnection = false;
      }
    });

    _timer = Timer.periodic(Duration(seconds: 20), (timer) {
      //print('starting index: $_currentIndex');
      if (_books.isNotEmpty && !_isLoading) {
        setState(() {
          // Increase the index by 1
          _currentIndex = (_currentIndex + 1) % _books.length;
          //_images = _books[_currentIndex].volumeInfo.imageLinks ?? {};
          Uri defaultImageAsset = Uri.parse('assets/back1.jpg');
          _images = _books[_currentIndex].volumeInfo.imageLinks ??
              {'thumbnail': defaultImageAsset};

          //print(_images);
          // print(_currentIndex);
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _connectivitySubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double availableHeight = height / 1.5 - 10 - 250 - 5 - 2 - 5;
    return Container(
      width: width / 3.5,
      height: height / 1.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(blurRadius: 8, spreadRadius: 7)],
      ),
      child: _isLoading
          ? Container(
              padding: const EdgeInsets.only(left: 15, right: 15),
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(blurRadius: 7, spreadRadius: 3)],
                color: Color.fromARGB(255, 29, 28, 28),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Book Recommender',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.amberAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.blueAccent,
                      size: 100,
                    ),
                  ),
                  Text(
                    'Waiting For Internet Connection',
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
            )
          : Container(
              padding: const EdgeInsets.only(left: 15, right: 15),
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(blurRadius: 7)],
                borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(134, 12, 5, 40),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 8,
                              spreadRadius: 3,
                              offset: Offset(1, 3),
                            ),
                          ],
                        ),
                        child: _hasInternetConnection
                            ? (_images['thumbnail'] != null)
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      _images['thumbnail'].toString() +
                                          '?${DateTime.now().millisecondsSinceEpoch}',
                                      width: 200,
                                      height: 250,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Center(
                                          child: Container(
                                            width: 200,
                                            height: 250,
                                            child: LoadingAnimationWidget
                                                .fourRotatingDots(
                                              color: Color.fromARGB(
                                                  255, 33, 166, 243),
                                              size: 100,
                                            ),
                                          ),
                                        );
                                      },
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return Center(
                                          child: LoadingAnimationWidget
                                              .newtonCradle(
                                            color: Colors.orange,
                                            size: 100,
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                : Center(
                                    child: Container(
                                      width: 200,
                                      height: 250,
                                      child: Column(
                                        children: [
                                          Center(
                                            child: Container(
                                              width: 152,
                                              height: 210,
                                              child: LoadingAnimationWidget
                                                  .dotsTriangle(
                                                color: Color.fromARGB(
                                                    255, 7, 206, 100),
                                                size: 50,
                                              ),
                                            ),
                                          ),
                                          Text(
                                              'Check your internet connection'),
                                        ],
                                      ),
                                    ),
                                  )
                            : Center(
                                child: Container(
                                  width: 200,
                                  height: 250,
                                  child: Column(
                                    children: [
                                      Center(
                                        child: Container(
                                          width: 152,
                                          height: 210,
                                          child: LoadingAnimationWidget
                                              .dotsTriangle(
                                            color: Color.fromARGB(
                                                255, 7, 206, 100),
                                            size: 50,
                                          ),
                                        ),
                                      ),
                                      Text('Check your internet connection'),
                                    ],
                                  ),
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      _books[_currentIndex].volumeInfo.title ?? '',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Color.fromARGB(255, 208, 223, 6),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      _books[_currentIndex].volumeInfo.authors?.join(", ") ??
                          '',
                      style:
                          TextStyle(color: Color.fromARGB(255, 13, 192, 183)),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Description:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color.fromARGB(255, 146, 4, 115),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      _books[_currentIndex]
                              .volumeInfo
                              .description
                              ?.replaceAll(RegExp('<[^>]*>'), '') ??
                          '',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Categories:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color.fromARGB(255, 129, 21, 2),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      _books[_currentIndex].volumeInfo.categories?.join(", ") ??
                          '',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Publisher:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color.fromARGB(255, 117, 3, 3),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      _books[_currentIndex].volumeInfo.publisher ?? '',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Published Date:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color.fromARGB(255, 105, 2, 2),
                      ),
                    ),
                    // SizedBox(height: 5),
                    //  Text(
                    //    _books[_currentIndex].volumeInfo.publishedDate!,
                    //    style: TextStyle(color: Colors.white),
                    //  ),
                    SizedBox(height: 10),
                    Text(
                      'Page Count:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color.fromARGB(255, 112, 3, 3),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      _books[_currentIndex].volumeInfo.pageCount?.toString() ??
                          '',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: availableHeight),
                  ],
                ),
              ),
            ),
    );
  }
}



 // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   // Check if the current route is the admin page
  //   final isAdminPage = ModalRoute.of(context)?.settings.name == '/admin';
  //   print('changed');
  //   // Start or stop the timer based on whether the current route is the admin page
  //   if (isAdminPage) {
  //     _startTimer();
  //   } else {
  //     _stopTimer();
  //   }
  // }

  // void _startTimer() {
  //   _timer.cancel();
  //   _timer = Timer.periodic(Duration(seconds: 20), (timer) {
  //     print('starting index: $_currentIndex');
  //     if (_books.isNotEmpty && !_isLoading) {
  //       setState(() {
  //         // Increase the index by 1
  //         _currentIndex = (_currentIndex + 1) % _books.length;
  //         _images = _books[_currentIndex].volumeInfo.imageLinks ?? {};

  //         print(_images);
  //         print(_currentIndex);
  //       });
  //     }
  //   });
  // }

  // void _stopTimer() {
  //   _timer.cancel();
  // }