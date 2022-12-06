import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_complaint_box/screens/Complaint/Compose.dart';
import 'package:e_complaint_box/screens/Complaint/admin_pendin_complaints.dart';
import 'package:e_complaint_box/screens/feed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

List<String> itemsImagesList = [
  "assets/slider/WithTrueLove.png",
  "assets/images/splash.png",
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              if (ZoomDrawer.of(context)!.isOpen()) {
                ZoomDrawer.of(context)!.close();
              } else {
                ZoomDrawer.of(context)!.open();
              }
            },
            icon: const Icon(Icons.menu, color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (c) => const Compose())),
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ))
          ],
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black,
                  Colors.white54,
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(2, 0.0),
                stops: [0.1, 1.0],
                tileMode: TileMode.mirror,
              ),
            ),
          ),
          title: const Text(
            "DashBoard",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16.0),
              height: 200,
              decoration: const BoxDecoration(color: Color(0xFF181D3D)),
              child: PageView.builder(
                  itemCount: itemsImagesList.length,
                  controller: PageController(viewportFraction: 1),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      // height: 200,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                        image: DecorationImage(
                            image: AssetImage(itemsImagesList[index]),
                            fit: BoxFit.fill),
                      ),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (builder) => Feed())),
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: const BoxDecoration(
                        // shape: BoxShape.rectangle
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Colors.white38,
                      ),
                      child: const Center(
                        child: Text(
                          'Feeds',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Colors.black87),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => const AdminPending())),
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: const BoxDecoration(
                        // shape: BoxShape.rectangle
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Colors.white38,
                      ),
                      child: const Center(
                        child: Text(
                          'Pending Complaints',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Colors.black87),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

/* */
