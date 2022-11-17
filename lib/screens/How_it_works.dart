import 'package:flutter/material.dart';
import 'package:flutter_close_app/flutter_close_app.dart';
import 'package:line_icons/line_icons.dart';
import 'package:plant_care_system/screens/Supported_Plants.dart';

import 'About.dart';
import 'home.dart';

void main() {
  runApp(const HowItWorks());
}

class HowItWorks extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const HowItWorks();

  @override
  Widget build(BuildContext context) {
    return FlutterCloseAppPage(
        onCloseFailed: () {
          // Condition does not match: the first press or the second press interval is more than 2 seconds, display a prompt message
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Press again to exit'),
          ));
        },
        child: WillPopScope(
            onWillPop: () => Future.value(false),
            child: Scaffold(
                appBar: AppBar(
                  iconTheme: const IconThemeData(
                      color: Color.fromARGB(255, 199, 217, 137)),
                  centerTitle: true,
                  title: const Text(
                    'How it works',
                    style: TextStyle(color: Color.fromARGB(255, 199, 217, 137)),
                  ),
                ),
                drawer: Drawer(
                  backgroundColor: const Color.fromARGB(255, 18, 64, 38),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      const SizedBox(
                        height: 50,
                        child: DrawerHeader(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.topRight,
                                  colors: <Color>[
                                Color.fromARGB(255, 18, 64, 38),
                                Color.fromARGB(255, 38, 94, 30)
                              ])),
                          child: null,
                        ),
                      ),
                      ListTile(
                        leading: const Icon(LineIcons.home,
                            color: Color.fromARGB(255, 199, 217, 137)),
                        title: const Text('Home',
                            style: TextStyle(
                                color: Color.fromARGB(255, 199, 217, 137))),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyHomePage(
                                      title: '',
                                    )),
                          );
                        },
                      ),
                      ListTile(
                        leading: const Icon(LineIcons.seedling,
                            color: Color.fromARGB(255, 199, 217, 137)),
                        title: const Text('Supported Plants',
                            style: TextStyle(
                                color: Color.fromARGB(255, 199, 217, 137))),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SuppPlant()),
                          );
                        },
                      ),
                      ListTile(
                        leading: const Icon(LineIcons.tools,
                            color: Color.fromARGB(255, 199, 217, 137)),
                        title: const Text('How It Works',
                            style: TextStyle(
                                color: Color.fromARGB(255, 199, 217, 137))),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HowItWorks()),
                          );
                        },
                      ),
                      ListTile(
                        leading: const Icon(LineIcons.infoCircle,
                            color: Color.fromARGB(255, 199, 217, 137)),
                        title: const Text('About',
                            style: TextStyle(
                                color: Color.fromARGB(255, 199, 217, 137))),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const About()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                backgroundColor: const Color.fromARGB(255, 199, 217, 137),
                body: SingleChildScrollView(
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: const Text(
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
                        width: 350,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color.fromARGB(255, 18, 64, 38),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: const Text(
                                'Step 1: REGISTER THE PLANT',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 10.0, right: 10.0, left: 10),
                              child: const Text(
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
                        margin: const EdgeInsets.only(top: 10),
                        padding: const EdgeInsets.all(10),
                        width: 350,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color.fromARGB(255, 18, 64, 38),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: const Text(
                                'Step 2: SAVE AND PRINT QR CODE',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 10.0, right: 10.0, left: 10),
                              child: const Text(
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
                        margin: const EdgeInsets.only(top: 10),
                        padding: const EdgeInsets.all(10),
                        width: 350,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color.fromARGB(255, 18, 64, 38),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: const Text(
                                'Step 3: SCAN THE CODE',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 10.0, right: 10.0, left: 10),
                              child: const Text(
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
                        margin: const EdgeInsets.only(top: 10),
                        padding: const EdgeInsets.all(10),
                        width: 350,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color.fromARGB(255, 18, 64, 38),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: const Text(
                                'Step 4: GATHER ENVIRONMENT DATA',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 10.0, right: 10.0, left: 10),
                              child: const Text(
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
                        margin: const EdgeInsets.only(top: 10),
                        padding: const EdgeInsets.all(10),
                        width: 350,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color.fromARGB(255, 18, 64, 38),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: const Text(
                                'Step 5: CONNECT TO BLUETOOTH',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 10.0, right: 10.0, left: 10),
                              child: const Text(
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
                        margin: const EdgeInsets.only(top: 10),
                        padding: const EdgeInsets.all(10),
                        width: 350,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color.fromARGB(255, 18, 64, 38),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: const Text(
                                'Step 6: COLLECTING DATA FROM DEVICE',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 10.0, right: 10.0, left: 10),
                              child: const Text(
                                "Remember, before you collect data, insert the device into the plant's soil. The data of the plant will be shown (soil moisture, temperature, humidity, and light intensity) together with recommended actions to help your plant find the best location for its growth.",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 199, 217, 137),
                                    fontSize: 15),
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(right: 10.0, left: 10),
                              child: const Text(
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
                        margin: const EdgeInsets.only(top: 10, bottom: 20),
                        padding: const EdgeInsets.all(10),
                        width: 350,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color.fromARGB(255, 18, 64, 38),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: const Text(
                                'Step 7: ACT AND SAVE',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 10.0, right: 10.0, left: 10),
                              child: const Text(
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
                ))));
  }
}
