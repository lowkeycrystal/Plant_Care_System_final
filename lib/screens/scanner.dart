// ignore: unnecessary_import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_close_app/flutter_close_app.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:plant_care_system/screens/plant_profile.dart';
import '../main.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

void main() {
  runApp(const PlantScanner());
}

class PlantScanner extends StatelessWidget {
  const PlantScanner({Key? key}) : super(key: key);

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
                iconTheme: const IconThemeData(
                    color: Color.fromARGB(255, 199, 217, 137)),
                actions: <Widget>[
                  IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyApp()),
                        );
                      }),
                ],
              ),
              body: const ScanQRPage(),
            )));
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
  bool hasInternet = false;
  final GlobalKey qrKey = GlobalKey();
  QRViewController? controller;
  Barcode? result;
//in order to get hot reload to work.
  @override
  void reassemble() {
    super.reassemble();
    if (controller != null && mounted) {
      controller!.pauseCamera();
      controller!.resumeCamera();
    }
  }

  late final Stream<QuerySnapshot> plants =
      FirebaseFirestore.instance.collection('PLANTS').snapshots();

  bool hasData = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: plants,
      builder: (
        BuildContext context,
        AsyncSnapshot<QuerySnapshot> snapshot,
      ) {
        if (snapshot.hasError) {
          return const Text('Something went wrong!');
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Column(children: const <Widget>[
            CircularProgressIndicator(
              color: Color.fromARGB(255, 18, 64, 38),
            ),
            Text('Loading Data Please Wait...'),
          ]);
        }

        return Column(
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
                                Icons.play_arrow,
                                color: Color.fromARGB(255, 199, 217, 137),
                              ),
                              onPressed: () async {
                                await controller!.resumeCamera();
                              }),
                          IconButton(
                              icon: const Icon(
                                Icons.flash_on,
                                color: Color.fromARGB(255, 199, 217, 137),
                              ),
                              onPressed: () async {
                                await controller!.toggleFlash();
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
                              style: ElevatedButton.styleFrom(
                                foregroundColor:
                                    const Color.fromARGB(255, 18, 64, 38),
                                backgroundColor:
                                    const Color.fromARGB(255, 144, 191, 73),
                                elevation: 20,
                                minimumSize: const Size(300, 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                              ),
                              onPressed: () async {
                                hasInternet = await InternetConnectionChecker()
                                    .hasConnection;
                                setState(() =>
                                    hasInternet ? _isLoading = true : false);
                                await Future.delayed(
                                    const Duration(seconds: 2));

                                QuerySnapshot query = await FirebaseFirestore
                                    .instance
                                    .collection('PLANTS')
                                    .where('Plant_Id',
                                        isEqualTo: '${result!.code}')
                                    .get();
                                if (query.docs.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text(
                                          'QR not on database. Click here to retry:'),
                                      action: SnackBarAction(
                                        label: 'Reload',
                                        textColor: Colors.yellow,
                                        onPressed: () {
                                          ScaffoldMessenger.of(context)
                                              .hideCurrentSnackBar;
                                          setState(
                                            () {
                                              qrResult = '';
                                              _isLoading = false;
                                              hasData = false;
                                              result = null;
                                            },
                                          );
                                        },
                                      ),
                                      duration: const Duration(seconds: 10),
                                    ),
                                  );
                                } else {
                                  hasInternet
                                      ? Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (context) => PlantInfo(
                                              qrResult: '${result!.code}',
                                            ),
                                          ),
                                        )
                                      : ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              "No Internet",
                                            ),
                                          ),
                                        );
                                }

                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => const PlantInfo()),
                                // );
                              },
                              child: _isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : const Text(
                                      'Proceed',
                                      style: TextStyle(fontSize: 20),
                                    ),
                            ),
                          ],
                        )
                      : Column(
                          children: const <Widget>[
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              'Scan QR Code',
                              style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                fontFamily: 'AvenirLight',
                              ),
                            ),
                            Text(
                              'Click "play" icon to open camera',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.normal,
                                fontSize: 15,
                                fontFamily: 'AvenirLight',
                              ),
                            )
                          ],
                        ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void onQRViewCreated(QRViewController controller) {
//called when View gets created.
    // ignore: unnecessary_this
    this.controller = controller;

    controller.scannedDataStream.listen(
      (scanData) {
        setState(
          () {
//UI gets created with new QR code.
            result = scanData;
          },
        );
      },
    );
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }
}
