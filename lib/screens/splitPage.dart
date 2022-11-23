// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';

class SplitPage extends StatefulWidget {
  SplitPage(
      {this.amt,
      this.disc,
      this.service,
      this.namesList,
      this.foodDetails,
      this.foodEatenBy});
  final String amt;
  final double disc;
  final int service;
  final List namesList;
  final List foodDetails;
  final List foodEatenBy;

  @override
  State<SplitPage> createState() => _SplitPageState();
}

class _SplitPageState extends State<SplitPage> {
  final itemControllor = TextEditingController();
  final costControllor = TextEditingController();
  final qtyControllor = TextEditingController();
  final namesControllor = TextEditingController();
  double costAfterDivison;
  double fullTotal = 0.0;
  double aFullTotal = 0.0;
  num totalCost = 0;
  int index = 0;

  List<double> totalCostArr = [];

  // @protected
  // @override
  // void setState(VoidCallback fn) {
  //   // TODO: implement setState
  //   super.setState(fn);
  //   Text(
  //     fullTotal.toStringAsFixed(2),
  //     style: TextStyle(
  //       fontSize: 40,
  //       color: Colors.white,
  //       fontWeight: FontWeight.w900,
  //     ),
  //   );
  // }

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
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
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

                          serviceforamt =
                              divided + ((widget.service / 100) * divided);

                          totalAcc = serviceforamt + serviceedamt;

                          serviceedamt = totalAcc;

                          //now calculate discount

                        } else if (widget.disc != 0 && widget.service != 0) {
                          totalAcc = (double.parse(food.foodTotalAfterTax
                              .toString()
                              .substring(
                                  1,
                                  food.foodTotalAfterTax.toString().length -
                                      1)));

                          divided = totalAcc / food.foodEatenBy.length;

                          serviceforamt =
                              divided + ((widget.service / 100) * divided);

                          totalAcc = serviceforamt + serviceedamt;

                          serviceedamt = totalAcc;

                          // divided = totalAcc / food.foodEatenBy.length;
                          discforamt = serviceedamt -
                              ((widget.disc / 100) * serviceedamt);
                          totalAcc = discforamt + discountedamt;
                          discountedamt = totalAcc;
                        } else {
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
                              children: <Widget>[
                                for (var food in widget.foodDetails)
                                  if (food.foodEatenBy.contains(name))
                                    description(food),
                              ],
                              trailing: Text(total),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              // Button
              FloatingActionButton(onPressed: () {
                setState(() {
                  // Display total cost
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Total Cost"),
                          content: Text(fullTotal.toStringAsFixed(2)),
                          actions: [
                            TextButton(
                              child: Text("OK"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      });
                });
              })
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
    return Text(totalCost.toString());
  }

  Padding description(food) {
    if (widget.disc != 0) {
      costAfterDivison = (double.parse(food.foodTotalAfterTax
          .toString()
          .substring(1, food.foodTotalAfterTax.toString().length - 1)));
      costAfterDivison =
          costAfterDivison - (widget.disc / 100) * costAfterDivison;
    } else {
      costAfterDivison = double.parse((double.parse(food.foodTotalAfterTax
                  .toString()
                  .substring(1, food.foodTotalAfterTax.toString().length - 1)) /
              food.foodEatenBy.length)
          .toStringAsFixed(2));
    }
    totalCost = totalCost + costAfterDivison;

    totalCostArr.add(totalCost);

    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Text(
        food.foodName
                .toString()
                .substring(1, food.foodName.toString().length - 1) +
            " : " +
            food.foodTotalAfterTax
                .toString()
                .substring(1, food.foodTotalAfterTax.toString().length - 1) +
            "/" +
            food.foodEatenBy.length.toString() +
            " = " +
            (double.parse(food.foodTotalAfterTax.toString().substring(
                        1, food.foodTotalAfterTax.toString().length - 1)) /
                    food.foodEatenBy.length)
                .toStringAsFixed(2),
        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
      ),
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
}
