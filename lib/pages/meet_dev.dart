import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MeetDev extends StatelessWidget {
  const MeetDev({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Meet Developers'),
      ),
      body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color.fromARGB(255, 89, 4, 135), Colors.blueAccent])),
        child: Center(
            child: Container(
          padding: const EdgeInsets.all(15),
          width: width * 0.75,
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(blurRadius: 7)],
              borderRadius: BorderRadius.circular(10),
              color: Color.fromARGB(255, 80, 80, 80)),
          height: height * 0.8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                    boxShadow: [BoxShadow(blurRadius: 7)],
                    image: DecorationImage(
                        image: AssetImage('assets/profile1.jpg'),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 0, 0, 0)),
                width: width * 0.35,
                height: height * 0.8,
              ),
              Container(
                width: width * 0.3,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    boxShadow: [BoxShadow(blurRadius: 7)],
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(colors: [
                      Color.fromARGB(255, 15, 15, 15),
                      Color.fromARGB(255, 112, 43, 10)
                    ])),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('HELLO EVERYONE, I AM'),
                    Text(
                      'CHATHURA DILSHAN',
                      style: TextStyle(fontSize: 50),
                    ),
                    Text(
                        'Welcome to LibraEase, a Flutter-based app designed to streamline and manage the internal processes of your library. Our goal is to provide you with a user-friendly interface and efficient tools to enhance your library operations. With LibraEase, you can easily handle tasks such as book management, user tracking, and more.Currently, our app leverages the power of Flutter and SQL to deliver a seamless experience. However, we are continuously working on expanding its functionalities to meet your evolving needs. We are dedicated to enhancing LibraEase with new features and improvements in the near future, ensuring that it remains a valuable asset for your library.If you have any questions or need assistance with anything related to LibraEase, feel free to ask. We are here to help!Happy managing and organizing your library with LibraEase!'),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            width: width * 0.03,
                            height: height * 0.05,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/flutter-logo-removebg-preview.png'),
                                  fit: BoxFit.cover),
                            )),
                        Container(
                            width: width * 0.03,
                            height: height * 0.05,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/sqllogo-removebg-preview.png'),
                                  fit: BoxFit.cover),
                            )),
                        Container(
                            width: width * 0.03,
                            height: height * 0.05,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/gmail_new_logo_icon_159149.png'),
                                  fit: BoxFit.cover),
                            )),
                        Container(
                            width: width * 0.03,
                            height: height * 0.05,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/git.png'),
                                  fit: BoxFit.cover),
                            ))
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
