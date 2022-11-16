import 'package:flutter/material.dart';

void main() {
  runApp(const About());
}

class About extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const About();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'About',
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
            'About',
            style: TextStyle(color: Color.fromARGB(255, 199, 217, 137)),
          ),
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: SingleChildScrollView(
            child: Center(
          child: Column(
            children: <Widget>[
              Container(
                height: 500,
                width: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/soc.jpg'),
                        fit: BoxFit.cover)),
                child: Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            width: double.infinity,
                            child: Container(
                                margin:
                                    const EdgeInsets.only(left: 10, top: 20),
                                child: const Text(
                                  '"Taking a big step for your precious plants"',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: const Text(
                                  '“Making a significant move for your valued plants”',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: const Text(
                                  '“A helping hand for your cherished plants”',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: const Text(
                                  '“Giving your beloved plants a helping hand”',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Container(
                                margin: const EdgeInsets.only(top: 100),
                                child: const Text(
                                  'Learn more about us',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                  ),
                                )),
                          ),
                        ],
                      ),
                    )),
              ),
              Column(
                  children: const [Image(image: AssetImage('assets/ver.png'))]),
              Container(
                width: 1000,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                margin: const EdgeInsets.only(),
                child: const Text(
                  'Verdant (adjective)',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              Container(
                width: 1000,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                margin: const EdgeInsets.only(top: 20),
                child: const Text(
                  'To ensure that plants are firm and formed.',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Container(
                width: 1000,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                margin: const EdgeInsets.only(top: 20),
                child: const Text(
                  'Verdant means green with growing plants. It is our ambition to help every plant enthusiast, especially ornamental plant keepers, achieve their dream of having a beautiful, healthy, and strong plant. We are a passionate team, unified by our mission to assist every plant keeper or gardener. Everyday, we search for new ways to improve our service so that people can engage in choosing plants. But, it is not our only goal to be on top; we also want to elevate the members of the plant community. This is what we want; a healthy environment for horticulturists where information is broadened and ideas are overflowing. Millions of people will get interested. Millions will also come. When you are ready to choose what ornamental plants you are willing to take care of and you have the guts to spend time on this kind of hobby, join us!',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Container(
                width: 1000,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                margin: const EdgeInsets.only(top: 100),
                child: const Text(
                  'Our Team',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              Container(
                  width: 1000,
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  margin: const EdgeInsets.only(
                    top: 20,
                  ),
                  child: const Text(
                    'Working at Verdant means you surround yourself with intelligent and hardworking people. Here, we dont only focus on customer satisfaction but also consider our beloved staff and employees. At Verdant, there is a reason why "companionship" is one of the most important core values.',
                    style: TextStyle(fontSize: 15),
                  )),
              Container(
                  height: 500,
                  width: double.infinity,
                  margin: const EdgeInsets.only(
                    top: 200,
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: const CircleAvatar(
                                radius: 70,
                                backgroundColor: Color.fromARGB(
                                  255,
                                  18,
                                  64,
                                  38,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(4),
                                  child: ClipOval(
                                      child: Image(
                                          image: AssetImage('assets/ami.jpg'))),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: const Text(
                                'Amiel',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.green),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 2),
                              child: const Text(
                                '(CEO)',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              width: 300,
                              margin: const EdgeInsets.only(
                                top: 15,
                                left: 7,
                              ),
                              child: const Text(
                                '“You see Verdant as a mobile application externally and internally. However, I assure you, if you join my team, you will not regret it!”',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 15),
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: const CircleAvatar(
                                radius: 70,
                                backgroundColor: Color.fromARGB(
                                  255,
                                  18,
                                  64,
                                  38,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(4),
                                  child: ClipOval(
                                      child: Image(
                                          image: AssetImage('assets/ren.jpg'))),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: const Text(
                                'Reniel',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.green),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 2),
                              child: const Text(
                                '(Software Developer)',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              width: 300,
                              margin: const EdgeInsets.only(
                                top: 15,
                                left: 7,
                              ),
                              child: const Text(
                                '“As a software developer, most of my time is quiet and stressful, but because of my Verdant co-workers, the pressure that I feel is overturned by happiness and laughter. I love being here and I’m sure I will do my best.”',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 15),
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: const CircleAvatar(
                                radius: 70,
                                backgroundColor: Color.fromARGB(
                                  255,
                                  18,
                                  64,
                                  38,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(4),
                                  child: ClipOval(
                                      child: Image(
                                          image: AssetImage('assets/jul.jpg'))),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: const Text(
                                'Julius',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.green),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 2),
                              child: const Text(
                                '(Graphic Designer)',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              width: 300,
                              margin: const EdgeInsets.only(
                                top: 15,
                                left: 7,
                              ),
                              child: const Text(
                                '“At first, I did not have enough confidence in myself. I remember my hands shaking on my first day. But, Sir Amiel and other staff motivated me. They always pushed me to my very best. Now, I will prove my worth here and to the company. Lets go!”',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 15),
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: const CircleAvatar(
                                radius: 70,
                                backgroundColor: Color.fromARGB(
                                  255,
                                  18,
                                  64,
                                  38,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(4),
                                  child: ClipOval(
                                      child: Image(
                                          image: AssetImage('assets/arl.jpg'))),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: const Text(
                                'Arlai',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.green),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 2),
                              child: const Text(
                                '(Network Administrator)',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              width: 300,
                              margin: const EdgeInsets.only(
                                top: 15,
                                left: 7,
                              ),
                              child: const Text(
                                '“It has been a terrific place for me to advance in my career, and everyone here is consistently encouraging, supporting, and helpful. Looking forward to many more years with this company.”',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 15),
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: const CircleAvatar(
                                radius: 70,
                                backgroundColor: Color.fromARGB(
                                  255,
                                  18,
                                  64,
                                  38,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(4),
                                  child: ClipOval(
                                      child: Image(
                                          image:
                                              AssetImage('assets/ange.jpg'))),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: const Text(
                                'Angelo',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.green),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 2),
                              child: const Text(
                                '(Data Analyst)',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              width: 300,
                              margin: const EdgeInsets.only(
                                top: 15,
                                left: 7,
                              ),
                              child: const Text(
                                '“I know that my work is hard as a data analyst, I interpret data sets to answer a question or solve a problem. But every time I see my co-workers talking about success it boosts me to strive hard and give my best shot in our group. I am grateful that I belong to this team.”',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 15),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )),
              Container(
                margin: const EdgeInsets.all(20),
                child: const Text(
                  'Want to work with us?',
                  style: TextStyle(fontSize: 30, color: Colors.green),
                ),
              ),
              Container(
                  width: 1000,
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: const Text(
                    'The Verdant team is looking for trustworthy and hardworking people that know how to make people smile by giving maximum effort to make their users happy and content. If you know you are qualified and you want to be on our team, you better apply now and experience one of the most "friendly environments" in the country. So what are you waiting for? Apply Now!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ))
            ],
          ),
        )),
      ),
    );
  }
}
