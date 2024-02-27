// ignore_for_file: file_names, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SplitPage extends StatefulWidget {
  SplitPage({super.key, 
    required this.amt,
    required this.disc,
    required this.service,
    required this.namesList,
    required this.foodDetails,
    required this.emailAddress,
    required this.flag,
  });

  final String amt;
  final double disc;
  final double service;
  final List namesList;
  final List foodDetails;
  final List emailAddress;
  bool flag;

  // final List foodEatenBy;

  @override
  State<SplitPage> createState() => _SplitPageState();
}

class _SplitPageState extends State<SplitPage> {
  final itemControllor = TextEditingController();
  final costControllor = TextEditingController();
  final qtyControllor = TextEditingController();
  final namesControllor = TextEditingController();
  late double costAfterDivison;
  double fullTotal = 0.0;
  double aFullTotal = 0.0;
  double totalCost = 0;
  int index = 0;
  int flag = 0;

  String? emailContent = '';

  List<double> totalCostArr = [];

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
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 90, 0, 0),
                child: Center(
                  child: Text(
                    "Splitted Bill",
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              for (var name in widget.namesList)
                Builder(
                  builder: (context) {
                    var totalAcc = 0.0;
                    var divided = 0.0;
                    var discountedamt = 0.0;
                    var serviceedamt = 0.0;

                    double serviceforamt = 0.0;
                    double discforamt = 0;
                    for (var food in widget.foodDetails) {
                      if (food.foodEatenBy.contains(name)) {
                        //if discount is applied and there is no service charge
                        if (widget.disc != 0 && widget.service == 0) {
                          totalAcc = (double.parse(food.foodTotalAfterTax
                              .toString()
                              .substring(
                                  1,
                                  food.foodTotalAfterTax.toString().length -
                                      1)));
                          divided = totalAcc / food.foodEatenBy.length;
                          discforamt =
                              divided - ((widget.disc / 100) * divided);
                          totalAcc = discforamt + discountedamt;
                          discountedamt = totalAcc;
                        } else if (widget.disc == 0 && widget.service != 0) {
                          totalAcc = (double.parse(food.foodTotalAfterTax
                              .toString()
                              .substring(
                                  1,
                                  food.foodTotalAfterTax.toString().length -
                                      1)));

                          divided = totalAcc / food.foodEatenBy.length;

                          // serviceforamt =
                          //     divided + ((widget.service / 100) * divided);
                          serviceforamt = divided;

                          totalAcc = serviceforamt + serviceedamt;

                          serviceedamt = totalAcc;
                        } else if (widget.disc != 0 && widget.service != 0) {
                          totalAcc = (double.parse(food.foodTotalAfterTax
                              .toString()
                              .substring(
                                  1,
                                  food.foodTotalAfterTax.toString().length -
                                      1)));
                          divided = totalAcc / food.foodEatenBy.length;
                          discforamt =
                              divided - ((widget.disc / 100) * divided);
                          totalAcc = discforamt + discountedamt;
                          discountedamt = totalAcc;
                        }
                        // else if (widget.disc != 0 && widget.service != 0) {
                        //   totalAcc = (double.parse(food.foodTotalAfterTax
                        //       .toString()
                        //       .substring(
                        //           1,
                        //           food.foodTotalAfterTax.toString().length -
                        //               1)));

                        //   divided = totalAcc / food.foodEatenBy.length;

                        //   serviceforamt =
                        //       divided + ((widget.service / 100) * divided);

                        //   totalAcc = serviceforamt + serviceedamt;

                        //   serviceedamt = totalAcc;

                        //   // divided = totalAcc / food.foodEatenBy.length;
                        //   discforamt = serviceedamt -
                        //       ((widget.disc / 100) * serviceedamt);
                        //   totalAcc = discforamt + discountedamt;
                        //   discountedamt = totalAcc;
                        // }
                        else {
                          totalAcc += (double.parse(food.foodTotalAfterTax
                                  .toString()
                                  .substring(
                                      1,
                                      food.foodTotalAfterTax.toString().length -
                                          1)) /
                              food.foodEatenBy.length);
                        }
                      }
                    }

                    final total = totalAcc.toStringAsFixed(2);

                    fullTotal += totalAcc;

                    //all the food details including name, description, fullTotal should be kept adding in emailContent

                    emailContent = "${"${emailContent!}Name: " +
                        name}\nTotal to be paid:$total\n";

                    for (var food in widget.foodDetails) {
                      if (food.foodEatenBy.contains(name)) {
                        if (widget.disc != 0) {
                          costAfterDivison = (double.parse(
                              food.foodTotalAfterTax.toString().substring(
                                  1,
                                  food.foodTotalAfterTax.toString().length -
                                      1)));
                          costAfterDivison = costAfterDivison -
                              (widget.disc / 100) * costAfterDivison;
                          costAfterDivison =
                              double.parse(costAfterDivison.toStringAsFixed(2));
                        } else {
                          costAfterDivison = double.parse((double.parse(food
                                      .foodTotalAfterTax
                                      .toString()
                                      .substring(
                                          1,
                                          food.foodTotalAfterTax
                                                  .toString()
                                                  .length -
                                              1)) /
                                  food.foodEatenBy.length)
                              .toStringAsFixed(2));
                        }
                        totalCost = totalCost + costAfterDivison;
                        totalCost = double.parse(totalCost.toStringAsFixed(2));

                        totalCostArr.add(totalCost);

                        // "${food.foodName.toString().substring(1, food.foodName.toString().length - 1)} : ${food.foodTotalAfterTax.toString().substring(1, food.foodTotalAfterTax.toString().length - 1)}/${food.foodEatenBy.length} = ${(double.parse(food.foodTotalAfterTax.toString().substring(1, food.foodTotalAfterTax.toString().length - 1)) / food.foodEatenBy.length).toStringAsFixed(2)}",
                        emailContent = "${emailContent!}${food.foodName.toString().substring(
                                1, food.foodName.toString().length - 1)} : ${food.foodTotalAfterTax.toString().substring(1,
                                food.foodTotalAfterTax.toString().length - 1)}/${food.foodEatenBy.length} = $costAfterDivison\n";
                      }
                    }
                    emailContent = "${emailContent!}\n";

                    return Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 5, top: 5, right: 10, left: 10),
                          child: Theme(
                            data: Theme.of(context)
                                .copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              title: Text(
                                name,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w900),
                              ),
                              trailing: Text(total),
                              children: <Widget>[
                                for (var food in widget.foodDetails)
                                  if (food.foodEatenBy.contains(name))
                                    description(food),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              // Button

              // FloatingActionButton(
              //   onPressed: () {
              //     setState(
              //       () {
              //         // Display total cost
              //         showDialog(
              //             context: context,
              //             builder: (BuildContext context) {
              //               return AlertDialog(
              //                 title: Text("Total Cost"),
              //                 content: Text(fullTotal.toStringAsFixed(2)),
              //                 actions: [
              //                   TextButton(
              //                     child: Text("OK"),
              //                     onPressed: () {
              //                       Navigator.of(context).pop();
              //                     },
              //                   ),
              //                 ],
              //               );
              //             });
              //       },
              //     );
              //   },
              // ),

              // FloatingActionButton(
              //   onPressed: () {
              //     sendMail();

              //     setState(
              //       () {
              //         // Display total cost
              //         showDialog(
              //           context: context,
              //           builder: (BuildContext context) {
              //             return AlertDialog(
              //               title: Text("Email Sent"),
              //               // emailAddress list should be the content of the dialog box
              //               // content: Text(widget.emailAddress.toString()+ emailContent!),
              //               content: Text(emailContent!),

              //               actions: [
              //                 TextButton(
              //                   child: Text("OK"),
              //                   onPressed: () {
              //                     Navigator.of(context).pop();
              //                   },
              //                 ),
              //               ],
              //             );
              //           },
              //         );
              //       },
              //     );
              //   },
              //   child: Icon(Icons.email),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  getTotalCost(String name) {
    totalCost = 0;
    for (var food in widget.foodDetails) {
      if (food.foodEatenBy.contains(name)) {
        totalCost += double.parse(food.foodTotalAfterTax);
      }
    }
    totalCost = double.parse(totalCost.toStringAsFixed(2));
    return Text(totalCost.toString());
  }

  Text description(food) {
    if (widget.disc != 0) {
      costAfterDivison = (double.parse(food.foodTotalAfterTax
          .toString()
          .substring(1, food.foodTotalAfterTax.toString().length - 1)));
      costAfterDivison =
          costAfterDivison - (widget.disc / 100) * costAfterDivison;
      costAfterDivison = double.parse(costAfterDivison.toStringAsFixed(2));
    } else {
      costAfterDivison = double.parse((double.parse(food.foodTotalAfterTax
                  .toString()
                  .substring(1, food.foodTotalAfterTax.toString().length - 1)) /
              food.foodEatenBy.length)
          .toStringAsFixed(2));
    }
    totalCost = totalCost + costAfterDivison;
    totalCost = double.parse(totalCost.toStringAsFixed(2));

    totalCostArr.add(totalCost);
    // food.foodTotalAfterTax =
    //     double.parse(food.foodTotalAfterTax.toStringAsFixed(2));

    return Text(
      "${food.foodName.toString().substring(1, food.foodName.toString().length - 1)} : ${food.foodTotalAfterTax.toString().substring(1, food.foodTotalAfterTax.toString().length - 1)}/${food.foodEatenBy.length} = ${(double.parse(food.foodTotalAfterTax.toString().substring(1, food.foodTotalAfterTax.toString().length - 1)) / food.foodEatenBy.length).toStringAsFixed(2)}",
      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
    );
  }

  Padding inputTextField(double h, double w) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
      child: SizedBox(
        height: h,
        width: w,
        child: TextField(
          style: TextStyle(
              color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40.0),
            ),
            filled: true,
            fillColor: Color.fromRGBO(76, 76, 76, 100),
          ),
        ),
      ),
    );
  }

  // Future<void> sendMail() async {
  //   final headers = {
  //     'X-RapidAPI-Host': 'rapidprod-sendgrid-v1.p.rapidapi.com',
  //     'X-RapidAPI-Key': '5fc03fac83mshe561e8326a3d37cp129385jsnd8ba87c70c67',
  //     'content-type': 'application/json',
  //   };

  //   // store emailContent in a variable called content after removing every new line
  //   String content = emailContent!.replaceAll("\n", " ");

  //   final data =
  //       '{\n    "personalizations": [\n        {\n            "to": [\n                {\n                    "email": "aedengeo@gmail.com"\n                }\n            ],\n            "subject": "Bill Details!"\n        }\n    ],\n    "from": {\n        "email": "aedengeo@gmail.com"\n    },\n    "content": [\n        {\n            "type": "text/plain",\n            "value": "$content"\n        }\n    ]\n}';
  //   final url =
  //       Uri.parse('https://rapidprod-sendgrid-v1.p.rapidapi.com/mail/send');

  //   final res = await http.post(url, headers: headers, body: data);
  //   final status = res.statusCode;
  //   print("Body");
  //   print(res.body);
  //   if (status != 200) throw Exception('http.post error: statusCode= $status');
  // }

  Future<void> sendMail() async {
    final headers = {
      'Authorization': 'Bearer re_aTN4Aivb_8tyw3BsQrsp11sFnwCn3qzNz',
      'Content-Type': 'application/json',
    };

    // emailContent = emailContent!.replaceAll("\n", " ");
    final data = jsonEncode({
      "from": "support@aedenthomas.me",
      "to": "resend.broom545@8alias.com",
      "subject": "Splitted Bill Details",
      "html":
          "<p>Congrats on splitting your <strong>bill</strong>!</p> <p>Here are the details:</p> <p>Bill Total: $totalCost</p> <p>Bill Details:</p><pre>$emailContent</pre><p>Thank you for using <strong>Billify</strong>!</p>"
    });

    final url = Uri.parse('https://api.resend.com/emails');

    final res = await http.post(url, headers: headers, body: data);
    final status = res.statusCode;
    print(res.body);
    if (status != 200) throw Exception('http.post error: statusCode= $status');
  }
}
