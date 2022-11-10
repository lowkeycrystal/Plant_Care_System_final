import 'package:carousel_slider/carousel_slider.dart';
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
        title: 'Supported Plants',
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
          color: Color.fromARGB(255, 18, 64, 38),
        )),
        home: Scaffold(
          appBar: AppBar(
            iconTheme:
                const IconThemeData(color: Color.fromARGB(255, 199, 217, 137)),
            centerTitle: true,
            title: const Text(
              'Supported Plants',
              style: TextStyle(color: Color.fromARGB(255, 199, 217, 137)),
            ),
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 199, 217, 137),
          body: ListView(
            children: [
              CarouselSlider(
                  items: [
                    SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: Column(
                        children: [
                          Container(
                            height: 400,
                            width: 300,
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.only(
                              bottom: 30,
                              right: 30,
                              left: 30,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 20,
                                    offset: Offset(4, 8),
                                  ),
                                ],
                                image: const DecorationImage(
                                    image: AssetImage('assets/alocasia.jpg'))),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              bottom: 30,
                              right: 30,
                              left: 30,
                              top: 60,
                            ),
                            child: const Text(
                              'Alocasia',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              bottom: 30,
                              right: 30,
                              left: 30,
                              top: 10,
                            ),
                            child: const Text(
                              'Alocasia is an Aroid family genus that contains about 70 species of large-leaved, rhizomatous and tuberous perennials which typically grow 2-6 inches tall. Long-stalked, arrowhead-shaped to heart-shaped leaves, often dramatically decorated and colorfully adorned, range in size, depending upon species, from 8” to 36” long.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: Column(
                        children: [
                          Container(
                            height: 400,
                            width: 300,
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.only(
                              bottom: 30,
                              right: 30,
                              left: 30,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 20,
                                    offset: Offset(4, 8),
                                  ),
                                ],
                                image: const DecorationImage(
                                  image: AssetImage('assets/anthurium.jpg'),
                                  fit: BoxFit.cover,
                                )),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              bottom: 30,
                              right: 30,
                              left: 30,
                              top: 60,
                            ),
                            child: const Text(
                              'Anthurium',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              bottom: 30,
                              right: 30,
                              left: 30,
                              top: 10,
                            ),
                            child: const Text(
                              'Anthurium species can grow terrestrially or as epiphytes on other plants. The inflorescence, commonly called the flower, consists of a colourful shiny leathery spathe surrounding or subtending a central rodlike spadix that bears numerous tiny bisexual flowers. The leaves are somewhat leathery and variable in shape.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: Column(
                        children: [
                          Container(
                            height: 400,
                            width: 300,
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.only(
                              bottom: 30,
                              right: 30,
                              left: 30,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 20,
                                    offset: Offset(4, 8),
                                  ),
                                ],
                                image: const DecorationImage(
                                  image: AssetImage('assets/calathea.jpg'),
                                  fit: BoxFit.cover,
                                )),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              bottom: 30,
                              right: 30,
                              left: 30,
                              top: 60,
                            ),
                            child: const Text(
                              'Calathea',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              bottom: 30,
                              right: 30,
                              left: 30,
                              top: 10,
                            ),
                            child: const Text(
                              'Calatheas are known for their striking patterned foliage, with the undersides of their leaves often being tinged with purplish-red hues. The leaves come in many different shapes, sizes, and patterns, but most wont grow larger than about 3 feet.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: Column(
                        children: [
                          Container(
                            height: 400,
                            width: 300,
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.only(
                              bottom: 30,
                              right: 30,
                              left: 30,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 20,
                                    offset: Offset(4, 8),
                                  ),
                                ],
                                image: const DecorationImage(
                                  image: AssetImage('assets/monstera.jpg'),
                                  fit: BoxFit.cover,
                                )),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              bottom: 30,
                              right: 30,
                              left: 30,
                              top: 60,
                            ),
                            child: const Text(
                              'Monstera',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              bottom: 30,
                              right: 30,
                              left: 30,
                              top: 10,
                            ),
                            child: const Text(
                              'The Swiss cheese plant, or Mexican breadfruit (Monstera deliciosa), is a common houseplant with showy, glossy, perforated leaves slashed to the margins; numerous horticultural varieties have been developed. When fully ripe, its sweet scaly fruit is edible and tastes like a combination of pineapple and mango.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: Column(
                        children: [
                          Container(
                            height: 400,
                            width: 300,
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.only(
                              bottom: 30,
                              right: 30,
                              left: 30,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 20,
                                    offset: Offset(4, 8),
                                  ),
                                ],
                                image: const DecorationImage(
                                  image: AssetImage('assets/philodendron.jpg'),
                                  fit: BoxFit.cover,
                                )),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              bottom: 30,
                              right: 30,
                              left: 30,
                              top: 60,
                            ),
                            child: const Text(
                              'Philodendron',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              bottom: 30,
                              right: 30,
                              left: 30,
                              top: 10,
                            ),
                            child: const Text(
                              'The foliage of philodendrons is usually green but may be coppery, red, or purplish; parallel leaf veins are usually green or sometimes red or white. Shape, size, and texture of the leaves vary considerably, depending on species and maturity of the plant. The fruit is a white to orange berry.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: Column(
                        children: [
                          Container(
                            height: 400,
                            width: 300,
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.only(
                              bottom: 30,
                              right: 30,
                              left: 30,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 20,
                                    offset: Offset(4, 8),
                                  ),
                                ],
                                image: const DecorationImage(
                                  image: AssetImage('assets/rhaphidophora.jpg'),
                                  fit: BoxFit.cover,
                                )),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              bottom: 30,
                              right: 30,
                              left: 30,
                              top: 60,
                            ),
                            child: const Text(
                              'Rhaphidophora',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              bottom: 30,
                              right: 30,
                              left: 30,
                              top: 10,
                            ),
                            child: const Text(
                              'Rhaphidophora is a genus that contains around 100 species native to south-east Asia. This mini Monstera is considered an exotic jungle plant, but it can also be found in rainforests or dry climates making it an easy-to-grow houseplant. However, hanging these plants can result in smaller leaves without splits.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                  options: CarouselOptions(
                    height: 1000,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    viewportFraction: 1.0,
                  )),
              Container(
                margin: const EdgeInsets.only(top: 15, left: 50, right: 50),
                child: const Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    'Plant Tips',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 45),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15, left: 50, right: 50),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                child: Column(children: [
                  const Text(
                    'Alocasia',
                    style: TextStyle(
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                  const Text(
                      'Alocasia Rugosa (Alocasia melo), Black Magic (Alocasia infernalis), Black Velvet (Alocasia reginula), Brina (Alocasia zebrina), Green Velvet (Alocasia micholitziana frydek), Giant Taro (Alocasia macrorrhizos), Dragon Scale (Alocasia bagindas), Malaysian Monster (Alocasia portei), Night-scented Lily (Alocasia odora), Tiger Taro (Alocasia longiloba)'),
                  ExpansionTile(
                    iconColor: Colors.green,
                    title: const Text(
                      'Healthy Tips',
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: const <Widget>[
                              Text(
                                  "Alocasias need bright, but indirect light. This is due to the plant's natural habitat, on the forest floor beneath the tree canopy. Direct sun will cause the leaves to burn, so avoid placing your Alocasia in a spot where it'll be exposed to direct sun for a prolonged period.")
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15, left: 50, right: 50),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                child: Column(children: [
                  const Text(
                    'Anthurium',
                    style: TextStyle(
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                  const Text(
                      "Flamingo Lily (Anthurium andreanum), King Anthurium (Anthurium veitchii), Queen Anthurium (Anthurium warocqueanum), Black Anthurium (Anthurium watermaliense), Bird's Nest Anthurium (Anthurium hookeri), Pearl Laceleaf (Anthurium scandens), Anthurium Ace of Spades (Anthurium crystallinum), (Anthurium forgetii), (Anthurium magnificum), (Anthurium scherzerianum)"),
                  ExpansionTile(
                    iconColor: Colors.green,
                    title: const Text(
                      'Healthy Tips',
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: const <Widget>[
                              Text(
                                  "Spritz daily to keep this plant happy or set up a humidifier to mimic its natural environment. Spray the aerial roots with water to ensure they stay moist as well (the roots that may be above the ground). You can also set up a pebble tray with water and set them on to create adequate humidity levels.")
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15, left: 50, right: 50),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                child: Column(children: [
                  const Text(
                    'Calathea',
                    style: TextStyle(
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                  const Text(
                      'Round-leaf Calathea (Calathea orbifolia), Rattlesnake Plant (Calathea lancifolia), Fury Feather (Calathea rufibarba), Corona (Calathea roseopicta), Rosey (Calathea roseopicta "Rosey"), Jungle Velvet (Calathea warscewiczii), Peacock Calathea (Calathea makoyana), Eternal Flame (Calathea crocata), Pin-stripe (Calathea ornata), Zebra Calathea (Calathea zebrina)'),
                  ExpansionTile(
                    iconColor: Colors.green,
                    title: const Text(
                      'Healthy Tips',
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: const <Widget>[
                              Text(
                                  "Calatheas do best in a humid environment, so mist the leaves daily with tepid water or stand on a tray of gravel or pebbles that is topped up with water. Feed your calathea every couple of months with a balanced fertiliser. Wipe the leaves occasionally to remove dust.")
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15, left: 50, right: 50),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                child: Column(children: [
                  const Text(
                    'Monstera',
                    style: TextStyle(
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                  const Text(
                    "Borsigiana (Monstera borsigiana), Swiss Cheese Plant (Monstera deliciosa), Albo Variegata (Monstera deliciosa 'Albo Variegata), Adansonii (Monstera adansonii), Dubia (Monstera dubia), Pinnatipartita (Monstera pinnatipartita), Silver Monstera (Monstera siltepecana), Obliqua (Monstera obliqua), Thai Constellation (Monstera deliciosa 'Thai Constellation'), Borsigiana Variegata (Monstera borsigiana variegata)",
                  ),
                  ExpansionTile(
                    iconColor: Colors.green,
                    title: const Text(
                      'Healthy Tips',
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: const <Widget>[
                              Text(
                                  "Monsteras prefer a soil that is peaty and well-draining since an over moistened one that stays soggy or overly wet can cause root rot. You can water weekly and ensure any excess water drains away. While the monstera deliciosa don't like being overwatered, they love being humid.")
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15, left: 50, right: 50),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                child: Column(children: [
                  const Text(
                    'Philodendron',
                    style: TextStyle(
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                  const Text(
                    "Heartleaf Philodendron (Philodendron hederaceum), Red Leaf Philodendron (Philodendron erubescens), Elephant Ear Philodendron (Philodendron domesticum), Moonlight Philodendron (Philodendron 'Moonlight'), Winterbourn Philodendron (Philodendron Xanadu), Fiddleleaf Philodendron (Philodendron bipennifolium), White Knight Philodendron (Philodendron 'White Knight'), Prince of Orange Philodendron (Philodendron 'Prince of Orange'), Tree Philodendron (Philodendron selloum), Brasil Philodendron (Philodendron hederaceum 'Brasil')",
                  ),
                  ExpansionTile(
                    iconColor: Colors.green,
                    title: const Text(
                      'Healthy Tips',
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: const <Widget>[
                              Text(
                                  "They don't like to remain soaking wet, so stick your finger in the soil a few inches before watering; if it feels moist, wait a few days and check again. If it's dry or dusty-feeling (or if the leaves are curling back because it's saying, “Help!”), it's time to water. Use lukewarm water; tap water is fine.")
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
              Container(
                margin: const EdgeInsets.only(
                    top: 15, left: 50, right: 50, bottom: 25),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                child: Column(children: [
                  const Text(
                    'Rhaphidophora',
                    style: TextStyle(
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                  const Text(
                    "Rhaphidophora tetrasperma, Rhaphidophora decursiva, Rhaphidophora hayi, Rhaphidophora cryptantha, Rhaphidophora pertusa, Rhaphidophora foraminifera, Rhaphidophora korthalsii, Rhaphidophora pachyphylla, Rhaphidophora beccarii, Rhaphidophora tenuis",
                  ),
                  ExpansionTile(
                    iconColor: Colors.green,
                    title: const Text(
                      'Healthy Tips',
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: const <Widget>[
                              Text(
                                  "To care for Rhaphidophora tetrasperma place the plant in bright, indirect sunlight. Plant in a well-draining potting soil mix. Fertilize Rhaphidophora tetrasperma monthly with a balanced fertilizer. The best temperature range is 68°F to 80°F (16°C – 27°C).")
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            ],
          ),
        ));
  }
}
