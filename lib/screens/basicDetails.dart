// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'foodDetails.dart';

class BasicDetailsPage extends StatefulWidget {
  // BasicDetailsPage({this.})

  @override
  State<BasicDetailsPage> createState() => BasicDetailsPageState();
}

final _formKey = GlobalKey<FormState>();

class BasicDetailsPageState extends State<BasicDetailsPage> {
  final amtControllor = TextEditingController();
  final discControllor = TextEditingController();
  final serviceControllor = TextEditingController();
  final namesControllor = TextEditingController();

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
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Center(
                    child: Text(
                      "Basic Details",
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
                // Form(
                //   key: _formKey,
                //   child: Padding(
                //     padding: const EdgeInsets.fromLTRB(30, 50, 40, 0),
                //     child:
                //         textTitle("Enter the total amount", TextInputType.text),
                //   ),
                // ),
                // inputTextField(amtControllor, TextInputType.number),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 40, 40, 0),
                  child: textTitle(
                      "Enter the discount percent", TextInputType.number),
                ),
                inputTextField(discControllor,
                    TextInputType.numberWithOptions(decimal: true)),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 40, 0),
                  child:
                      textTitle("Enter Service Charge %", TextInputType.number),
                ),
                inputTextField(serviceControllor,
                    TextInputType.numberWithOptions(decimal: true)),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 40, 0),
                  child: textTitle("Enter Names", TextInputType.text),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 90),
                  child: inputTextField(namesControllor, TextInputType.text),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            List nameList = [];
            nameList = namesControllor.text.split(",");
            // remove spaces from namesList
            for (int i = 0; i < nameList.length; i++) {
              nameList[i] = nameList[i].trim();
            }
            // print(widget);
            print(nameList);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FoodDetails(
                  amt: amtControllor.text,
                  // convert discount to integer
                  disc: double.parse(discControllor.text),
                  service: serviceControllor.text,
                  namesList: nameList,
                ),
              ),
            );
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
    //seperate the names inputed by comma and store in a list
    //then pass the list to the next page
  }

  Padding inputTextField(TextEditingController control, TextInputType type) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
      child: TextFormField(
        
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
