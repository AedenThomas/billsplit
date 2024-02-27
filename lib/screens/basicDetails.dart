// ignore_for_file: prefer_const_constructors
import 'package:billSplit/screens/emailPage.dart';
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:flutter/material.dart';
import 'foodDetails.dart';
import 'dart:io';
import 'dart:convert';

class BasicDetailsPage extends StatefulWidget {
  const BasicDetailsPage({Key? key, required this.firebaseuid})
      : super(key: key);
  final String firebaseuid;

  @override
  State<BasicDetailsPage> createState() => BasicDetailsPageState();
}

class BasicDetailsPageState extends State<BasicDetailsPage> {
  final amtControllor = TextEditingController();
  final discControllor = TextEditingController();
  final taxControllor = TextEditingController();
  final serviceControllor = TextEditingController();
  final namesControllor = TextEditingController();

  List<String> descriptionValues = [];
  List<double> totalPrices = [];
  List nameList = [];
  // var _image;

  // cameraPage camera = cameraPage();
  // CameraPageState cameraPageState = cameraPage();

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
                  child: textTitle("Enter tax %", TextInputType.number),
                ),
                inputTextField(taxControllor,
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

        floatingActionButton: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              bottom: 20,
              right: 30,
              child: FloatingActionButton(
                onPressed: () {
                  print(taxControllor.text);
                  List nameList = [];
                  nameList = namesControllor.text.split(",");
                  // remove spaces from namesList
                  for (int i = 0; i < nameList.length; i++) {
                    nameList[i] = nameList[i].trim();
                  }
                  // print(widget);
                  // print(nameList);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmailPage(
                        amt: amtControllor.text,
                        // convert discount to integer
                        disc: double.parse(discControllor.text),
                        service: double.parse(serviceControllor.text),
                        namesList: nameList,
                        tax: double.parse(taxControllor.text),
                        amtControllor: amtControllor,
                        discControllor: discControllor,
                        serviceControllor: serviceControllor,
                        taxControllor: taxControllor,
                        firebaseuid: widget.firebaseuid,
                      ),
                    ),
                  );

                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => FoodDetails(
                  //       amt: amtControllor.text,
                  //       // convert discount to integer
                  //       disc: double.parse(discControllor.text),
                  //       service: double.parse(serviceControllor.text),
                  //       namesList: nameList,
                  //       tax: double.parse(taxControllor.text),
                  //     ),
                  //   ),
                  // );
                },
                // backgroundColor: Color.fromRGBO(193, 193, 193, 100),
                backgroundColor: Color.fromARGB(156, 81, 147, 238),
                child: const Icon(
                  Icons.arrow_right_alt,
                  size: 40,
                  // color: Colors.black,
                ),
              ),
            ),
            Positioned(
              left: 30,
              bottom: 20,
              child: FloatingActionButton(
                backgroundColor: Color.fromARGB(156, 81, 147, 238),
                onPressed: () async {
                  //  final File? image = await getImage();

                  //COMMENT STARTS

                  nameList = namesControllor.text.split(",");
                  // remove spaces from namesList
                  for (int i = 0; i < nameList.length; i++) {
                    nameList[i] = nameList[i].trim();
                  }

                  final File? image = await getImage();
                  setState(() {
                    File? _image;
                    _image = image;
                  });
                  //COMMENT ENDS
                },
                // child: Text('Select Image'),
                child: Icon(
                  Icons.camera_alt_rounded,
                ),
              ),
            ),
          ],
        ),

        //FOR STACKS 2 FAB
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        // floatingActionButton: Stack(
        // fit: StackFit.expand,
        // children: [
        // Positioned(
        //   left: 30,
        //   bottom: 20,
        //   child: FloatingActionButton(
        //     onPressed: () {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) => MyHomeCameraPage(),
        //         ),
        //       );
        //     },
        //     backgroundColor: Color.fromRGBO(193, 193, 193, 100),
        //     child: const Icon(
        //       Icons.arrow_right_alt,
        //       size: 40,
        //       color: Colors.black,
        //     ),
        //   ),
        // ),
        // Positioned(
        //   bottom: 20,
        //   right: 30,
        //   child: FloatingActionButton(
        //     onPressed: () {
        //       print(taxControllor.text);
        //       List nameList = [];
        //       nameList = namesControllor.text.split(",");
        //       // remove spaces from namesList
        //       for (int i = 0; i < nameList.length; i++) {
        //         nameList[i] = nameList[i].trim();
        //       }
        //       // print(widget);
        //       // print(nameList);
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) => FoodDetails(
        //             amt: amtControllor.text,
        //             // convert discount to integer
        //             disc: double.parse(discControllor.text),
        //             service: serviceControllor.text,
        //             namesList: nameList,
        //             tax: double.parse(taxControllor.text),
        //           ),
        //         ),
        //       );
        //     },
        //     backgroundColor: Color.fromRGBO(193, 193, 193, 100),
        //     child: const Icon(
        //       Icons.arrow_right_alt,
        //       size: 40,
        //       color: Colors.black,
        //     ),
        //   ),
        // )

        // ],
        // ),
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

  Future<String> uploadImageToFirebase(BuildContext context, File image) async {
    try {
      String uuid = Uuid().v1();
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
    var analyzeResult = responseJson['analyzeResult'];
    if (analyzeResult != null) {
      var documents = analyzeResult['documents'];
      if (documents != null && documents.length > 0) {
        var fields = documents[0]['fields'];
        if (fields != null) {
          var items = fields['Items'];
          if (items != null) {
            var valueArray = items['valueArray'];
            if (valueArray != null) {
              for (var item in valueArray) {
                var valueObject = item['valueObject'];
                if (valueObject != null) {
                  var description = valueObject['Description'];
                  if (description != null) {
                    var valueString = description['valueString'];
                    if (valueString != null) {
                      var desc = valueString;
                      desc = desc.replaceAll(RegExp(r'(?<=\w)\n(?=\w)'), ' ');

                      var price =
                          item['valueObject']['TotalPrice']['valueNumber'];
                      print('Description: $desc, Total Price: $totalPrices');
                      descriptionValues.add(desc);
                      price = price +
                          double.parse(taxControllor.text) / 100 * price +
                          double.parse(serviceControllor.text) / 100 * price;

                      totalPrices.add(price.toDouble());
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }

  Future<File?> getImage() async {
    // if (kIsWeb) {
    //   final ImagePicker picker = ImagePicker();
    //   final pickedFile =
    //       await picker.pickImage(source: ImageSource.gallery, imageQuality: 10);
    //   if (pickedFile != null) {
    //     showDialog(
    //       context: context,
    //       barrierDismissible: false,
    //       builder: (context) {
    //         return Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       },
    //     );
    //   }

    // final picker = ImagePicker();
    final ImagePicker picker = ImagePicker();

    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 10);

    if (pickedFile != null) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Center(
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
            amt: amtControllor.text,
            // convert discount to integer
            disc: double.parse(discControllor.text),
            service: double.parse(serviceControllor.text),
            namesList: nameList,
            tax: double.parse(taxControllor.text),
            descriptionValues: descriptionValues,
            totalPrices: totalPrices,
          ),
        ),
      );
    } else {
      throw Exception('No image selected.');
    }
    return null;
  }
}
// }


