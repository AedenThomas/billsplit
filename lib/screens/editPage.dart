import 'package:billSplit/screens/foodDetails.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:flutter/material.dart';

class editPage extends StatefulWidget {
  final Function callback;

  editPage(
      {super.key, required this.callback,
      required this.food,
      required this.namesList,
      this.uuid});
  // editPage({required this.food, required this.namesList});
  // editPage({this.callback});
  final List food;
  List<dynamic> namesList = [];
  final String? uuid;

  @override
  State<editPage> createState() => _editPageState();
}

class _editPageState extends State<editPage> {
  //  final amtControllor = TextEditingController();
  late TextEditingController amtControllor;
  late TextEditingController itemControllor;
  late TextEditingController qtyControllor;
  late TextEditingController eatenByControllor;
  late List<String> listOfNameThatHasEaten;
  final bool _pressed = false;

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
    listOfNameThatHasEaten.clear();
    print(listOfNameThatHasEaten);
  }

  void updateData() {
    widget.callback(Task(
        id: widget.uuid,
        cost: double.parse(amtControllor.text),
        name: itemControllor.text,
        qty: int.parse(qtyControllor.text),
        eatenBy: listOfNameThatHasEaten.join(', ')));
  }

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
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,

              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                  padding: const EdgeInsets.only(bottom: 90),
                  // child: inputTextField(eatenByControllor, TextInputType.text),
                  child:
                      // Iterate through listOfNameThatHasEaten and put each of them inside a clickable container. All the bubbles will be inside another parent container.

                      SizedBox(
                    height: 50,
                    child: ListView.builder(
                      padding: const EdgeInsets.only(left: 20),
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.namesList.first.length,
                      itemBuilder: (context, index) {
                        return Container(
                          // padding left of 10
                          margin: const EdgeInsets.only(right: 20),
                          child: InkWell(
                            onTap: () {
                              setState(
                                () {
                                  // if listOfNameThatHasEaten's first index is == "" then remove it
                                  // else add the name to listOfNameThatHasEaten

                                  listOfNameThatHasEaten
                                      .add(widget.namesList.first[index]);
                                  eatenByControllor.text =
                                      listOfNameThatHasEaten.join(',');
                                  print('eatenByControllor.text');
                                  print(eatenByControllor.text);
                                },
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(widget.namesList.first[index]),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black, backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                    onPressed: () {
                      print("Add button pressed");
                      print(listOfNameThatHasEaten);
                      setState(() {
                        updateData();
                        // Navigate back to foodDetails page and pass the new data to FoodCardTitle
                        Navigator.pop(
                          context,
                          Task(
                              id: widget.food.first.id,
                              cost: double.parse(amtControllor.text),
                              name: itemControllor.text,
                              qty: int.parse(qtyControllor.text),
                              eatenBy: listOfNameThatHasEaten.join(', ')),
                        );
                      });
                    },
                    child: const Text(
                      "Save",
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
            // listOfNameThatHasEaten
            // print(widget.namesList);
            // Print all the names in the widget.namesList
            for (var name in widget.namesList) {
              print(name);
            }

            // seperate the names in eatenBy and put them in a list of string
            // listOfNameThatHasEaten = eatenByControllor.text.split(",");
          },
          backgroundColor: const Color.fromRGBO(193, 193, 193, 100),
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
        textCapitalization: TextCapitalization.sentences,
        keyboardType: type,
        controller: control,
        style: const TextStyle(
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
      style: const TextStyle(
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
  IntegerExample({super.key, required this.qty});
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
