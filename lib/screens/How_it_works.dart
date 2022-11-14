import 'dart:html';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'How it works',
        theme: ThemeData(
            appBarTheme: AppBarTheme(
          color: Color.fromARGB(255, 18, 64, 38),
        )),
        home: Scaffold(
            appBar: AppBar(
              iconTheme:
                  IconThemeData(color: Color.fromARGB(255, 199, 217, 137)),
              centerTitle: true,
              title: const Text(
                'How it works',
                style: TextStyle(color: Color.fromARGB(255, 199, 217, 137)),
              ),
              leading: IconButton(
                onPressed: () {},
                icon: Icon(Icons.arrow_back),
              ),
            ),
            backgroundColor: Color.fromARGB(255, 199, 217, 137),
            body: SingleChildScrollView(
              child: Center(
                  child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      'Our mission is to assist you in your everyday life by taking care of your plant.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color.fromARGB(255, 18, 64, 38),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    height: 150,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color.fromARGB(255, 18, 64, 38),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            'Step 1: REGISTER THE PLANT',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.only(top: 10.0, right: 10.0, left: 10),
                          child: Text(
                            'Register the plant you want to monitor. Then, after that, fill in the necessary information.',
                            style: TextStyle(
                                color: Color.fromARGB(255, 199, 217, 137),
                                fontSize: 15),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.all(10),
                    height: 150,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color.fromARGB(255, 18, 64, 38),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            'Step 2: SAVE AND PRINT QR CODE',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.only(top: 10.0, right: 10.0, left: 10),
                          child: Text(
                            'After successful registration, save it, and then print the QR code. Next, attach it to the pot of the plant you have registered.',
                            style: TextStyle(
                                color: Color.fromARGB(255, 199, 217, 137),
                                fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.all(10),
                    height: 180,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color.fromARGB(255, 18, 64, 38),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            'Step 3: SCAN THE CODE',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.only(top: 10.0, right: 10.0, left: 10),
                          child: Text(
                            'Click "scan QR code" button on the homepage then scan the QR code of the plant you want to monitor. Click proceed. After that, the plant information page will open.',
                            style: TextStyle(
                                color: Color.fromARGB(255, 199, 217, 137),
                                fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.all(10),
                    height: 150,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color.fromARGB(255, 18, 64, 38),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            'Step 4: GATHER ENVIRONMENT DATA',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.only(top: 10.0, right: 10.0, left: 10),
                          child: Text(
                            'Click the gather environment data to open the bluetooth page.',
                            style: TextStyle(
                                color: Color.fromARGB(255, 199, 217, 137),
                                fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.all(10),
                    height: 150,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color.fromARGB(255, 18, 64, 38),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            'Step 5: CONNECT TO BLUETOOTH',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.only(top: 10.0, right: 10.0, left: 10),
                          child: Text(
                            'Make sure to open your bluetooth and location then browse and click the name of the device.',
                            style: TextStyle(
                                color: Color.fromARGB(255, 199, 217, 137),
                                fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.all(10),
                    height: 315,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color.fromARGB(255, 18, 64, 38),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            'Step 6: COLLECTING DATA FROM DEVICE',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.only(top: 10.0, right: 10.0, left: 10),
                          child: Text(
                            "Remember, before you collect data, insert the device into the plant's soil. The data of the plant will be shown (soil moisture, temperature, humidity, and light intensity) together with recommended actions to help your plant find the best location for its growth.",
                            style: TextStyle(
                                color: Color.fromARGB(255, 199, 217, 137),
                                fontSize: 15),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 10.0, left: 10),
                          child: Text(
                            "Recommendations will be based on the data gathered, such as the amount of light intensity, the recommended temperature for your plant, and the volume of water required for your soil.",
                            style: TextStyle(
                                color: Color.fromARGB(255, 199, 217, 137),
                                fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.all(10),
                    height: 130,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color.fromARGB(255, 18, 64, 38),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            'Step 7: ACT AND SAVE',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.only(top: 10.0, right: 10.0, left: 10),
                          child: Text(
                            'Perform necessary actions then click Save and Close to return to the plant information page.',
                            style: TextStyle(
                                color: Color.fromARGB(255, 199, 217, 137),
                                fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
            )));
  }
}
