import 'dart:html';
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
            icon: Icon(Icons.arrow_back),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: SingleChildScrollView(
            child: Center(
          child: Column(
            children: <Widget>[
              Container(
                height: 500,
                width: double.infinity,
                decoration: BoxDecoration(
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
                                child: Text(
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
                                child: Text(
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
                                child: Text(
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
                                child: Text(
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
                                child: Text(
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
              Container(
                child: Column(
                    children: [Image(image: AssetImage('assets/ver.png'))]),
              ),
              Container(
                width: 1000,
                padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                margin: EdgeInsets.only(),
                child: Text(
                  'Verdant (adjective)',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              Container(
                width: 1000,
                padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                margin: EdgeInsets.only(top: 20),
                child: Text(
                  'To ensure that plants are firm and formed.',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Container(
                width: 1000,
                padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                margin: EdgeInsets.only(top: 20),
                child: Text(
                  'Verdant means green with growing plants. It is our ambition to help every plant enthusiast, especially ornamental plant keepers, achieve their dream of having a beautiful, healthy, and strong plant. We are a passionate team, unified by our mission to assist every plant keeper or gardener. Everyday, we search for new ways to improve our service so that people can engage in choosing plants. But, it is not our only goal to be on top; we also want to elevate the members of the plant community. This is what we want; a healthy environment for horticulturists where information is broadened and ideas are overflowing. Millions of people will get interested. Millions will also come. When you are ready to choose what ornamental plants you are willing to take care of and you have the guts to spend time on this kind of hobby, join us!',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Container(
                width: 1000,
                padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                margin: EdgeInsets.only(top: 100),
                child: Text(
                  'Our Team',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              Container(
                  width: 1000,
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                  margin: EdgeInsets.only(
                    top: 20,
                  ),
                  child: Text(
                    'Working at Verdant means you surround yourself with intelligent and hardworking people. Here, we dont only focus on customer satisfaction but also consider our beloved staff and employees. At Verdant, there is a reason why "companionship" is one of the most important core values.',
                    style: TextStyle(fontSize: 15),
                  )),
              Container(
                  height: 500,
                  width: double.infinity,
                  margin: EdgeInsets.only(
                    top: 200,
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: CircleAvatar(
                                radius: 70,
                                backgroundColor: Color.fromARGB(
                                  255,
                                  18,
                                  64,
                                  38,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: ClipOval(
                                      child: Image(
                                          image: AssetImage('assets/ami.jpg'))),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Text(
                                'Amiel',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.green),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 2),
                              child: Text(
                                '(CEO)',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              width: 300,
                              margin: EdgeInsets.only(
                                top: 15,
                                left: 7,
                              ),
                              child: Text(
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
                              margin: EdgeInsets.only(top: 10),
                              child: CircleAvatar(
                                radius: 70,
                                backgroundColor: Color.fromARGB(
                                  255,
                                  18,
                                  64,
                                  38,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: ClipOval(
                                      child: Image(
                                          image: AssetImage('assets/ren.jpg'))),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Text(
                                'Reniel',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.green),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 2),
                              child: Text(
                                '(Software Developer)',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              width: 300,
                              margin: EdgeInsets.only(
                                top: 15,
                                left: 7,
                              ),
                              child: Text(
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
                              margin: EdgeInsets.only(top: 10),
                              child: CircleAvatar(
                                radius: 70,
                                backgroundColor: Color.fromARGB(
                                  255,
                                  18,
                                  64,
                                  38,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: ClipOval(
                                      child: Image(
                                          image: AssetImage('assets/jul.jpg'))),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Text(
                                'Julius',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.green),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 2),
                              child: Text(
                                '(Graphic Designer)',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              width: 300,
                              margin: EdgeInsets.only(
                                top: 15,
                                left: 7,
                              ),
                              child: Text(
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
                              margin: EdgeInsets.only(top: 10),
                              child: CircleAvatar(
                                radius: 70,
                                backgroundColor: Color.fromARGB(
                                  255,
                                  18,
                                  64,
                                  38,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: ClipOval(
                                      child: Image(
                                          image: AssetImage('assets/arl.jpg'))),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Text(
                                'Arlai',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.green),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 2),
                              child: Text(
                                '(Network Administrator)',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              width: 300,
                              margin: EdgeInsets.only(
                                top: 15,
                                left: 7,
                              ),
                              child: Text(
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
                              margin: EdgeInsets.only(top: 10),
                              child: CircleAvatar(
                                radius: 70,
                                backgroundColor: Color.fromARGB(
                                  255,
                                  18,
                                  64,
                                  38,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: ClipOval(
                                      child: Image(
                                          image:
                                              AssetImage('assets/ange.jpg'))),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Text(
                                'Angelo',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.green),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 2),
                              child: Text(
                                '(Data Analyst)',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              width: 300,
                              margin: EdgeInsets.only(
                                top: 15,
                                left: 7,
                              ),
                              child: Text(
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
                margin: EdgeInsets.all(20),
                child: Text(
                  'Want to work with us?',
                  style: TextStyle(fontSize: 30, color: Colors.green),
                ),
              ),
              Container(
                  width: 1000,
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Text(
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
