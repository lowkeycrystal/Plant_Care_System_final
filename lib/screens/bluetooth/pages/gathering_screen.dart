import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:plant_care_system/screens/plant_profile.dart';

import '../widgets/snackbar_widget.dart';

class GatheringScreen extends StatefulWidget {
  const GatheringScreen({
    Key? key,
    required this.characteristics,
    required this.device,
    required this.qrResult,
    required this.plantName,
    required this.plantSpecie,
  }) : super(key: key);

  ///Retrieves all available bluetooth services
  final BluetoothCharacteristic characteristics;
  final String qrResult;
  final String plantName;
  final String plantSpecie;

  ///Retrieves device info
  final BluetoothDevice device;

  @override
  State<GatheringScreen> createState() => _GatheringScreenState();
}

class _GatheringScreenState extends State<GatheringScreen> {
  late BluetoothCharacteristic _characteristics;
  late StreamSubscription<List<int>> bleReceive;
//for loading
  bool hasInternet = false;
  bool _isLoading = false;

//data from sensor
  double temperature = 0.00;
  double humidity = 0.00;
  double moisture = 0.00;
  double lux = 0.00;

//data from firebase
  double mintemp = 0.00;
  double maxtemp = 0.00;
  double minhum = 0.00;
  double maxhum = 0.00;
  double minmst = 0.00;
  double maxmst = 0.00;
  double minlux = 0.00;
  double maxlux = 0.00;
  String locationinfo =
      'Increase Temperature. The plant grows best in a warmer location. You need atleast for your plant to grow at best condition';
  String illuminationinfo =
      'ncrease Temperature. The plant grows best in a warmer location. You need atleast for your plant to grow at best condition';
  String waterlevelinfo =
      'ncrease Temperature. The plant grows best in a warmer location. You need atleast for your plant to grow at best condition';

//for luminance
  double neededlux = 0.00;

  //for location
  late double moretemp = 0.00;
  late double lesstemp = 0.00;

//icon change
  bool isGood = false;
  //bluetooth
  bool isReconnect = false;
  Timer? timer;
  double widget1Opacity = 0.00;
  double widget2Opacity = 0.00;
  double widget3Opacity = 0.00;
  double widget4Opacity = 0.00;
  //Initiate variables when screen starts
  @override
  void initState() {
    super.initState();
    _characteristics = widget.characteristics;
    _listenBluetoothConnectionStatus();
    _receiveFromBT();

    Future.delayed(const Duration(milliseconds: 300), () {
      widget1Opacity = 1;
    });
    Future.delayed(const Duration(milliseconds: 400), () {
      widget2Opacity = 1;
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      widget3Opacity = 1;
    });
    Future.delayed(const Duration(milliseconds: 600), () {
      widget4Opacity = 1;
    });
  }

  //Cancel or remove all listeners when leaves
  @override
  void dispose() {
    bleReceive.cancel();
    timer!.cancel();
    super.dispose();
  }

  late final Stream<QuerySnapshot> species = FirebaseFirestore.instance
      .collection('SPECIES')
      .where('DOCID', isEqualTo: widget.plantSpecie)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => Future.value(false),
        child: Scaffold(
            appBar: AppBar(
              title: Text('${widget.plantName} - ${widget.plantSpecie} : Data'),
              centerTitle: true,
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  onPressed: () async {
                    await widget.device.disconnect();
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            body: StreamBuilder<QuerySnapshot>(
                stream: species,
                builder: (
                  BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot,
                ) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong!');
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Column(children: const <Widget>[
                      CircularProgressIndicator(
                        color: Color.fromARGB(255, 18, 64, 38),
                      ),
                      Text('Loading Data Please Wait...'),
                    ]);
                  }

                  final data = snapshot.requireData;

                  return ListView.builder(
                      itemCount: data.size,
                      itemBuilder: (context, index) {
                        mintemp =
                            double.parse('${data.docs[index]['MINTEMP']}');
                        maxtemp =
                            double.parse('${data.docs[index]['MAXTEMP']}');
                        minhum = double.parse('${data.docs[index]['MINHUM']}');
                        maxhum = double.parse('${data.docs[index]['MAXHUM']}');
                        minmst = double.parse('${data.docs[index]['MINMST']}');
                        maxmst = double.parse('${data.docs[index]['MAXMST']}');
                        minlux = double.parse('${data.docs[index]['MINLUX']}');
                        maxlux = double.parse('${data.docs[index]['MAXLUX']}');
                        neededlux = minlux - lux;
                        moretemp = mintemp - temperature;
                        lesstemp = temperature - maxtemp;
                        //for luminance

                        return Center(
                          child: Column(children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    AnimatedOpacity(
                                        opacity: widget1Opacity,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.thermostat_outlined,
                                              color: getTempColor(temperature),
                                              size: 80,
                                            ),
                                            const Text(
                                              'Temperature',
                                              style: TextStyle(
                                                fontSize: 15,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              '$temperature °C',
                                              style: const TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        )),
                                    AnimatedOpacity(
                                        opacity: widget2Opacity,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.water_outlined,
                                              color: getHumColor(humidity),
                                              size: 80,
                                            ),
                                            const Text(
                                              'Humidity',
                                              style: TextStyle(
                                                fontSize: 15,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              '$humidity %',
                                              style: const TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        )),
                                  ]),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    AnimatedOpacity(
                                        opacity: widget3Opacity,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.water_drop_outlined,
                                              color: getMstColor(moisture),
                                              size: 100,
                                            ),
                                            const Text(
                                              'Soil Moisture',
                                              style: TextStyle(
                                                fontSize: 15,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              '$moisture %',
                                              style: const TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        )),
                                    AnimatedOpacity(
                                        opacity: widget4Opacity,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.lightbulb_outline,
                                              color: getLightColor(lux),
                                              size: 80,
                                            ),
                                            const Text(
                                              'Lux',
                                              style: TextStyle(
                                                fontSize: 15,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              '$lux lx',
                                              style: const TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        )),
                                  ]),
                            ),

////////////// recommendation boxes starts here ////////////////////////////////////////////////
                            ///
                            Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: locationContainer(),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    alignment: Alignment.center,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(children: [
                                            Container(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                width: 50,
                                                height: 50,
                                                child: (temperature > mintemp &&
                                                            temperature <
                                                                maxtemp) &&
                                                        (humidity > minhum &&
                                                            humidity < maxhum)
                                                    ? Icon(
                                                        Icons
                                                            .check_circle_outline,
                                                        color: locationIcon(),
                                                        size: 50,
                                                      )
                                                    : Icon(
                                                        Icons.cancel_outlined,
                                                        color: locationIcon(),
                                                        size: 50,
                                                      )),
                                            Expanded(
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Text(
                                                        'Location:',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black87,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            fontFamily:
                                                                'AvenirLight'),
                                                      ),
                                                      Text(
                                                        locationresult(
                                                            temperature,
                                                            humidity),
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.black87,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            fontFamily:
                                                                'AvenirLight'),
                                                      ),
                                                      Text(
                                                        locationinfo,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.black87,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w100,
                                                            fontFamily:
                                                                'AvenirLight'),
                                                      )
                                                    ]),
                                              ),
                                            ),
                                          ]),
                                        ]),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: waterlevelContainer(),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    alignment: Alignment.center,
                                    child: Column(children: [
                                      Row(children: [
                                        Container(
                                            padding: const EdgeInsets.all(5),
                                            width: 50,
                                            height: 50,
                                            child: moisture > minmst &&
                                                    moisture < maxmst
                                                ? Icon(
                                                    Icons.check_circle_outline,
                                                    color: waterlevelIcon(),
                                                    size: 50,
                                                  )
                                                : Icon(
                                                    Icons.cancel_outlined,
                                                    color: waterlevelIcon(),
                                                    size: 50,
                                                  )),
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            padding: const EdgeInsets.all(5),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Text(
                                                    'Water Level:',
                                                    style: TextStyle(
                                                        color: Colors.black87,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        fontFamily:
                                                            'AvenirLight'),
                                                  ),
                                                  Text(
                                                    waterlevelresult(moisture),
                                                    style: const TextStyle(
                                                        color: Colors.black87,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontFamily:
                                                            'AvenirLight'),
                                                  ),
                                                  Text(
                                                    waterlevelinfo,
                                                    style: const TextStyle(
                                                        color: Colors.black87,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w100,
                                                        fontFamily:
                                                            'AvenirLight'),
                                                  )
                                                ]),
                                          ),
                                        ),
                                      ]),
                                    ]),
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 20, 20, 0),
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: luminanceContainer(),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      alignment: Alignment.center,
                                      child: Column(children: [
                                        Row(children: [
                                          Container(
                                              padding: const EdgeInsets.all(5),
                                              width: 50,
                                              height: 50,
                                              child: lux > minlux &&
                                                      lux < maxlux
                                                  ? Icon(
                                                      Icons
                                                          .check_circle_outline,
                                                      color: luminanceIcon(),
                                                      size: 50,
                                                    )
                                                  : Icon(
                                                      Icons.cancel_outlined,
                                                      color: luminanceIcon(),
                                                      size: 50,
                                                    )),
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              padding: const EdgeInsets.all(5),
                                              child: Column(children: [
                                                const Text(
                                                  'Luminance:',
                                                  style: TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontFamily:
                                                          'AvenirLight'),
                                                ),
                                                Text(
                                                  illuminationresult(lux),
                                                  style: const TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontFamily:
                                                          'AvenirLight'),
                                                ),
                                                Text(
                                                  illuminationinfo,
                                                  style: const TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w100,
                                                      fontFamily:
                                                          'AvenirLight'),
                                                )
                                              ]),
                                            ),
                                          ),
                                        ]),
                                      ]),
                                    )),
                              ],
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    onPrimary: const Color.fromARGB(
                                        255, 199, 217, 137),
                                    primary:
                                        const Color.fromARGB(255, 18, 64, 38),
                                    elevation: 20,
                                    minimumSize: const Size(200, 60),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 90)),
                                onPressed: () async {
                                  hasInternet =
                                      await InternetConnectionChecker()
                                          .hasConnection;

                                  await FirebaseFirestore.instance
                                      .collection("PLANTS")
                                      .where('Plant_Id',
                                          isEqualTo: widget.qrResult)
                                      .get()
                                      .then((val) => val.docs.forEach((doc) => {
                                            doc.reference.set({
                                              'Temp_Record': temperature,
                                              'Light_Record': lux,
                                              'Moist_Record': moisture,
                                              'Hum_Record': humidity
                                            }, SetOptions(merge: true)).then(
                                                (value) {})
                                          }));
                                  setState(() =>
                                      hasInternet ? _isLoading = true : false);
                                  await Future.delayed(
                                      const Duration(seconds: 2));

                                  hasInternet
                                      ? Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const PlantInfo(
                                                    qrResult: 'qrResult',
                                                  )),
                                        )
                                      : ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              "No Internet",
                                            ),
                                          ),
                                        );
                                },
                                child: _isLoading
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : const Text(
                                        'Save and Close',
                                        style: TextStyle(fontSize: 20),
                                      )),
                          ]),
                        );
                      });
                })));
  }

  locationresult(double temperature, double humidity) {
    if (temperature < mintemp && humidity < minhum) {
      return "Cold. The ${widget.plantSpecie} grows best in a warmer and humid environment.";
    } else if ((temperature > mintemp && temperature < maxtemp) &&
        (humidity > minhum && humidity < maxhum)) {
      return "Good. The location is ideal for your ${widget.plantSpecie}";
    } else if ((temperature < mintemp) &&
        (humidity > minhum && humidity < maxhum)) {
      return "Increase Temperature. The plant grows best in a warmer location. You need atleast $moretemp for your plant to grow at best condition ";
    } else if ((temperature > maxtemp) &&
        (humidity > minhum && humidity < maxhum)) {
      return "Decrease Temperature. You need atleast $lesstemp for your plant to grow at appropriate condition. Try placing it in a colder location. ";
    } else if ((temperature > mintemp && temperature < maxtemp) &&
        (humidity < minhum)) {
      return "Increase Humidity. You can try misting from time to time, group it with other plants, or use a humidifier.";
    } else if ((temperature > mintemp && temperature < maxtemp) &&
        (humidity > maxhum)) {
      return "Decrease Humidity. ${widget.plantSpecie} requires less humidity. Try using dehumidifier or change the location.";
    } else {
      return "Hot. The plant grows best in a warmer and less humid environment";
    }
  }

  locationIcon() {
    if (temperature < mintemp && humidity < minhum) {
      return const Color.fromARGB(255, 125, 46, 46);
    } else if ((temperature > mintemp && temperature < maxtemp) &&
        (humidity > minhum && humidity < maxhum)) {
      return const Color.fromARGB(255, 11, 121, 14);
    } else if ((temperature < mintemp) &&
        (humidity > minhum && humidity < maxhum)) {
      return const Color.fromARGB(255, 110, 121, 11);
    } else if ((temperature > maxtemp) &&
        (humidity > minhum && humidity < maxhum)) {
      return const Color.fromARGB(255, 110, 121, 11);
    } else if ((temperature > mintemp && temperature < maxtemp) &&
        (humidity < minhum)) {
      return const Color.fromARGB(255, 110, 121, 11);
    } else if ((temperature > mintemp && temperature < maxtemp) &&
        (humidity > maxhum)) {
      return const Color.fromARGB(255, 110, 121, 11);
    } else {
      return const Color.fromARGB(255, 125, 46, 46);
    }
  }

  locationContainer() {
    if (temperature < mintemp && humidity < minhum) {
      return const Color.fromARGB(255, 231, 138, 138);
    } else if ((temperature > mintemp && temperature < maxtemp) &&
        (humidity > minhum && humidity < maxhum)) {
      return const Color.fromARGB(255, 119, 217, 137);
    } else if ((temperature < mintemp) &&
        (humidity > minhum && humidity < maxhum)) {
      return const Color.fromARGB(255, 210, 217, 119);
    } else if ((temperature > maxtemp) &&
        (humidity > minhum && humidity < maxhum)) {
      return const Color.fromARGB(255, 210, 217, 119);
    } else if ((temperature > mintemp && temperature < maxtemp) &&
        (humidity < minhum)) {
      return const Color.fromARGB(255, 210, 217, 119);
    } else if ((temperature > mintemp && temperature < maxtemp) &&
        (humidity > maxhum)) {
      return const Color.fromARGB(255, 210, 217, 119);
    } else {
      return const Color.fromARGB(255, 231, 138, 138);
    }
  }

  //Function to get color depending on the temperature
  Color getTempColor(double temperature) {
    if (temperature < mintemp) {
      return Colors.blue;
    } else if (temperature > mintemp && temperature < mintemp) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  //Function to get color depending on the humidity
  Color getHumColor(double humidity) {
    if (humidity < minhum) {
      return Colors.blue;
    } else if (humidity > minhum && humidity < maxhum) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  //Luminance
  Color luminanceIcon() {
    if (lux < minlux) {
      return const Color.fromARGB(255, 125, 46, 46);
    } else if (lux > minlux && lux < maxlux) {
      return const Color.fromARGB(255, 11, 121, 14);
    } else {
      return const Color.fromARGB(255, 125, 46, 46);
    }
  }

  Color luminanceContainer() {
    if (lux < minlux) {
      return const Color.fromARGB(255, 231, 138, 138);
    } else if (lux > minlux && lux < maxlux) {
      return const Color.fromARGB(255, 119, 217, 137);
    } else {
      return const Color.fromARGB(255, 231, 138, 138);
    }
  }

  String illuminationresult(double lux) {
    if (lux < minlux) {
      return "Increase Light. ${widget.plantSpecie} needs atleast $neededlux lx more to grow at best condition.";
    } else if (lux > minlux && lux < maxlux) {
      // setState(() {
      //   isGood = true;
      // });
      return "Fine. The amount of light is appropriate for ${widget.plantSpecie} ";
    } else {
      return "Decrease Light. The amount of light the ${widget.plantSpecie} receives is more than what it needs.";
    }
  }

  //Function to get color depending on the lux
  Color getLightColor(double lux) {
    if (lux < minlux) {
      return Colors.blue;
    } else if (lux > minlux && lux < maxlux) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  waterlevelContainer() {
    if (moisture < minmst) {
      return const Color.fromARGB(255, 231, 138, 138);
    } else if (moisture > minmst && moisture < maxmst) {
      return const Color.fromARGB(255, 119, 217, 137);
    } else {
      return const Color.fromARGB(255, 231, 138, 138);
    }
  }

  waterlevelIcon() {
    if (moisture < minmst) {
      return const Color.fromARGB(255, 125, 46, 46);
    } else if (moisture > minmst && moisture < maxmst) {
      return const Color.fromARGB(255, 11, 121, 14);
    } else {
      return const Color.fromARGB(255, 125, 46, 46);
    }
  }

  waterlevelresult(double moisture) {
    if (moisture < minmst) {
      return "Low. You need to add atmost (insert amount of water here) for to reach $maxmst moisture which is the maximum recomended moisture for ${widget.plantSpecie}";
    } else if (moisture > minmst && moisture < maxmst) {
      return "Good. ${widget.plantSpecie} is having enough soil moisture";
    } else {
      return "High. $moisture is more than the recommended soil moisture for ${widget.plantSpecie}";
    }
  }

  //Function to get color depending on the moisture
  Color getMstColor(double moisture) {
    if (moisture < minmst) {
      return Colors.blue;
    } else if (moisture > minmst && moisture < maxmst) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
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
              temperature = 0;
              humidity = 0;
              lux = 0;
              moisture = 0;
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
}
