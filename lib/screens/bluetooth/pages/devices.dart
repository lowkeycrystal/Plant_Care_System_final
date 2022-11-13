import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:plant_care_system/screens/plant_profile.dart';

import '../widgets/snackbar_widget.dart';
import 'gathering_screen.dart';

void main() {
  runApp(const DevicesPage(
    qrResult: '',
    plantName: '',
    plantSpecie: '',
  ));
}

class DevicesPage extends StatefulWidget {
  final String qrResult;
  final String plantName;
  final String plantSpecie;
  const DevicesPage(
      {Key? key,
      required this.qrResult,
      required this.plantName,
      required this.plantSpecie})
      : super(key: key);

  @override
  _DevicesPageState createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  late String qrResult = widget.qrResult;
  late String plantName = widget.plantName;
  late String plantSpecie = widget.plantSpecie;

  final String kServiceUUID = "0000ffe0-0000-1000-8000-00805f9b34fb";
  final String kCharacteristicUUID = "0000ffe1-0000-1000-8000-00805f9b34fb";

  final List<BluetoothDevice> devicesList = <BluetoothDevice>[];
  late List<BluetoothService> _services;
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;

  String connectedDevice = 'none';
  bool isConnecting = false;
  bool isBTActive = false;
  bool isLocActive = false;
  bool isScanning = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );

    _permission();
    qrResult = widget.qrResult;
  }

  _permission() async {
    Timer.periodic(const Duration(milliseconds: 100), (_) {
      Permission.location.status.then((status) async {
        if (status.isDenied || status.isPermanentlyDenied) {
          await Permission.location.request();
        } else if (status.isGranted) {
          var isLocEnabled = await Permission.location.serviceStatus.isEnabled;
          if (isLocEnabled) {
            if (isLocActive != true) {
              _listenStateChange();
            }
            setState(() {
              isLocActive = true;
            });
          } else {
            if (isScanning) {
              flutterBlue.stopScan();
            }
            setState(() {
              isLocActive = false;
            });
          }
        }
      });
      Permission.bluetoothScan.status.then((status) async {
        if (status.isDenied || status.isPermanentlyDenied) {
          var bt = await Permission.bluetoothScan.request();
          if (bt.isGranted) {
            _scanListenerStatus();
          }
        }
      });
      Permission.bluetoothConnect.status.then((status) async {
        if (status.isDenied || status.isPermanentlyDenied) {
          await Permission.bluetoothConnect.request();
        }
      });
    });
  }

  _listenStateChange() {
    flutterBlue.state.listen((event) {
      if (event == BluetoothState.on) {
        _startScan();
        setState(() {
          isBTActive = true;
        });
      } else if (event == BluetoothState.off) {
        if (isScanning) {
          flutterBlue.stopScan();
        }
        setState(() {
          isBTActive = false;
        });
      }
    });
  }

  void _scanListenerStatus() {
    flutterBlue.isScanning.listen((status) {
      setState(() {
        isScanning = status;
      });
    });
  }

  void _startScan() {
    setState(devicesList.clear);
    _watchIsConnected();

    flutterBlue.startScan(
      timeout: const Duration(seconds: 15),
      allowDuplicates: false,
    );

    flutterBlue.scanResults.listen((results) {
      for (var result in results) {
        _addDeviceTolist(result.device);
      }
    });
  }

  void _watchIsConnected() {
    flutterBlue.connectedDevices.asStream().listen((devices) async {
      for (var device in devices) {
        device.disconnect();

        _addDeviceTolist(device);
      }
    });
  }

  _addDeviceTolist(final BluetoothDevice device) {
    if (!devicesList.contains(device)) {
      setState(() {
        devicesList.add(device);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => Future.value(false),
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: const Color.fromARGB(255, 18, 64, 38),
            appBar: AppBar(
              automaticallyImplyLeading: false,
              iconTheme: const IconThemeData(
                color: Color.fromARGB(255, 199, 217, 137),
              ),
              actions: <Widget>[
                IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(
                          context,
                        )),
              ],
              backgroundColor: Colors.transparent,
              bottomOpacity: 0.0,
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Connect to Device',
                      style: TextStyle(
                        color: Color.fromARGB(255, 199, 217, 137),
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ]),
              elevation: 0,
            ),
            body: SafeArea(
              child: Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        LayoutBuilder(
                          builder: (context, _) {
                            if (isLocActive) {
                              if (isBTActive) {
                                return Column(
                                  children: [
                                    StreamBuilder<bool>(
                                      stream: flutterBlue.isScanning,
                                      initialData: false,
                                      builder: (c, snapshot) {
                                        if (snapshot.data!) {
                                          return FloatingActionButton(
                                            onPressed: () =>
                                                flutterBlue.stopScan(),
                                            backgroundColor: Colors.red,
                                            child: const Icon(Icons.stop),
                                          );
                                        } else {
                                          return FloatingActionButton(
                                            onPressed: _startScan,
                                            child: const Icon(Icons.search),
                                          );
                                        }
                                      },
                                    ),
                                    const SizedBox(height: 16),
                                    _deviceList(),
                                  ],
                                );
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 50),
                                  child: Center(
                                    child: Text(
                                      'Bluetooth is inactive.\nPlease turn it on.',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4!
                                          .copyWith(color: Colors.white),
                                    ),
                                  ),
                                );
                              }
                            } else {
                              return Padding(
                                padding: const EdgeInsets.only(top: 50),
                                child: Center(
                                  child: Text(
                                    'Location is inactive.\nPlease turn it on.',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }

  Widget _deviceList() {
    return Card(
      margin: const EdgeInsets.all(10),
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: devicesList.length,
          itemBuilder: (context, index) {
            if (devicesList[index].name.isNotEmpty) {
              return _scanResultButton(
                device: devicesList[index],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  late final Stream<QuerySnapshot> plants = FirebaseFirestore.instance
      .collection('PLANTS')
      .where('Plant_Id', isEqualTo: widget.qrResult)
      .snapshots();

  Widget _scanResultButton({BluetoothDevice? device}) {
    return Card(
      child: ListTile(
        onTap: () async {
          flutterBlue.stopScan();
          try {
            BluetoothCharacteristic? characteristic;

            setState(() {
              isConnecting = true;
              connectedDevice = device!.name;
            });
            await device!.connect();
            _services = await device.discoverServices();

            for (var service in _services) {
              for (var characteristics in service.characteristics) {
                if (characteristics.properties.read &&
                    characteristics.properties.writeWithoutResponse &&
                    characteristics.properties.notify) {
                  characteristic = characteristics;
                }
              }
            }

            if (characteristic != null) {
              setState(() {
                isConnecting = false;
              });
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GatheringScreen(
                    device: device,
                    characteristics: characteristic!,
                    qrResult: qrResult,
                    plantName: plantName,
                    plantSpecie: plantSpecie,
                  ),
                ),
              );
            } else {
              if (isConnecting) {
                device.disconnect();
                CustomSnackbar(
                  context,
                  status: Status.error,
                  text: 'This device is not a Arduino device',
                );
                setState(() {
                  isConnecting = false;
                });
              }
            }
          } on PlatformException catch (e) {
            setState(() {
              isConnecting = false;
            });
            CustomSnackbar(
              context,
              status: Status.error,
              text: 'Error Code: ${e.code}\n${e.message}',
            );
          }
        },
        title: Text(
          device!.name,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Colors.black,
              ),
        ),
        subtitle: Text(
          'Mac Address: ${device.id.id}',
          style: Theme.of(context).textTheme.caption!,
        ),
        trailing: connectedDevice == device.name && isConnecting == true
            ? const CircularProgressIndicator()
            : null,
      ),
    );
  }
}
