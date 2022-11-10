import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../widgets/snackbar_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.characteristics,
    required this.device,
  }) : super(key: key);

  ///Retrieves all available bluetooth services
  final BluetoothCharacteristic characteristics;

  ///Retrieves device info
  final BluetoothDevice device;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late BluetoothCharacteristic _characteristics;
  late StreamSubscription<List<int>> bleReceive;

  double temperature = 0;
  double humidity = 0;
  double moisture = 0;
  double lux = 0;

  bool isReconnect = false;
  Timer? timer;

  //Initiate variables when screen starts
  @override
  void initState() {
    super.initState();
    _characteristics = widget.characteristics;
    _listenBluetoothConnectionStatus();
    _receiveFromBT();
  }

  //Cancel or remove all listeners when leaves
  @override
  void dispose() {
    bleReceive.cancel();
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Arduino Flutter Night'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () async {
              await widget.device.disconnect();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Icon(
                      Icons.thermostat_outlined,
                      color: getTempColor(temperature),
                      size: 120,
                    ),
                    const Text(
                      'Temperature',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '$temperature °C',
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Icon(
                      Icons.water_outlined,
                      color: Colors.blue,
                      size: 120,
                    ),
                    const Text(
                      'Humidity',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '$humidity %',
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16 * 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Icon(
                      Icons.water_drop_outlined,
                      color: getTempColor(temperature),
                      size: 120,
                    ),
                    const Text(
                      'Soil Moisture',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '$moisture %',
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Icon(
                      Icons.lightbulb_outline,
                      color: Colors.blue,
                      size: 120,
                    ),
                    const Text(
                      'Lux',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '$lux lx',
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _listenBluetoothConnectionStatus() {
    widget.device.state.listen((event) {
      if (event == BluetoothDeviceState.disconnected) {
        CustomSnackbar(
          context,
          status: Status.error,
          text: 'Device Disconnected',
        );

        timer = Timer.periodic(const Duration(seconds: 30), (_) async {
          await widget.device.connect();
          isReconnect = true;
          CustomSnackbar(
            context,
            status: Status.warning,
            text: 'Device is attempting to Reconnect.',
          );
        });
      } else if (event == BluetoothDeviceState.connected && isReconnect) {
        if (timer != null) {
          timer!.cancel();
        }
        CustomSnackbar(
          context,
          status: Status.success,
          text: 'Device Successfully Reconnected',
        );
        isReconnect = false;
      } else if (event == BluetoothDeviceState.connecting) {
        CustomSnackbar(
          context,
          status: Status.warning,
          text: 'Device is Reconnecting',
        );
      }
    });
  }

  // _receiveFromBT() async {
  //   /// This is the sample data you receive from the arduino project
  //   /// TP:35.45;
  //   /// HD:56.46;
  //   /// Thats why we need to splice the value into something readable
  //   bleReceive = _characteristics.value.listen((value) {
  //     var splitComma = utf8.decode(value).split(',');
  //     for (var split in splitComma) {
  //       var splitNewLine = split.split('\n');
  //       for (var element in splitNewLine) {
  //         if (RegExp(r'[TP|HD|MS|LX]+:').hasMatch(element)) {
  //           var prefix = element.substring(0, 2);
  //           var value =
  //               element.substring(3).replaceAll(';', '').replaceAll(' ', '');
  //           switch (prefix) {
  //             case 'TP':
  //               setState(() {
  //                 temperature = double.parse(value);
  //               });
  //               break;
  //             case 'HD':
  //               setState(() {
  //                 humidity = double.parse(value);
  //               });
  //               break;
  //             case 'MS':
  //               setState(() {
  //                 moisture = double.parse(value);
  //               });
  //               break;
  //             case 'LX':
  //               setState(() {
  //                 lux = double.parse(value);
  //               });
  //               break;
  //             default:
  //               setState(() {
  //                 temperature = 20;
  //                 humidity = 30;
  //                 lux = 6;
  //                 moisture = 25;
  //               });
  //               break;
  //           }
  //         }
  //       }
  //     }
  //   });
  // }

  ///////////////////////////////////////////////////////////////////////////////////
  ///
  /*
  _receiveFromBT() async {
    //This listens to all incoming bluetooth data
    await _characteristics.setNotifyValue(true);
    bleReceive = _characteristics.value.listen((value) {
      var splitComma = utf8.decode(value);
      if (splitComma.isNotEmpty) {
        setState(() {
          temperature = double.parse(splitComma);
        });
      } else {
        setState(() {
          temperature = 20;
        });
      }
    });
  }
  */
  /////////////////////////////////////////////////////////////////////////////////

  _receiveFromBT() async {
    //This listens to all incoming bluetooth data
    await _characteristics.setNotifyValue(true);
    bleReceive = _characteristics.value.listen((value) {
      var splitComma = utf8.decode(value).split(':');
      if (splitComma.isNotEmpty) {
        var prefix = splitComma[0];
        var value = splitComma[1];
        switch (prefix) {
          case 'TP':
            setState(() {
              temperature = double.parse(value);
            });
            break;
          case 'HD':
            setState(() {
              humidity = double.parse(value);
            });
            break;
          case 'MS':
            setState(() {
              moisture = double.parse(value);
            });
            break;
          case 'LX':
            setState(() {
              lux = double.parse(value);
            });
            break;
          default:
            setState(() {
              temperature = 20;
              humidity = 30;
              lux = 6;
              moisture = 25;
            });
            break;
        }
      } else {
        CustomSnackbar(
          context,
          status: Status.warning,
          text: 'Device is not sending data',
        );
      }
    });
  }

  /// This is the sample data you receive from the arduino project
  /// TP:35.45;
  /// HD:56.46;
  /// HD,56.46,;
  /// Thats why we need to splice the value into something readable
  //   bleReceive = _characteristics.value.listen((value) {
  //     var splitComma = utf8.decode(value).split(',');
  //     for (var split in splitComma) {
  //       if (RegExp(r'TP|HD').hasMatch(split)) {
  //         var prefix = splitComma[0];
  //         var value = splitComma[1];
  //         switch (prefix) {
  //           case 'TP':
  //             setState(() {
  //               temperature = double.parse(value);
  //             });
  //             break;
  //           case 'HD':
  //             setState(() {
  //               humidity = double.parse(value);
  //             });
  //             break;
  //         }
  //       }
  //     }
  //   });
  // }

  //Function to get color depending on the temperature
  Color getTempColor(double temperature) {
    if (temperature < 30) {
      return Colors.blue;
    } else if (temperature > 30 && temperature < 37) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}
