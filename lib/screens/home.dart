import 'package:flutter/material.dart';
import 'package:plant_care_system/screens/About.dart';
import 'package:plant_care_system/screens/How_it_works.dart';
import 'package:plant_care_system/screens/Supported_Plants.dart';
import 'package:plant_care_system/screens/scanner.dart';
import 'register.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter_close_app/flutter_close_app.dart';

class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({Key? key, required this.title}) : super(key: key);

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
                backgroundColor: const Color.fromARGB(255, 229, 242, 201),
                appBar: AppBar(
                  iconTheme: const IconThemeData(
                      color: Color.fromARGB(255, 199, 217, 137)),
                  flexibleSpace: Container(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              // ignore: prefer_const_literals_to_create_immutables
                              colors: <Color>[
                        Color.fromARGB(255, 18, 64, 38),
                        Color.fromARGB(255, 38, 94, 30)
                      ]))),
                  title: const Text('Home',
                      style:
                          TextStyle(color: Color.fromARGB(255, 199, 217, 137))),
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
                body: SingleChildScrollView(
                  child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 70),
                          Container(
                            width: 300.0,
                            height: 300.0,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/logo2.png'),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          const SizedBox(height: 80),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                onPrimary:
                                    const Color.fromARGB(255, 199, 217, 137),
                                primary: const Color.fromARGB(255, 18, 64, 38),
                                elevation: 20,
                                minimumSize: const Size(300, 60),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 100)),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    settings: const RouteSettings(name: "Home"),
                                    builder: (context) => const PlantScanner()),
                              );
                            },
                            child: const Text(
                              'Scan QR Code',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                onPrimary:
                                    const Color.fromARGB(255, 199, 217, 137),
                                primary: const Color.fromARGB(255, 18, 64, 38),
                                elevation: 20,
                                minimumSize: const Size(250, 60),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 100)),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    settings: const RouteSettings(name: "Main"),
                                    builder: (context) => const Register()),
                              );
                            },
                            child: const Text(
                              'Register A Plant',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ]),
                  ),
                ))));
  }
}
