import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:billSplit/screens/foodDetails.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class EmailPage extends StatefulWidget {
  EmailPage({
    super.key,
    required this.amt,
    required this.disc,
    required this.service,
    required this.namesList,
    required this.tax,
    this.descriptionValues = const [],
    this.totalPrices = const [],
    required this.amtControllor,
    required this.discControllor,
    required this.serviceControllor,
    required this.taxControllor,
    required this.firebaseuid,
  });

  List<String> descriptionValues = [];
  List<double> totalPrices = [];

  final TextEditingController amtControllor;
  final TextEditingController discControllor;
  final TextEditingController serviceControllor;
  final TextEditingController taxControllor;

  final String firebaseuid;

  final String amt;
  final double disc;
  final double tax;
  final double service;
  final List namesList;

  @override
  State<EmailPage> createState() => EmailPageState();
}

class EmailPageState extends State<EmailPage> {
  // Define a list to store the email controllers
  List<TextEditingController> emailControllers = [];
  List<String> descriptionValues = [];
  var _image;
  List<String> emailList = [];
  List<double> totalPrices = [];
  @override
  Widget build(BuildContext context) {
    // will take each name from namesList, and a textbox should be there to enter the email address of that person
    // gradient background color
    // Color.fromRGBO(76, 81, 195, 100),
    //       Color.fromRGBO(7, 7, 7, 100)
    for (int i = 0; i < widget.namesList.length; i++) {
      emailControllers.add(TextEditingController());
    }

    // Create emailList to be equal to the length of namesList
    for (int i = 0; i < widget.namesList.length; i++) {
      emailList.add('');
    }

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
              children: <Widget>[
                const SizedBox(height: 50),
                const Text(
                  'Enter Email Addresses',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: 300,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.namesList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: <Widget>[
                          Text(
                            widget.namesList[index],
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          // TextFormField which I can use to enter the email ids of each name, and save it in a list
                          Focus(
                            // onFocusChange: (hasFocus) {
                            //   if (hasFocus) {
                            //     emailList.add(
                            //         emailControllers[index].text.toString());
                            //   }
                            // },
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Email ID',
                                border: OutlineInputBorder(),
                              ),
                              controller: emailControllers[index],
                              onEditingComplete: () {
                                // emailList.add(emailControllers[index].text);
                                emailList[index] = emailControllers[index].text;
                              },
                            ),
                          ),

                          const SizedBox(height: 20),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Stack(
          fit: StackFit.expand,
          children: [
            //next
            Positioned(
              bottom: 20,
              right: 30,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FoodDetails(
                                amt: widget.amt,
                                disc: widget.disc,
                                service: widget.service,
                                namesList: widget.namesList,
                                tax: widget.tax,
                                // send email addresses to next page
                                emailAddresses: emailList,
                              )));
                },
                backgroundColor: const Color.fromARGB(156, 81, 147, 238),
                child: const Icon(Icons.arrow_forward),
              ),
            ),

            //camera
            Positioned(
              left: 30,
              bottom: 20,
              child: FloatingActionButton(
                backgroundColor: const Color.fromARGB(156, 81, 147, 238),
                onPressed: () async {
                  //  final File? image = await getImage();

                  //COMMENT STARTS

                  final File? image = await getImage();
                  setState(() {
                    _image = image;
                  });
                  //COMMENT ENDS
                },
                // child: Text('Select Image'),
                child: const Icon(
                  Icons.camera_alt_rounded,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<File?> getImage() async {
    final ImagePicker picker = ImagePicker();

    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 10);

    if (pickedFile != null) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );
      String url = await uploadImageToFirebase(context, File(pickedFile.path));
      await Future.wait([sendRequest(url)]);
      Navigator.of(context).pop();
      Navigator.push(
        context,
        //                 ),
        MaterialPageRoute(
          builder: (context) => FoodDetails(
            amt: widget.amtControllor.text,
            // convert discount to integer
            disc: double.parse(widget.discControllor.text),
            service: double.parse(widget.serviceControllor.text),
            namesList: widget.namesList,
            tax: double.parse(widget.taxControllor.text),
            descriptionValues: descriptionValues,
            totalPrices: totalPrices,
            emailAddresses: emailList,
          ),
        ),
      );
    } else {
      throw Exception('No image selected.');
    }
    return null;
  }

  Future<String> uploadImageToFirebase(BuildContext context, File image) async {
    try {
      String uuid = const Uuid().v1();
//       Reference firebaseStorageRef =
// FirebaseStorage.instance.ref().child('uploads/$uuid.jpg');
      Reference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child('${widget.firebaseuid}/$uuid.jpg');

      UploadTask uploadTask = firebaseStorageRef.putFile(image);
      TaskSnapshot taskSnapshot = await uploadTask;
      String url = await taskSnapshot.ref.getDownloadURL();
      return url;
    } catch (error) {
      print('Error uploading file: $error');
      return '';
    }
  }

  Future<void> sendRequest(String urlC) async {
    String urlofImage = urlC;
    var headers = {
      'Content-Type': 'application/json',
      'Ocp-Apim-Subscription-Key': Platform.environment['API_KEY'] ?? '',
    };

    var params = {
      'api-version': '2022-08-31',
    };
    var query = params.entries.map((p) => '${p.key}=${p.value}').join('&');

    // var data =
    //     '{\'urlSource\': \'https://raw.githubusercontent.com/Azure-Samples/cognitive-services-REST-api-samples/master/curl/form-recognizer/rest-api/receipt.png\'}';
    // var data =
    //     '{\'urlSource\': \'https://ucarecdn.com/a1fba672-7470-4254-9a39-3a2730729e0d/PHOTO20221210135001.jpg\'}';
    var data = '{\'urlSource\': \'$urlofImage\'}';

    var url = Uri.parse(
        'https://centralindia.api.cognitive.microsoft.com/formrecognizer/documentModels/prebuilt-receipt:analyze?$query');
    var res = await http.post(url, headers: headers, body: data);
    print(res.body);

    // Get the operation-location from the POST response
    var operationLocation = res.headers['operation-location'];

    // Wait for the analysis to complete
    http.Response getResponse;
    do {
      // Replace {operation-location} with the URL provided in the operation-location header
      // getResponse = await http.get(operationLocation, headers: headers);

      if (operationLocation == null) {
        getResponse =
            await http.get(Uri.parse(operationLocation!), headers: headers);
      } else {
        getResponse =
            await http.get(Uri.parse(operationLocation), headers: headers);
      }
      if (getResponse.statusCode != 200) {
        throw Exception(
            'http.get error: statusCode= ${getResponse.statusCode}');
      }
    } while (getResponse.body.contains('"status":"running"'));

    // Print the response
    print(getResponse.body);

    var responseJson = json.decode(getResponse.body);
    var itemsArray = responseJson['analyzeResult']['documents'][0]['fields']
        ['Items']['valueArray'];

    for (var item in itemsArray) {
      var desc = item['valueObject']['Description']['valueString'];
      desc = desc.replaceAll(RegExp(r'(?<=\w)\n(?=\w)'), ' ');

      var price = item['valueObject']['TotalPrice']['valueNumber'];
      // print('Description: $desc, Total Price: $totalPrices');
      descriptionValues.add(desc);
      // after adding tax and service charge

      // make sure that both widget.taxControllor and widget.serviceControllor are not null before using them

      double tax = double.parse(widget.taxControllor.text) / 100 * price;
      double service =
          double.parse(widget.serviceControllor.text) / 100 * price;
      price = price + tax + service;

      // price = price +
      //     double.parse(widget.taxControllor!.text) / 100 * price ?? 0
      //       double.parse(widget.serviceControllor!.text) / 100 * price;

      totalPrices.add(price.toDouble());
    }
  }
}
