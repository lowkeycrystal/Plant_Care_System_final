// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_close_app/flutter_close_app.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:plant_care_system/screens/plant_profile.dart';
import 'package:plant_care_system/shared/constant.dart';

void main() {
  runApp(const UpdateInfo(
    qrResult: '',
  ));
}

class UpdateInfo extends StatefulWidget {
  final String qrResult;
  const UpdateInfo({Key? key, required this.qrResult}) : super(key: key);

  @override
  UpdateInfoState createState() {
    return UpdateInfoState();
  }
}

class UpdateInfoState extends State<UpdateInfo> {
  late String qrResult = widget.qrResult;

  @override
  void initState() {
    super.initState();
    qrResult = widget.qrResult;
  }

  bool hasInternet = false;
  bool _isLoading = false;

  var plantName = '';
  var plantVariety = '';
  var plantSpecie = '';
  var potHeight = 0;
  var potLength = 0;
  var potWidth = 0;
  var potTopDiameter = 0;
  var potBaseDiameter = 0;
  var potType = '';
  var shortDesc = '';
  var plantId = '';

  final _formKey = GlobalKey<FormState>();

  List<String> pot = ['Box/Rectangle', 'Conical', 'Round'];

  List<String> varieties = [
    'Alocasia',
    'Anthurium',
    'Calathea',
    'Monstera',
    'Philodendron'
  ];
  List<String> alocasiaSpecies = [
    'Alocasia Azlanii',
    'Alocasia Black Velvet',
    'Alocasia Lutea Golden',
    'Alocasia Pink Dragon',
    'Alocasia Polly',
    'Alocasia Purple Sword'
  ];
  List<String> anthuriumSpecies = [
    'Anthurium Big and Bold',
    'Anthurium Pink',
    'Anthurium Red',
    'Anthurium Ruffles'
  ];
  List<String> calatheaSpecies = [
    'Calathea Beauty Star',
    'Calathea Dottie',
    'Calathea Freddie',
    'Calathea Medallion',
    'Calathea Misto',
    'Calathea Musaica',
    'Goeppertia Orbifolia',
    'Calathea Peacock',
    'Calathea Pinstripe',
    'Calathea Rattlesnake',
    'Calathea Rosy Roseo',
    'Calathea Vittata',
    'Calathea White Flame',
    'Calathea Zebra'
  ];
  List<String> monsteraSpecies = [
    'Monstera',
    'Monstera Adansonii',
    'Monstera sp. (Peru)',
    'Monstera Dubia'
  ];
  List<String> philodendronSpecies = [
    'Philodendron Birkin',
    'Philodendron Brandi',
    'Philodendron Brasil',
    'Philodendron Heartleaf',
    'Philodendron Hope Selloum',
    'Philodendron Lemon Lime',
    'Philodendron Little Hope',
    'Philodendron Micans Velvet',
    'Philodendron Pink Princess',
    'Philodendron Prince of Orange',
    'Philodendron Shangri La',
    'Philodendron Velvet',
    'Philodendron Xanadu'
  ];

  List<String> species = [];
  String? _selectedVarieties;
  String? _selectedSpecies;

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
            automaticallyImplyLeading: false,
            iconTheme:
                const IconThemeData(color: Color.fromARGB(255, 199, 217, 137)),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
            backgroundColor: Colors.transparent,
            bottomOpacity: 0.0,
            title: const Text('Update Plant Info',
                style: TextStyle(
                  color: Color.fromARGB(255, 18, 64, 38),
                  fontWeight: FontWeight.bold,
                )),
            elevation: 0,
          ),
          body: StreamBuilder<QuerySnapshot>(
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
                      String selectedPotType =
                          '${data.docs[index]['Pot_Type']}';
                      TextEditingController controllerPlantName =
                          TextEditingController(
                              text: '${data.docs[index]['Plant_Name']}');
                      TextEditingController controllerShortDesc =
                          TextEditingController(
                              text: '${data.docs[index]['Short_Desc']}');
                      TextEditingController controllerTop =
                          TextEditingController(
                              text: '${data.docs[index]['Pot_TopDiameter']}');
                      TextEditingController controllerBase =
                          TextEditingController(
                              text: '${data.docs[index]['Pot_BaseDiameter']}');
                      TextEditingController controllerHeight =
                          TextEditingController(
                              text: '${data.docs[index]['Pot_Height']}');
                      TextEditingController controllerLength =
                          TextEditingController(
                              text: '${data.docs[index]['Pot_Length']}');
                      TextEditingController controllerWidth =
                          TextEditingController(
                              text: '${data.docs[index]['Pot_Width']}');

                      return Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32, vertical: 16),
                                  child: TextFormField(
                                    enabled: false,
                                    controller: controllerPlantName,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'This field cannot be empty';
                                      }
                                      return null;
                                    },
                                    decoration: textInputDecoration.copyWith(
                                      labelText: 'Plant Name',
                                      hintText:
                                          'ex. Plant 1, Anthurium 1, etc...',
                                    ),
                                    style: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 17,
                                        fontFamily: 'AvenirLight'),
                                    onChanged: null,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32, vertical: 16),
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                      canvasColor: const Color.fromARGB(
                                          255, 199, 217, 137),
                                    ),
                                    child: DropdownButtonFormField<String>(
                                      decoration: textInputDecoration.copyWith(
                                        labelText: 'Plant Variety',
                                        hintText: 'Select Plant Variety',
                                      ),
                                      value: _selectedVarieties,
                                      items: varieties.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: null,
                                      disabledHint: Text(
                                          '${data.docs[index]['Plant_Variety']}'),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32, vertical: 16),
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                      canvasColor: const Color.fromARGB(
                                          255, 199, 217, 137),
                                    ),
                                    child: DropdownButtonFormField<String>(
                                      decoration: textInputDecoration.copyWith(
                                        labelText: 'Plant Specie',
                                        hintText: 'Select Plant Specie',
                                      ),
                                      value: _selectedSpecies,
                                      items: species.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: null,
                                      disabledHint: Text(
                                          '${data.docs[index]['Plant_Specie']}'),
                                    ),
                                  ),
                                ),
                                // POTTTTTTTTTTTTTTTTTT
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32, vertical: 16),
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                      canvasColor: const Color.fromARGB(
                                          255, 199, 217, 137),
                                    ),
                                    child: DropdownButtonFormField<String>(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'This field cannot be empty';
                                        }
                                        return null;
                                      },
                                      decoration: textInputDecoration.copyWith(
                                        labelText: 'Pot Type',
                                        hintText: 'Select Pot Type',
                                      ),
                                      value: selectedPotType,
                                      items: pot.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (pot) {
                                        setState(() {
                                          selectedPotType = pot!;
                                        });
                                        selectedPotType = pot!;
                                        potType = pot;
                                        controllerTop.clear();
                                        controllerBase.clear();
                                        controllerHeight.clear();
                                        controllerLength.clear();
                                        controllerWidth.clear();
                                      },
                                    ),
                                  ),
                                ),

                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              32, 8, 8, 8),
                                          child: TextFormField(
                                            controller: controllerTop,
                                            enabled: selectedPotType ==
                                                        "Round" ||
                                                    selectedPotType == "Conical"
                                                ? true
                                                : false,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty &&
                                                      (selectedPotType ==
                                                              "Round" ||
                                                          selectedPotType ==
                                                              "Conical")) {
                                                return 'This field cannot be empty.';
                                              }
                                              return null;
                                            },
                                            decoration:
                                                textInputDecoration.copyWith(
                                              labelText: 'Pot (Top Diameter)',
                                              hintText:
                                                  'Enter top diameter of the pot',
                                            ),
                                            style: const TextStyle(
                                                color: Colors.black87,
                                                fontSize: 17,
                                                fontFamily: 'AvenirLight'),
                                            onChanged: (value) {
                                              if (selectedPotType == "Round" ||
                                                  selectedPotType ==
                                                      "Conical") {
                                                controllerTop = int.parse(value)
                                                    as TextEditingController;
                                              } else {
                                                controllerTop.clear();
                                              }
                                              // _controllerTop = value
                                              //     as TextEditingController;
                                            },
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 8, 8, 8),
                                          child: TextFormField(
                                            controller: controllerBase,
                                            enabled:
                                                selectedPotType == "Conical"
                                                    ? true
                                                    : false,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty &&
                                                      selectedPotType ==
                                                          "Conical") {
                                                return 'This field cannot be empty.';
                                              }
                                              return null;
                                            },
                                            decoration:
                                                textInputDecoration.copyWith(
                                              labelText: 'Pot (Base Diameter)',
                                              hintText:
                                                  'Enter bottom diameter of the pot',
                                            ),
                                            style: const TextStyle(
                                                color: Colors.black87,
                                                fontSize: 17,
                                                fontFamily: 'AvenirLight'),
                                            onChanged: (value) {
                                              if (selectedPotType ==
                                                  "Conical") {
                                                controllerBase = int.parse(
                                                        value)
                                                    as TextEditingController;
                                              } else {
                                                controllerBase.clear();
                                              }
                                              // _controllerBase = value
                                              //     as TextEditingController;
                                            },
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 8, 32, 8),
                                          child: TextFormField(
                                            controller: controllerHeight,
                                            enabled:
                                                selectedPotType == "Round" ||
                                                        selectedPotType ==
                                                            "Conical" ||
                                                        selectedPotType ==
                                                            "Box/Rectangle"
                                                    ? true
                                                    : false,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty &&
                                                      (selectedPotType ==
                                                              "Round" ||
                                                          selectedPotType ==
                                                              "Conical" ||
                                                          selectedPotType ==
                                                              "Box/Rectangle")) {
                                                return 'This field cannot be empty.';
                                              }
                                              return null;
                                            },
                                            decoration:
                                                textInputDecoration.copyWith(
                                              labelText: 'Pot Height',
                                              hintText: 'Enter pot height',
                                            ),
                                            style: const TextStyle(
                                                color: Colors.black87,
                                                fontSize: 17,
                                                fontFamily: 'AvenirLight'),
                                            onChanged: (value) {
                                              if (selectedPotType == "Round" ||
                                                  selectedPotType ==
                                                      "Conical" ||
                                                  selectedPotType ==
                                                      "Box/Rectangle") {
                                                controllerHeight = int.parse(
                                                        value)
                                                    as TextEditingController;
                                              } else {
                                                controllerHeight.clear();
                                              }
                                              // _controllerHeight = value
                                              //     as TextEditingController;
                                            },
                                          ),
                                        ),
                                      ),
                                    ]),

                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              32, 8, 8, 8),
                                          child: TextFormField(
                                            controller: controllerLength,
                                            enabled: selectedPotType ==
                                                    "Box/Rectangle"
                                                ? true
                                                : false,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty &&
                                                      selectedPotType ==
                                                          "Box/Rectangle") {
                                                return 'This field cannot be empty.';
                                              }
                                              return null;
                                            },
                                            decoration:
                                                textInputDecoration.copyWith(
                                              labelText: 'Length',
                                              hintText: 'Enter pot length',
                                            ),
                                            style: const TextStyle(
                                                color: Colors.black87,
                                                fontSize: 17,
                                                fontFamily: 'AvenirLight'),
                                            onChanged: (value) {
                                              if (selectedPotType ==
                                                  "Box/Rectangle") {
                                                controllerLength = int.parse(
                                                        value)
                                                    as TextEditingController;
                                              } else {
                                                controllerLength.clear();
                                              }
                                              // _controllerLength = value
                                              //     as TextEditingController;
                                              // potLength =
                                              //     _controllerLength as int;
                                            },
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 8, 32, 8),
                                          child: TextFormField(
                                            controller: controllerWidth,
                                            enabled: selectedPotType ==
                                                    "Box/Rectangle"
                                                ? true
                                                : false,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty &&
                                                      selectedPotType ==
                                                          "Box/Rectangle") {
                                                return 'This field cannot be empty.';
                                              }
                                              return null;
                                            },
                                            decoration:
                                                textInputDecoration.copyWith(
                                              labelText: 'Pot Width',
                                              hintText: 'Enter pot width',
                                            ),
                                            style: const TextStyle(
                                                color: Colors.black87,
                                                fontSize: 17,
                                                fontFamily: 'AvenirLight'),
                                            onChanged: (value) {
                                              if (selectedPotType ==
                                                  "Box/Rectangle") {
                                                controllerWidth = int.parse(
                                                        value)
                                                    as TextEditingController;
                                              } else {
                                                controllerWidth.clear();
                                              }
                                              // _controllerWidth = value
                                              //     as TextEditingController;
                                              // potWidth =
                                              //     _controllerWidth as int;
                                            },
                                          ),
                                        ),
                                      ),
                                    ]),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32, vertical: 16),
                                  child: TextFormField(
                                    controller: controllerShortDesc,
                                    maxLines: 4,
                                    decoration: textInputDecoration.copyWith(
                                      labelText: 'Short Description',
                                      hintText:
                                          'Tell something about your plant...',
                                    ),
                                    style: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 17,
                                        fontFamily: 'AvenirLight'),
                                    onChanged: (value) {
                                      shortDesc = value;
                                      // shortDesc =
                                      //     _controllerShortDesc as String;
                                    },
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 32, vertical: 16.0),
                                    child: Center(
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              onPrimary: const Color.fromARGB(
                                                  255, 199, 217, 137),
                                              primary: const Color.fromARGB(
                                                  255, 18, 64, 38),
                                              elevation: 20,
                                              minimumSize: const Size(410, 70),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                            ),
                                            onPressed: () async {
                                              hasInternet =
                                                  await InternetConnectionChecker()
                                                      .hasConnection;

                                              if (_formKey.currentState!
                                                  .validate()) {
                                                // add to database
                                                final plantUpdate =
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('PLANTS')
                                                        .where('Plant_Id',
                                                            isEqualTo:
                                                                widget.qrResult)
                                                        .limit(1)
                                                        .get()
                                                        .then((QuerySnapshot
                                                            snapshot) {
                                                  //Here we get the document reference and return to the post variable.
                                                  return snapshot
                                                      .docs[0].reference;
                                                });

                                                var batch = FirebaseFirestore
                                                    .instance
                                                    .batch();
                                                //Updates the field value, using post as document reference
                                                batch.update(plantUpdate, {
                                                  'Pot_Type': potType,
                                                  'Pot_Height':
                                                      controllerHeight,
                                                  'Pot_Length':
                                                      controllerLength,
                                                  'Pot_Width': controllerWidth,
                                                  'Pot_BaseDiameter':
                                                      controllerBase,
                                                  'Pot_TopDiameter':
                                                      controllerTop,
                                                  'Short_Desc': shortDesc
                                                });
                                                batch.commit();
                                              }
                                              // .then((value) => print('User is added'))
                                              // .catchError((error) =>
                                              //     print('Failed to add user: $error'));

                                              // loading

                                              setState(() => hasInternet
                                                  ? _isLoading = true
                                                  : false);
                                              await Future.delayed(
                                                  const Duration(seconds: 2));

                                              hasInternet
                                                  ? (Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              PlantInfo(
                                                                  qrResult:
                                                                      qrResult))))
                                                  : ScaffoldMessenger.of(
                                                          context)
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
                                                    'Update',
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ))))
                              ])));
                    });
              }),
        ),
      ),
    );
  }
}
