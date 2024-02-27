
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class PreviousBillPage extends StatefulWidget {
  const PreviousBillPage({Key? key, required this.firebaseuid})
      : super(key: key);

  final String firebaseuid;

  @override
  _PreviousBillPageState createState() => _PreviousBillPageState();
}

class _PreviousBillPageState extends State<PreviousBillPage> {
  List<String> _imageUrls = [];
  bool _isLoading = false;

  // call refresh when initstate
  @override
  void initState() {
    super.initState();
    _refreshImages();
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
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 90, 0, 0),
              child: Center(
                child: Text(
                  "Previous Bills",
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            _isLoading
                ? const CircularProgressIndicator()
                : Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemCount: _imageUrls.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () async {
                              // print the url of the image
                              print(_imageUrls[index]);
                            },
                            child: Ink.image(
                              image: NetworkImage(_imageUrls[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Future<void> _refreshImages() async {
    setState(() {
      _isLoading = true;
    });
    ListResult result =
        await FirebaseStorage.instance.ref(widget.firebaseuid).listAll();
    List<String> urls =
        await Future.wait(result.items.map((ref) => ref.getDownloadURL()));
    setState(() {
      _imageUrls = urls;
      _isLoading = false;
    });
  }
}
