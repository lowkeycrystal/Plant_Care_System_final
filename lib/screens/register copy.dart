import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:plant_care_system/screens/success.dart';
import 'package:plant_care_system/shared/constant.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(const RegisterCOPY());
}

class RegisterCOPY extends StatelessWidget {
  const RegisterCOPY({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 229, 242, 201),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          iconTheme:
              const IconThemeData(color: Color.fromARGB(255, 199, 217, 137)),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Are sure to close page?'),
                  content: const Text(
                      'You will lose any data you input once you close this page.'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigator.pop(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => const MyApp()),
                        // );

                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      },
                      child: const Text('Close'),
                    ),
                  ],
                ),
              ),
            )
          ],
          backgroundColor: Colors.transparent,
          bottomOpacity: 0.0,
          title: const Text('Register New Plant',
              style: TextStyle(
                color: Color.fromARGB(255, 18, 64, 38),
                fontWeight: FontWeight.bold,
              )),
          elevation: 0,
        ),
        body: const MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  bool hasInternet = false;
  bool _isLoading = false;

  var docID = '';
  var MINTEMP = 0.00;
  var MAXTEMP = 0.00;
  var MINLUX = 0;
  var MAXLUX = 0;
  var MINHUM = 0;
  var MAXHUM = 0;
  var MINMST = 0;
  var MAXMST = 0;
  final _formKey = GlobalKey<FormState>();
  String pnforward = '';
  String pidforward = '';

// This will set the text value
  final TextEditingController _MINTEMP = TextEditingController();
  final TextEditingController _MINLUX = TextEditingController();
  final TextEditingController _MINMST = TextEditingController();
  final TextEditingController _MINHUM = TextEditingController();
  final TextEditingController _MAXTEMP = TextEditingController();
  final TextEditingController _MAXLUX = TextEditingController();
  final TextEditingController _MAXMST = TextEditingController();
  final TextEditingController _MAXHUM = TextEditingController();
  @override
  Widget build(BuildContext context) {
    CollectionReference SPECIES =
        FirebaseFirestore.instance.collection('SPECIES');
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
//Plant Name
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 10, 32, 0),
                child: Row(children: [
                  Expanded(
                    child: Container(
                        margin: const EdgeInsets.only(left: 0.0, right: 10.0),
                        child: const Divider(
                          color: Color.fromARGB(221, 83, 83, 83),
                          height: 20,
                        )),
                  ),
                  const Text(
                    "Plant Details",
                    style: TextStyle(
                        color: Color.fromARGB(221, 83, 83, 83),
                        fontSize: 15,
                        fontFamily: 'AvenirLight'),
                  ),
                  Expanded(
                    child: Container(
                        margin: const EdgeInsets.only(left: 10.0, right: 0.0),
                        child: const Divider(
                          color: Color.fromARGB(221, 83, 83, 83),
                          height: 20,
                        )),
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 15, 32, 10),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field cannot be empty';
                    }
                    return null;
                  },
                  decoration: textInputDecoration.copyWith(
                    labelText: 'SPECIE NAME',
                    hintText: 'ex. Plant 1, Anthurium 1, etc...',
                  ),
                  style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 17,
                      fontFamily: 'AvenirLight'),
                  onChanged: (value) {
                    docID = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 15, 32, 10),
                child: TextFormField(
                  controller: _MINTEMP,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field cannot be empty';
                    }
                    return null;
                  },
                  decoration: textInputDecoration.copyWith(
                    labelText: 'MINTEMP',
                  ),
                  style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 17,
                      fontFamily: 'AvenirLight'),
                  onChanged: (value) {
                    MINTEMP = double.parse(value);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 15, 32, 10),
                child: TextFormField(
                  controller: _MAXTEMP,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field cannot be empty';
                    }
                    return null;
                  },
                  decoration: textInputDecoration.copyWith(
                    labelText: 'MAXTEMP',
                  ),
                  style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 17,
                      fontFamily: 'AvenirLight'),
                  onChanged: (value) {
                    MAXTEMP = double.parse(value);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 15, 32, 10),
                child: TextFormField(
                  controller: _MINLUX,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field cannot be empty';
                    }
                    return null;
                  },
                  decoration: textInputDecoration.copyWith(
                    labelText: 'MINLUX',
                  ),
                  style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 17,
                      fontFamily: 'AvenirLight'),
                  onChanged: (value) {
                    MINLUX = int.parse(value);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 15, 32, 10),
                child: TextFormField(
                  controller: _MAXLUX,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field cannot be empty';
                    }
                    return null;
                  },
                  decoration: textInputDecoration.copyWith(
                    labelText: 'MAXLUX',
                  ),
                  style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 17,
                      fontFamily: 'AvenirLight'),
                  onChanged: (value) {
                    MAXLUX = int.parse(value);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 15, 32, 10),
                child: TextFormField(
                  controller: _MINHUM,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field cannot be empty';
                    }
                    return null;
                  },
                  decoration: textInputDecoration.copyWith(
                    labelText: 'MINHUM',
                  ),
                  style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 17,
                      fontFamily: 'AvenirLight'),
                  onChanged: (value) {
                    MINHUM = int.parse(value);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 15, 32, 10),
                child: TextFormField(
                  controller: _MAXHUM,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field cannot be empty';
                    }
                    return null;
                  },
                  decoration: textInputDecoration.copyWith(
                    labelText: 'MAXHUM',
                  ),
                  style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 17,
                      fontFamily: 'AvenirLight'),
                  onChanged: (value) {
                    MAXHUM = int.parse(value);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 15, 32, 10),
                child: TextFormField(
                  controller: _MINMST,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field cannot be empty';
                    }
                    return null;
                  },
                  decoration: textInputDecoration.copyWith(
                    labelText: 'MINMST',
                  ),
                  style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 17,
                      fontFamily: 'AvenirLight'),
                  onChanged: (value) {
                    MINMST = int.parse(value);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 15, 32, 10),
                child: TextFormField(
                  controller: _MAXMST,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field cannot be empty';
                    }
                    return null;
                  },
                  decoration: textInputDecoration.copyWith(
                    labelText: 'MAXMST',
                  ),
                  style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 17,
                      fontFamily: 'AvenirLight'),
                  onChanged: (value) {
                    MAXMST = int.parse(value);
                  },
                ),
              ),

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16.0),
                child: Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        onPrimary: const Color.fromARGB(255, 199, 217, 137),
                        primary: const Color.fromARGB(255, 18, 64, 38),
                        elevation: 20,
                        minimumSize: const Size(410, 70),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      onPressed: () async {
                        hasInternet =
                            await InternetConnectionChecker().hasConnection;

                        setState(() {});
                        if (_formKey.currentState!.validate()) {
                          //add to database
                          SPECIES.doc(docID).set({
                            'MINTEMP': MINTEMP,
                            'MAXTEMP': MAXTEMP,
                            'MINLUX': MINLUX,
                            'MAXLUX': MAXLUX,
                            'MINMST': MINMST,
                            'MAXMST': MAXMST,
                            'MINHUM': MINHUM,
                            'MAXHUM': MAXHUM,
                            'DOCID': docID,
                          });
                          // .then((value) => print('User is added'))
                          // .catchError((error) =>
                          //     print('Failed to add user: $error'));

                          //loading

                          setState(
                              () => hasInternet ? _isLoading = true : false);
                          await Future.delayed(const Duration(seconds: 2));

                          hasInternet ? _formKey.currentState?.reset() : null;
                          hasInternet
                              ? (Navigator.of(context)
                                  .push(
                                    MaterialPageRoute(
                                        builder: (context) => Downloadqr(
                                              pnforward: docID,
                                              pidforward: docID,
                                            )),
                                  )
                                  .then((_) => setState(() {
                                        hasInternet = false;
                                        _MAXTEMP.clear();
                                        _MINTEMP.clear();
                                        _MAXLUX.clear();
                                        _MAXMST.clear();
                                        _MAXHUM.clear();
                                        _MINLUX.clear();
                                        _MINMST.clear();
                                        _MINHUM.clear();
                                        MAXTEMP = 0;
                                        MINTEMP = 0;
                                        MAXLUX = 0;
                                        MINLUX = 0;
                                        MAXMST = 0;
                                        MINMST = 0;
                                        MAXHUM = 0;
                                        MINHUM = 0;
                                        docID = '';
                                        _isLoading = false;
                                      })))
                              : ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "No Internet",
                                    ),
                                  ),
                                );
                        }
                      },
                      child: _isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              'Save and Generate QR Code',
                              style: TextStyle(fontSize: 20),
                            )),
                ),
              ),
            ],
          ),
        ));
  }
}

// class Downloadqr extends StatefulWidget {
//   final String pnforward;
//   final String pidforward;
//   const Downloadqr(
//       {Key? key, required this.pnforward, required this.pidforward})
//       : super(key: key);

//   @override
//   DownloadqrState createState() {
//     return DownloadqrState();
//   }
// }

// class DownloadqrState extends State<Downloadqr> {
//   final key = GlobalKey();
//   File? file;

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () => Future.value(false),
//       child: Scaffold(
//           backgroundColor: const Color.fromARGB(255, 229, 242, 201),
//           body: SingleChildScrollView(
//               child: Center(
//                   child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                 const SizedBox(
//                   height: 40,
//                 ),
//                 Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
//                   child: Container(
//                     margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
//                     height: 50,
//                     width: 50,
//                     decoration: BoxDecoration(
//                       color: const Color.fromARGB(255, 18, 64, 38),
//                       borderRadius: BorderRadius.circular(50),
//                     ),
//                     child: const Icon(
//                       Icons.done_outlined,
//                       size: 40,
//                       color: Color.fromARGB(255, 144, 191, 73),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(70, 20, 70, 0),
//                   child: Text(
//                     widget.pnforward + " is Registered Succesfully!",
//                     style: const TextStyle(
//                         color: Color.fromARGB(255, 0, 0, 0),
//                         fontSize: 20,
//                         fontFamily: 'AvenirLight',
//                         fontWeight: FontWeight.bold),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 const Padding(
//                   padding: EdgeInsets.fromLTRB(70, 5, 70, 20),
//                   child: Text(
//                     "Save and Print QR Code using the button below.",
//                     style: TextStyle(
//                         color: Color.fromARGB(255, 0, 0, 0),
//                         fontSize: 20,
//                         fontFamily: 'AvenirLight'),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 RepaintBoundary(
//                     key: key,
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 10, vertical: 10),
//                       child: QrImage(
//                         data: widget.pidforward,
//                         version: QrVersions.auto,
//                         size: 200.0,
//                         backgroundColor: Colors.white,
//                         foregroundColor: const Color.fromARGB(255, 18, 64, 38),
//                       ),
//                     )),
//                 const SizedBox(height: 50),
//                 ElevatedButton(
//                   child: const Text(
//                     'Share or Save QR Code',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     onPrimary: const Color.fromARGB(255, 199, 217, 137),
//                     primary: const Color.fromARGB(255, 18, 64, 38),
//                     elevation: 20,
//                     minimumSize: const Size(300, 50),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30)),
//                   ),
//                   onPressed: () async {
//                     try {
//                       RenderRepaintBoundary boundary = key.currentContext!
//                           .findRenderObject() as RenderRepaintBoundary;
// //captures qr image
//                       var image = await boundary.toImage();

//                       ByteData? byteData =
//                           await image.toByteData(format: ImageByteFormat.png);

//                       Uint8List pngBytes = byteData!.buffer.asUint8List();
// //app directory for storing images.
//                       final appDir = await getApplicationDocumentsDirectory();
// //current time
//                       // var datetime = DateTime.now();
//                       var nameQrSave = widget.pnforward;
// //qr image file creation
//                       file =
//                           await File('${appDir.path}/$nameQrSave.png').create();
// //appending data
//                       await file?.writeAsBytes(pngBytes);
// //Shares QR image
//                       await Share.shareFiles(
//                         [file!.path],
//                         mimeTypes: ["image/png"],
//                         text: "Share the QR Code",
//                       );
//                     } catch (e) {
//                       // ignore: avoid_print
//                       print(e.toString());
//                     }
//                   },
//                 ),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                   child: const Text(
//                     'Register Another Plant',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     onPrimary: const Color.fromARGB(255, 18, 64, 38),
//                     primary: const Color.fromARGB(255, 144, 191, 73),
//                     elevation: 20,
//                     minimumSize: const Size(300, 50),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30)),
//                   ),
//                   onPressed: () {
//                     Navigator.pop(
//                       context,
//                       MaterialPageRoute(builder: (context) => const Register()),
//                     );
//                   },
//                 ),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                   child: const Text(
//                     'Exit',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     onPrimary: const Color.fromARGB(255, 18, 64, 38),
//                     primary: const Color.fromARGB(255, 144, 191, 73),
//                     elevation: 20,
//                     minimumSize: const Size(300, 50),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30)),
//                   ),
//                   onPressed: () {
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(builder: (context) => const MyApp()),
//                     );
//                   },
//                 ),
//               ])))),
//     );
//   }
// }
