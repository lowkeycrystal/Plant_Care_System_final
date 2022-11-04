import 'dart:async';
import 'package:plant_care_system/main.dart';

import 'chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:scoped_model/scoped_model.dart';
import 'background_collected_page.dart';
import 'background_collecting_task.dart';
import 'paired_device_page.dart';

// import './helpers/LineChart.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPage createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  BackgroundCollectingTask? _collectingTask;

  @override
  void initState() {
    super.initState();

    // Get current state
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    Future.doWhile(() async {
      // Wait if adapter not enabled
      if ((await FlutterBluetoothSerial.instance.isEnabled) ?? false) {
        return false;
      }
      await Future.delayed(const Duration(milliseconds: 0xDD));
      return true;
    });
    FlutterBluetoothSerial.instance.name.then((name) {
      setState(() {});
    });

    // Listen for futher state changes
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;
      });
    });
  }

  // @override
  // void dispose() {
  //   FlutterBluetoothSerial.instance.setPairingRequestHandler(null);
  //   _collectingTask?.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    // ignore: prefer_const_literals_to_create_immutables
                    colors: <Color>[
              Color.fromARGB(255, 18, 64, 38),
              Color.fromARGB(255, 18, 60, 12)
            ]))),
        title: const Text('Connect to Bluetooth',
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
      body: ListView(
        children: <Widget>[
          const Divider(),
          SwitchListTile(
            secondary: const Icon(Icons.bluetooth),
            title: const Text(
              'Enable Bluetooth',
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 17,
                  fontFamily: 'AvenirLight'),
            ),
            activeColor: const Color.fromARGB(255, 18, 64, 38),
            value: _bluetoothState.isEnabled,
            onChanged: (bool value) {
              // Do the request and update with the true value then
              future() async {
                // async lambda seems to not working
                if (value) {
                  await FlutterBluetoothSerial.instance.requestEnable();
                } else {
                  await FlutterBluetoothSerial.instance.requestDisable();
                }
              }

              future().then((_) {
                setState(() {});
              });
            },
          ),
          const SizedBox(
            height: 50,
          ),
          ListTile(
            title: ElevatedButton(
              child: const Text('Pair Device'),
              style: ElevatedButton.styleFrom(
                  onPrimary: const Color.fromARGB(255, 199, 217, 137),
                  primary: const Color.fromARGB(255, 18, 64, 38),
                  elevation: 20,
                  minimumSize: const Size(280, 60),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 80)),
              onPressed: () {
                FlutterBluetoothSerial.instance.openSettings();
              },
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          const Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Text(
                'Make sure that you have paired the device before trying to connect. Password is either "1234" or "0000" ',
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 17,
                    fontFamily: 'AvenirLight'),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          /////////////////////////////////////////////////////////////////////////////////////////
          ListTile(
            title: ElevatedButton(
              child: const Text('Gather Environment Data'),
              style: ElevatedButton.styleFrom(
                  onPrimary: const Color.fromARGB(255, 199, 217, 137),
                  primary: const Color.fromARGB(255, 18, 64, 38),
                  elevation: 20,
                  minimumSize: const Size(280, 60),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 80)),
              onPressed: () async {
                final BluetoothDevice? selectedDevice =
                    await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const SelectBondedDevicePage(
                          checkAvailability: false);
                    },
                  ),
                );

                if (selectedDevice != null) {
                  print('Connect -> selected ' + selectedDevice.address);
                  _startChat(context, selectedDevice);
                } else {
                  print('Connect -> no device selected');
                }
              },
            ),
          ),
          /////////////////////////////////////////////////////////////////////////////////////////
          const SizedBox(
            height: 50,
          ),
          ListTile(
            title: ElevatedButton(
              child: ((_collectingTask?.inProgress ?? false)
                  ? const Text('Disconnect and stop background collecting')
                  : const Text('Connect to start background collecting')),
              style: ElevatedButton.styleFrom(
                  onPrimary: const Color.fromARGB(255, 199, 217, 137),
                  primary: const Color.fromARGB(255, 18, 64, 38),
                  elevation: 20,
                  minimumSize: const Size(280, 60),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 80)),
              onPressed: () async {
                if (_collectingTask?.inProgress ?? false) {
                  await _collectingTask!.cancel();
                  setState(() {
                    /* Update for `_collectingTask.inProgress` */
                  });
                } else {
                  final BluetoothDevice? selectedDevice =
                      await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return const SelectBondedDevicePage(
                            checkAvailability: false);
                      },
                    ),
                  );

                  if (selectedDevice != null) {
                    await _startBackgroundTask(context, selectedDevice);
                    setState(() {
                      /* Update for `_collectingTask.inProgress` */
                    });
                  }
                }
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            title: ElevatedButton(
              child: const Text('View background collected data'),
              style: ElevatedButton.styleFrom(
                  onPrimary: const Color.fromARGB(255, 199, 217, 137),
                  primary: const Color.fromARGB(255, 18, 64, 38),
                  elevation: 20,
                  minimumSize: const Size(300, 60),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  padding: const EdgeInsets.symmetric(
                      vertical: 20, horizontal: 110)),
              onPressed: (_collectingTask != null)
                  ? () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return ScopedModel<BackgroundCollectingTask>(
                              model: _collectingTask!,
                              child: const BackgroundCollectedPage(),
                            );
                          },
                        ),
                      );
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }

////////////////////////////////////////
  void _startChat(BuildContext context, BluetoothDevice server) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return ChatPage(server: server);
        },
      ),
    );
  }

/////////////////////////////////////
  Future<void> _startBackgroundTask(
    BuildContext context,
    BluetoothDevice server,
  ) async {
    try {
      _collectingTask = await BackgroundCollectingTask.connect(server);
      await _collectingTask!.start();
    } catch (ex) {
      _collectingTask?.cancel();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error occured while connecting'),
            actions: <Widget>[
              TextButton(
                child: const Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
