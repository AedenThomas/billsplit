// ignore_for_file: prefer_const_constructors

import 'package:billSplit/screens/previousBillPage.dart';
import 'package:flutter/material.dart';
import 'basicDetails.dart';

class MyHomePage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  // MyHomePage({required this.title, }) : super();
  const MyHomePage({superKey, Key? key, required this.firebaseuid, required this.title});

  final String title;
  final String firebaseuid;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final nameControllor = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromRGBO(76, 81, 195, 100),
            Color.fromRGBO(7, 7, 7, 100)
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // appBar: AppBar(
        //   title: Text(widget.title),
        // ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
              //   child: Center(
              //     child: CircleAvatar(
              //       radius: 100.0,
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 100, 40, 0),
                child: Text(
                  'Easy way to share bill',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 100, 500),
                child: Text('Easy to share bills with your friends and anyone',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w200,
                      fontStyle: FontStyle.italic,
                    )),
              ),

              // Padding(
              //   padding: const EdgeInsets.only(left: 150, top: 150),
              //   child: TextButton(
              //     child: Text(
              //       "Get Started",
              //       style: TextStyle(fontSize: 30),
              //     ),
              //     style: ButtonStyle(
              //         padding: MaterialStateProperty.all<EdgeInsets>(
              //             EdgeInsets.all(15)),
              //         foregroundColor:
              //             MaterialStateProperty.all<Color>(Colors.black),
              //         backgroundColor:
              //             MaterialStateProperty.all<Color>(Colors.white),
              //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              //             RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.circular(50.0),
              //                 side: BorderSide(color: Colors.white)))),
              //     onPressed: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => BasicDetailsPage()),
              //       );
              //     },
              //   ),
              // ),

              // Two buttons. One on left. One on right
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child: TextButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.all(15)),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                      side: BorderSide(color: Colors.white)))),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PreviousBillPage(
                                    firebaseuid: widget.firebaseuid,
                                  )),
                        );
                      },
                      child: Text(
                        "View Previous Bills",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                    child: TextButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.all(15)),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                      side: BorderSide(color: Colors.white)))),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BasicDetailsPage(
                                    firebaseuid: widget.firebaseuid,
                                  )),
                        );
                      },
                      child: Text(
                        "Get Started",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
