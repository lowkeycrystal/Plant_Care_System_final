import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const MyApp();

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
                SizedBox(
                  height: 400,
                  width: 350,
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    margin: const EdgeInsets.only(
                      top: 40,
                    ),
                    padding: const EdgeInsets.only(
                      bottom: 30,
                      right: 30,
                      left: 30,
                      top: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                        ),
                        const Align(
                          alignment: Alignment.center,
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            bottom: 30,
                            top: 50,
                          ),
                          child: const SpinKitCircle(
                            color: Colors.black,
                            size: 40,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            bottom: 22,
                          ),
                          child: const Text(
                            'Gathering Data',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                        ),
                        const Text(
                          'Make Sure that the device is placed properly on the right pot.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                    height: 200,
                    width: 400,
                    margin: const EdgeInsets.only(
                      top: 30,
                    ),
                    child: Row(children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(
                              bottom: 10,
                            ),
                            child: const Text(
                              'Moisture',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            height: 150,
                            width: 175,
                            margin: const EdgeInsets.only(left: 5),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: const Text(
                                    '20%',
                                    style: TextStyle(fontSize: 45),
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
                                      children: [Image.asset('pics/moist.png')],
                                    ))
                              ],
                            ),
                          ),
                          const Text(
                            ' Level: Too Low',
                            style: TextStyle(fontSize: 16),
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
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: const Text(
                                    '98 F',
                                    style: TextStyle(fontSize: 45),
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
                                      children: [Image.asset('pics/temp.png')],
                                    ))
                              ],
                            ),
                          ),
                          const Text(
                            ' Level: Too High',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ])),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: ElevatedButton(
                    child: const Text(
                      'Continue',
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
                    onPressed: () {},
                  ),
                ),
              ])),
            )));
  }
}
