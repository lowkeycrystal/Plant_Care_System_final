import 'package:flutter/material.dart';

import '../main.dart';

void main() {
  runApp(Data());
}

// ignore: must_be_immutable
class Data extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  Data();

  double temperature = 0;
  double humidity = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Plant Details',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: const Color.fromARGB(255, 229, 242, 201),
            appBar: AppBar(
              iconTheme: const IconThemeData(
                  color: Color.fromARGB(255, 199, 217, 137)),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Close Plant Profile?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MyApp()),
                            );
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
              title: const Text('Plant Profile',
                  style: TextStyle(
                    color: Color.fromARGB(255, 18, 64, 38),
                    fontWeight: FontWeight.bold,
                  )),
              elevation: 0,
            ),
            body: SingleChildScrollView(
              child: Center(
                  child: Column(children: [
                Container(
                  height: 200,
                  width: 400,
                  margin: const EdgeInsets.only(
                    top: 30,
                  ),
                  child: Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(
                              bottom: 10,
                            ),
                            child: const Text(
                              'Humidity',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            height: 150,
                            width: 175,
                            margin: const EdgeInsets.only(left: 5),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 233, 156, 150),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Text(
                                    '$humidity%',
                                    style: const TextStyle(fontSize: 45),
                                  ),
                                ),
                                Container(
                                  color: Colors.black,
                                  width: 3,
                                  height: 100,
                                ),
                                SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: Column(
                                      children: const [
                                        Icon(
                                          Icons.water_outlined,
                                          color: Colors.blue,
                                          size: 80,
                                        ),
                                      ],
                                    ))
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 1,
                        width: 15,
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(
                              bottom: 10,
                            ),
                            child: const Text(
                              'Temperature',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            height: 150,
                            width: 175,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 115, 203, 241),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Text(
                                    "${temperature}C",
                                    style: const TextStyle(fontSize: 45),
                                  ),
                                ),
                                Container(
                                  color: Colors.black,
                                  width: 3,
                                  height: 100,
                                ),
                                SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.thermostat_outlined,
                                        color: getTempColor(temperature),
                                        size: 80,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 370,
                  width: 350,
                  margin: const EdgeInsets.only(
                    top: 30,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.red,
                        width: 4,
                      )),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: const Color.fromARGB(255, 199, 217, 137),
                      backgroundColor: const Color.fromARGB(255, 18, 64, 38),
                      elevation: 20,
                      minimumSize: const Size(300, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Done',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ])),
            )));
  }
}

Color getTempColor(double temperature) {
  if (temperature < 30) {
    return Colors.blue;
  } else if (temperature > 30 && temperature < 37) {
    return Colors.orange;
  } else {
    return Colors.red;
  }
}
