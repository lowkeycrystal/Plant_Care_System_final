import 'dart:io';
// ignore: unnecessary_import
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_close_app/flutter_close_app.dart';
import 'package:plant_care_system/plant_profile.dart';
import 'main.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

void main() {
  runApp(const PlantScanner());
}

class PlantScanner extends StatelessWidget {
  const PlantScanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'QR Scanner',
      debugShowCheckedModeBanner: false,
      home: ScanQRPage(),
    );
  }
}

class ScanQRPage extends StatefulWidget {
  const ScanQRPage({Key? key}) : super(key: key);

  @override
  _ScanQRPageState createState() => _ScanQRPageState();
}

class _ScanQRPageState extends State {
  String qrResult = '';
  bool _isLoading = false;
  final GlobalKey qrKey = GlobalKey();
  late QRViewController controller;
  Barcode? result;
//in order to get hot reload to work.
  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      // await kag asyc sa after reassemble
      controller.pauseCamera();
    }
    controller.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterCloseAppPage(
        onCloseFailed: () {
          // Condition does not match: the first press or the second press interval is more than 2 seconds, display a prompt message
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Press again to exit'),
          ));
        },
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 229, 242, 201),
          appBar: AppBar(
            flexibleSpace: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[
                  Color.fromARGB(255, 18, 64, 38),
                  Color.fromARGB(255, 18, 60, 12)
                ]))),
            title: const Text('Plant QR Scanner',
                style: TextStyle(
                  color: Color.fromARGB(255, 199, 217, 137),
                  fontWeight: FontWeight.bold,
                )),
            iconTheme:
                const IconThemeData(color: Color.fromARGB(255, 199, 217, 137)),
            actions: <Widget>[
              IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MyApp()),
                    );
                  }),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                flex: 4,
                child: Stack(
                  children: [
                    QRView(
                      key: qrKey,
                      onQRViewCreated: onQRViewCreated,
                      overlay: QrScannerOverlayShape(
//customizing scan area
                        borderWidth: 10,
                        // ignore: prefer_const_constructors
                        borderColor: Color.fromARGB(255, 18, 64, 38),
                        borderLength: 20,
                        borderRadius: 10,
                        cutOutSize: MediaQuery.of(context).size.width * 0.8,
                      ),
                    ),
                    Positioned(
                      left: 0.0,
                      right: 0.0,
                      bottom: 0.0,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: Colors.black26,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                icon: const Icon(
                                  Icons.refresh,
                                  color: Color.fromARGB(255, 199, 217, 137),
                                ),
                                onPressed: () async {
                                  await controller.resumeCamera();
                                }),
                            IconButton(
                                icon: const Icon(
                                  Icons.flash_on,
                                  color: Color.fromARGB(255, 199, 217, 137),
                                ),
                                onPressed: () async {
                                  await controller.toggleFlash();
                                })
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.all(3.0),
                  width: double.infinity,
                  color: Colors.white,
                  child: Center(
                    child: result != null
                        ? Column(
                            children: [
                              const Text('\n QR Detected!'),
                              //  ${result!.code} : ${describeEnum(result!.format)}

                              const SizedBox(
                                height: 3.0,
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                child: _isLoading
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : const Text(
                                        'Proceed',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                style: ElevatedButton.styleFrom(
                                  onPrimary:
                                      const Color.fromARGB(255, 18, 64, 38),
                                  primary:
                                      const Color.fromARGB(255, 144, 191, 73),
                                  elevation: 20,
                                  minimumSize: const Size(300, 50),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                ),
                                onPressed: () async {
                                  setState(() => _isLoading = true);
                                  await Future.delayed(
                                      const Duration(seconds: 2));

                                  Navigator.of(context).pop(MaterialPageRoute(
                                      builder: (context) => PlantInfo(
                                            qrResult: '${result!.code}',
                                          )));

                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => const PlantInfo()),
                                  // );
                                },
                              ),
                            ],
                          )
                        : const Text('Scan QR Code'),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  void onQRViewCreated(QRViewController controller) {
//called when View gets created.
    // ignore: unnecessary_this
    this.controller = controller;

    controller.scannedDataStream.listen((scanData) {
      setState(() {
//UI gets created with new QR code.
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
