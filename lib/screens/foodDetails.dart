// ignore_for_file: prefer_const_constructors

import 'package:billSplit/screens/editPage.dart';
import 'package:flutter/material.dart';
import 'splitPage.dart';

class NameClass extends StatelessWidget {
  List<String> foodName = [];
  List<double> foodPrice = [];
  List<int> foodQuantity = [];
  List<double> foodTotalAfterTax = [];
  List<String> foodEatenBy = [];
  NameClass(
      {this.foodName,
      this.foodPrice,
      this.foodQuantity,
      this.foodTotalAfterTax,
      this.foodEatenBy});

  @override
  Widget build(BuildContext context) {}
}

class FoodDetails extends StatefulWidget {
  FoodDetails({this.amt, this.disc, this.service, this.namesList});

  final String amt;
  final double disc;
  final String service;
  final List namesList;

  @override
  State<FoodDetails> createState() => FoodDetailsState();
}

class FoodDetailsState extends State<FoodDetails> {
  List<Task> names = [];
  final itemControllor = TextEditingController();
  final costControllor = TextEditingController();
  final qtyControllor = TextEditingController();
  final namesControllor = TextEditingController();
  List<String> listOfNameThatHasEaten = [];

  List nameClassList = [];

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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Center(
                child: Text(
                  "Food Details",
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            Container(
              height: 500,
              child: ListView.builder(
                itemCount: names.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    direction: DismissDirection.endToStart,
                    background: Container(
                      decoration: BoxDecoration(),
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      height: 10,
                      alignment: Alignment.centerRight,
                    ),
                    key: Key(names[index].name),
                    onDismissed: (direction) {
                      nameClassList.removeAt(index);
                      setState(() {
                        names.removeAt(index);
                      });
                    },
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  // pass names[index] to EditPage
                                  editPage(
                                    food: [
                                      names[index],
                                    ],
                                    namesList: [
                                      widget.namesList,
                                    ],
                                  )),
                        );
                      },
                      child: FoodCardTitle(
                        cost: names[index].cost,
                        item: names[index].name,
                        qty: names[index].qty,
                        eatenBy: [names[index].eatenBy],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              left: 30,
              bottom: 20,
              child: FloatingActionButton(
                backgroundColor: Color.fromRGBO(193, 193, 193, 100),
                onPressed: () {
                  // showDialog(
                  //   context: context,
                  //   builder: (BuildContext context) {
                  //     return AlertDialog(
                  //       title: Text('Error'),
                  //       content: Text('Please enter all the details'),
                  //       actions: [
                  //         TextButton(
                  //           onPressed: () {
                  //             Navigator.of(context).pop();
                  //           },
                  //           child: Text('OK'),
                  //         ),
                  //       ],
                  //     );
                  //   },
                  // );
                  itemControllor.clear();
                  costControllor.clear();
                  qtyControllor.clear();

                  listOfNameThatHasEaten.clear();

                  bool _pressed = false;

                  showModalBottomSheet<void>(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40.0),
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color.fromRGBO(12, 0, 245, 100),
                                Color.fromRGBO(86, 61, 209, 100),
                              ]),
                        ),
                        child: SingleChildScrollView(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 20,
                                ),
                              ),
                              Text(
                                'Name of Item',
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Color.fromRGBO(255, 255, 255, 100),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              inputTextField(
                                  45, 500, itemControllor, TextInputType.text),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'Cost',
                                        style: TextStyle(
                                          fontSize: 24,
                                          color: Color.fromRGBO(
                                              255, 255, 255, 100),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      inputTextField(45, 160, costControllor,
                                          TextInputType.numberWithOptions(decimal: true)),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'Quantity',
                                        style: TextStyle(
                                          fontSize: 24,
                                          color: Color.fromRGBO(
                                              255, 255, 255, 100),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      inputTextField(45, 160, qtyControllor,
                                          TextInputType.number),
                                    ],
                                  ),
                                ],
                              ),
                              Text(
                                'Eaten by',
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Color.fromRGBO(255, 255, 255, 100),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 20,
                                ),
                              ),
                              Wrap(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                      top: 12,
                                      bottom: 12,
                                    ),
                                    width: 380,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40.0),
                                      gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          Color.fromARGB(235, 69, 62, 194),
                                          Color.fromARGB(235, 62, 45, 146),
                                        ],
                                      ),
                                    ),
                                    child: Wrap(
                                      children: [
                                        for (var name in widget.namesList)
                                          Material(
                                            color:
                                                Color(Colors.transparent.value),
                                            child: InkWell(
                                              splashColor: Colors.blueAccent,
                                              onTap: () {
                                                setState(
                                                  () {
                                                    _pressed = !_pressed;
                                                    if (listOfNameThatHasEaten
                                                        .contains(name)) {
                                                      listOfNameThatHasEaten
                                                          .remove(name);
                                                    } else {
                                                      listOfNameThatHasEaten
                                                          .add(name);
                                                    }
                                                  },
                                                );
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 10, 10, 10),
                                                child: FittedBox(
                                                  fit: BoxFit.fitWidth,
                                                  child: Container(
                                                    padding: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40.0),
                                                      color: Color.fromRGBO(
                                                          193, 193, 193, 100),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10,
                                                              right: 10,
                                                              top: 5,
                                                              bottom: 5),
                                                      child: Center(
                                                        child: Text(
                                                          name,
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  
                                  // If quantity is empty, set it to 1
                                  if (qtyControllor.text == '') {
                                    qtyControllor.text = '1';
                                  }
                                  // If quantity is empty, show a dialog box
                                  

                                  double finalAmt;
                                  finalAmt = double.parse(costControllor.text) +
                                      0.05 * double.parse(costControllor.text);
                                  String name =
                                      listOfNameThatHasEaten.toString();
                                  name = name.substring(1, name.length - 1);

                                  setState(
                                    () {
                                      Navigator.pop(context);

                                      nameClassList.add(NameClass(
                                        foodName: [itemControllor.text],
                                        foodPrice: [
                                          double.parse(costControllor.text)
                                        ],
                                        foodQuantity: [
                                          int.parse(qtyControllor.text)
                                        ],
                                        foodTotalAfterTax: [finalAmt],
                                        foodEatenBy: name.split(", "),
                                      ));

                                      for (var name in nameClassList) {}
                                      names.add(
                                        Task(
                                          name: itemControllor.text,
                                          qty: int.parse(qtyControllor.text),
                                          cost:
                                              double.parse(finalAmt.toString()),
                                          eatenBy: name,
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Icon(Icons.done, color: Colors.white),
                                style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.all(20),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 35),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: const Icon(
                  Icons.add,
                  size: 40,
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              right: 30,
              child: FloatingActionButton(
                backgroundColor: Color.fromRGBO(193, 193, 193, 100),
                heroTag: 'next',
                onPressed: () {
                  for (var name in widget.namesList) {}

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SplitPage(
                        amt: widget.amt,
                        namesList: widget.namesList,
                        disc: widget.disc,
                        service: int.parse(widget.service),
                        foodDetails: nameClassList,
                      ),
                    ),
                  );
                },
                child: const Icon(
                  Icons.arrow_right,
                  size: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding inputTextField(
    double h,
    double w,
    TextEditingController control,
    TextInputType type,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
      child: SizedBox(
        height: h,
        width: w,
        child: TextField(
          textCapitalization: TextCapitalization.sentences,
          keyboardType: type,
          controller: control,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10),
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

class FoodCardTitle extends StatelessWidget {
  final String item;
  final double cost;
  final int qty;
  final List<String> eatenBy;
  FoodCardTitle({this.item, this.cost, this.qty, this.eatenBy});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5, top: 5, right: 10, left: 10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 5, bottom: 5),
          child: ExpansionTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    item,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                  ),
                ),
                Text(
                  '$cost',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            children: <Widget>[
              Text(
                'Quantity: $qty',
                style: TextStyle(fontSize: 20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var name in eatenBy)
                    if (eatenBy.indexOf(name) == eatenBy.length - 1)
                      Text(
                        name,
                        style: TextStyle(fontSize: 20),
                      )
                    else
                      Text(
                        name + ', ',
                        style: TextStyle(fontSize: 20),
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

class Task {
  final String name;
  final double cost;
  final int qty;
  final String eatenBy;
  Task({this.name, this.cost, this.qty, this.eatenBy});
}
