import 'package:e_complaint_box/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

List<List<String>> aboutPage = [
  [
    'Aditya Shahi',
    "Words don't matter unless your work says what you did",
    'assets/images/aditya.png'
  ],
  [
    "Arif",
    "Any fool can write code that a computer can understand. Good programmers write code that humans can understand.",
    'assets/images/arif.jpg'
  ],
  [
    'Sachin Gautam',
    "We produce a many bugs daily in our code, so does our infrastructure. The need is to improve both simultaneously.",
    'assets/images/sachin.jpg'
  ]
];

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF181D3D),
        title: Text(
          'About Us',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (builder) => const HomePage())),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: ListView(children: [
          Text('The Why Behind Us?',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'In this fast-moving world with intensive coursework, students find very less time to share their problems. At almost every university, the students reside on CRs ,Proctors etc, and most of those have offline complaint registration opening only 2-3 hours a day which some students miss. This is the reason why ASComplaints is here.',
            style: TextStyle(color: Colors.white38),
          ),
          const SizedBox(
            height: 20,
          ),
          Text('Team', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(
            height: 10,
          ),
          Center(
              child: SizedBox(
                  height: 130.0,
                  child: PageView(
                    scrollDirection: Axis.horizontal,
                    controller: PageController(viewportFraction: 1),
                    //pageSnapping: ,
                    children: aboutPage
                        .map<Widget>(
                          (lst) => Container(
                            height: 130,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                color: Color(0xff174F74)),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(80),
                                    child: Image.asset(
                                      lst[2],
                                      width: 100.0,
                                      height: 100.0,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 60,
                                  width:
                                      MediaQuery.of(context).size.width - 200,
                                  child: ListView(
                                    children: [
                                      Text(
                                        lst[1],
                                        //'We believe technology should be used in favour of mankind wherever possible. As students, we are the future builders and we are responsible for our own competency with the world.',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                                color: Colors.white,
                                                fontSize: 9),
                                      ),
                                      Text(
                                        '- ' + lst[0],
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                                color: Colors.white,
                                                fontSize: 9),
                                        textAlign: TextAlign.right,
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10)
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ))),
          const SizedBox(
            height: 5,
          ),
          const Center(
            child: Text(
              'Slide to know about other developers ->',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text('Legal Licenses', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'This project is licensed under the Apache-2.0 License.',
            style: TextStyle(fontSize: 12, color: Colors.white38),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 170,
                width: 170,
                child: Image.asset(
                  "assets/images/splash.png",
                ),
              ),
              const Text('© ASComplaints 2022',
                  style: TextStyle(fontSize: 16, color: Colors.white24)),
            ],
          ),
        ]), /*
            */
      ),
    );
  }
}
