import 'package:flutter/material.dart';
import 'package:flutter_close_app/flutter_close_app.dart';
import 'package:plant_care_system/screens/register.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/rendering.dart';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:io';

void main() {
  runApp(const Downloadqr(
    pnforward: '',
    pidforward: '',
  ));
}

class Downloadqr extends StatefulWidget {
  final String pnforward;
  final String pidforward;
  const Downloadqr(
      {Key? key, required this.pnforward, required this.pidforward})
      : super(key: key);

  @override
  DownloadqrState createState() {
    return DownloadqrState();
  }
}

class DownloadqrState extends State<Downloadqr> {
  final key = GlobalKey();
  File? file;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: FlutterCloseAppPage(
        onCloseFailed: () {
          // Condition does not match: the first press or the second press interval is more than 2 seconds, display a prompt message
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Press again to exit'),
          ));
        },
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 229, 242, 201),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 18, 64, 38),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Icon(
                        Icons.done_outlined,
                        size: 40,
                        color: Color.fromARGB(255, 144, 191, 73),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(70, 20, 70, 0),
                    child: Text(
                      widget.pnforward + " is Registered Succesfully!",
                      style: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 20,
                          fontFamily: 'AvenirLight',
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(70, 5, 70, 20),
                    child: Text(
                      "Save and Print QR Code using the button below.",
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 20,
                          fontFamily: 'AvenirLight'),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  RepaintBoundary(
                      key: key,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: QrImage(
                          data: widget.pidforward,
                          version: QrVersions.auto,
                          size: 200.0,
                          backgroundColor: Colors.white,
                          foregroundColor:
                              const Color.fromARGB(255, 18, 64, 38),
                        ),
                      )),
                  const SizedBox(height: 50),
                  ElevatedButton(
                    child: const Text(
                      'Share or Save QR Code',
                      style: TextStyle(fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                      onPrimary: const Color.fromARGB(255, 199, 217, 137),
                      primary: const Color.fromARGB(255, 18, 64, 38),
                      elevation: 20,
                      minimumSize: const Size(300, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    onPressed: () async {
                      try {
                        RenderRepaintBoundary boundary = key.currentContext!
                            .findRenderObject() as RenderRepaintBoundary;
//captures qr image
                        var image = await boundary.toImage();

                        ByteData? byteData =
                            await image.toByteData(format: ImageByteFormat.png);

                        Uint8List pngBytes = byteData!.buffer.asUint8List();
//app directory for storing images.
                        final appDir = await getApplicationDocumentsDirectory();
//current time
                        // var datetime = DateTime.now();
                        var nameQrSave = widget.pnforward;
//qr image file creation
                        file = await File('${appDir.path}/$nameQrSave.png')
                            .create();
//appending data
                        await file?.writeAsBytes(pngBytes);
//Shares QR image
                        await Share.shareFiles(
                          [file!.path],
                          mimeTypes: ["image/png"],
                          text: "Share the QR Code",
                        );
                      } catch (e) {
                        // ignore: avoid_print
                        print(e.toString());
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    child: const Text(
                      'Register Another Plant',
                      style: TextStyle(fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                      onPrimary: const Color.fromARGB(255, 18, 64, 38),
                      primary: const Color.fromARGB(255, 144, 191, 73),
                      elevation: 20,
                      minimumSize: const Size(300, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    onPressed: () {
                      Navigator.pop(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Register()),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    child: const Text(
                      'Exit',
                      style: TextStyle(fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                      onPrimary: const Color.fromARGB(255, 18, 64, 38),
                      primary: const Color.fromARGB(255, 144, 191, 73),
                      elevation: 20,
                      minimumSize: const Size(300, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
