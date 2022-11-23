import 'package:numberpicker/numberpicker.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class editPage extends StatefulWidget {
  editPage({this.food, this.namesList});
  final List food;
  List<dynamic> namesList = [];

  @override
  State<editPage> createState() => _editPageState();
}

class _editPageState extends State<editPage> {
  //  final amtControllor = TextEditingController();
  TextEditingController amtControllor;
  TextEditingController itemControllor;
  TextEditingController qtyControllor;
  TextEditingController eatenByControllor;
  List<String> listOfNameThatHasEaten;
  bool _pressed = false;

  @override
  void initState() {
    super.initState();
    amtControllor =
        TextEditingController(text: widget.food.first.cost.toString());
    itemControllor =
        TextEditingController(text: widget.food.first.name.toString());
    qtyControllor =
        TextEditingController(text: widget.food.first.qty.toString());
    eatenByControllor =
        TextEditingController(text: widget.food.first.eatenBy.toString());
    listOfNameThatHasEaten = widget.food.first.eatenBy.split(',');
  }

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
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,

              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Center(
                    child: Text(
                      "Edit Food",
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
                Form(
                  // key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 50, 40, 0),
                    child:
                        textTitle("Enter the name of item", TextInputType.text),
                  ),
                ),
                inputTextField(itemControllor, TextInputType.number),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 40, 0),
                  child: textTitle("Cost", TextInputType.number),
                ),
                inputTextField(amtControllor, TextInputType.number),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 40, 0),
                  child: textTitle("Quantity", TextInputType.number),
                ),
                inputTextField(qtyControllor, TextInputType.number),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 40, 0),
                  child: textTitle("Eaten by", TextInputType.text),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 90),
                  // child: inputTextField(eatenByControllor, TextInputType.text),
                  child:
                      // Iterate through listOfNameThatHasEaten and put each of them inside a clickable container. All the bubbles will be inside another parent container.

                      Container(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: listOfNameThatHasEaten.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(right: 20),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                // Show a bottom sheet
                                // Modal bottom sheet should contain the name of the currently selected person
                                // Below that there should be the number 0
                                // Left of it there should be a minus button
                                // Right of it there should be a plus button

                                // When the plus button is pressed, the number should increase by 1
                                // When the minus button is pressed, the number should decrease by 1
                                int _currentHorizontalIntValue = 10;

                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        height: 200,
                                        child: Column(
                                          children: [
                                            Text(listOfNameThatHasEaten[index]),
                                            IntegerExample(
                                                qty: widget.food.first.qty),
                                            Container(
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  // Update the number in the database
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    });
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(listOfNameThatHasEaten[index]),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                // Put each name from widget.food.first.eatenBy inside a bubble
                for (var name in listOfNameThatHasEaten)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: Text(
                          name,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ),
                Container(
                  height: 50,
                  width: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _pressed = !_pressed;
                      });
                    },
                    child: Text(
                      "Add",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print(widget.food.first.name);
            print(widget.food.first.cost);
            print(widget.food.first.qty);
            print(widget.food.first.eatenBy);
            // seperate the names in eatenBy and put them in a list of string
            // listOfNameThatHasEaten = eatenByControllor.text.split(",");
          },
          backgroundColor: Color.fromRGBO(193, 193, 193, 100),
          child: const Icon(
            Icons.arrow_right_alt,
            size: 40,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Padding inputTextField(TextEditingController control, TextInputType type) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
      child: TextFormField(
        validator: (val) {
          return val.isEmpty ? 'please provide a valid value' : null;
        },
        textCapitalization: TextCapitalization.sentences,
        keyboardType: type,
        controller: control,
        style: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Text textTitle(String text, TextInputType type) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
          fontSize: 25,
          color: Colors.white,
          fontStyle: FontStyle.normal),
    );
  }
}

class IntegerExample extends StatefulWidget {
  int qty;
  IntegerExample({this.qty});
  @override
  IntegerExampleState createState() => IntegerExampleState();
}

class IntegerExampleState extends State<IntegerExample> {
  int _currentValue = 0;
  int qtyForThisPerson = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NumberPicker(
          axis: Axis.horizontal,
          value: qtyForThisPerson,
          minValue: 0,
          maxValue: widget.qty,
          onChanged: (value) => setState(() {
            _currentValue = value;
            qtyForThisPerson = value;
          }),
        ),
        Text('Current value: $_currentValue'),
      ],
    );
  }
}
