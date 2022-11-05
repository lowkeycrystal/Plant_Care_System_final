import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import 'dart:async';
import 'package:line_icons/line_icons.dart';
import 'package:flutter_close_app/flutter_close_app.dart';

void main() {
  runApp(const PlantInfo(
    qrResult: '',
  ));
}

class PlantInfo extends StatefulWidget {
  final String qrResult;
  const PlantInfo({Key? key, required this.qrResult}) : super(key: key);

  @override
  _PlantInfoState createState() {
    return _PlantInfoState();
  }
}

class _PlantInfoState extends State<PlantInfo> {
  late String qrResult = widget.qrResult;

  @override
  void initState() {
    super.initState();
    qrResult = widget.qrResult;
  }

  // late List<charts.Series<Temp, String>> _seriesBarData;
  // late List<Temp> mydata;
  // _generateData(mydata) {
  //   _seriesBarData = <charts.Series<Temp, String>>[];
  //   _seriesBarData.add(
  //     charts.Series(
  //       domainFn: (Temp temp, _) => temp.time.toString(),
  //       measureFn: (Temp temp, _) => temp.temp,
  //       colorFn: (Temp temp, _) => charts.MaterialPalette.green.shadeDefault,
  //       id: 'Temperature Data',
  //       data: mydata,
  //       labelAccessorFn: (Temp row, _) => row.time,
  //     ),
  //   );
  // }

  // late final Stream<QuerySnapshot> temperature = FirebaseFirestore.instance
  //     .collection('PLANTS')
  //     .doc('aixTxzmX48fGe8g3Uc1S')
  //     .collection('temp_data')
  //     .snapshots();

  late final Stream<QuerySnapshot> plants = FirebaseFirestore.instance
      .collection('PLANTS')
      .where('Plant_Id', isEqualTo: widget.qrResult)
      .snapshots();

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
              body: Center(
                child: StreamBuilder<QuerySnapshot>(
                  stream: plants,
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
                        return SingleChildScrollView(
                          child: Column(children: <Widget>[
                            Padding(
                                padding: const EdgeInsets.all(1),
                                child: Container(
                                    margin: const EdgeInsets.fromLTRB(
                                        20, 30, 20, 0),
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 119, 217, 137),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 10, 0, 0),
                                          height: 80,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 18, 64, 38),
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: const Icon(
                                            LineIcons.pagelines,
                                            color: Color.fromARGB(
                                                255, 199, 217, 137),
                                            size: 50,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          '${data.docs[index]['Plant_Name']}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          '${data.docs[index]['Plant_Variety']}',
                                          style: const TextStyle(
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 20,
                                            fontFamily: 'AvenirLight',
                                          ),
                                        ),
                                        Text(
                                          '${data.docs[index]['Plant_Specie']}',
                                          style: const TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontFamily: 'AvenirLight',
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Current Height: ${data.docs[index]['Pot_Height']} inches',
                                                style: const TextStyle(
                                                  fontFamily: 'AvenirLight',
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              Text(
                                                'Current Age: ${data.docs[index]['Pot_TopDiameter']} months',
                                                style: const TextStyle(
                                                  fontFamily: 'AvenirLight',
                                                ),
                                              ),
                                            ]),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          'Current Number of Leaves: ${data.docs[index]['Pot_BaseDiameter']} leaves',
                                          style: const TextStyle(
                                            fontFamily: 'AvenirLight',
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 0, 20, 20),
                                          child: Text(
                                            '"${data.docs[index]['Short_Desc']}"',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontFamily: 'AvenirLight',
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: ElevatedButton(
                                            child: const Text(
                                              'Update',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                                onPrimary: const Color.fromARGB(
                                                    255, 199, 217, 137),
                                                primary: const Color.fromARGB(
                                                    255, 18, 64, 38),
                                                elevation: 0,
                                                minimumSize: const Size(70, 20),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 15,
                                                        horizontal: 30)),
                                            onPressed: () {},
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ))),
                            const SizedBox(
                              height: 40,
                            ),
                            // StreamBuilder<QuerySnapshot>(
                            //   stream: temperature,
                            //   builder: (
                            //     BuildContext context,
                            //     AsyncSnapshot<QuerySnapshot> snapshot,
                            //   ) {
                            //     if (!snapshot.hasData) {
                            //       return const LinearProgressIndicator();
                            //     } else {
                            //       List<Temp> temperature = snapshot.data!.docs
                            //           .map((documentSnapshot) => Temp.fromMap(
                            //               documentSnapshot.data
                            //                   as Map<String, dynamic>))
                            //           .toList();
                            //       return _buildChart(context, temperature);
                            //     }
                            //   },
                            // ),
                            const SizedBox(
                              height: 40,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: ElevatedButton(
                                child: const Text(
                                  'Gather Environment Data',
                                  style: TextStyle(fontSize: 20),
                                ),
                                style: ElevatedButton.styleFrom(
                                  onPrimary:
                                      const Color.fromARGB(255, 199, 217, 137),
                                  primary:
                                      const Color.fromARGB(255, 18, 64, 38),
                                  elevation: 20,
                                  minimumSize: const Size(300, 50),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ]),
                        );
                      },
                    );
                  },
                ),
              )),
        ));
  }

  // Widget _buildChart(BuildContext context, List<Temp> tempdata) {
  //   mydata = tempdata;
  //   _generateData(mydata);
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: Center(
  //       child: Column(
  //         children: <Widget>[
  //           const Text(
  //             'Sales by Year',
  //             style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
  //           ),
  //           const SizedBox(
  //             height: 10.0,
  //           ),
  //           Expanded(
  //             child: charts.BarChart(
  //               _seriesBarData,
  //               animate: true,
  //               animationDuration: const Duration(seconds: 3),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
