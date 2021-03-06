import 'package:flutter/material.dart';
import 'package:button_uz/button_uz.dart';

void main() =>
  runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Button',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Button"),
        toolbarHeight: 60,
        elevation: 1.0,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            alignment: Alignment.center,
            child: FlutterButton(
              height: 56,
              width: 200,
              color: Colors.blue,
              child: Text("Click to here."),
              margin: const EdgeInsets.all(8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
                side: BorderSide(
                  width: 2,
                  color: Colors.black,
                ),
              ),
              onPressed: () => print("object"),
            ),
          ),
          FlutterButton(
            child: Text("Click to here."),
            padding: const EdgeInsets.all(16),
            onPressed: () => print("object"),
          ),
          SizedBox(height: 20),
          FlutterButton(
            child: Text("BUTTON"),
            color: Colors.white,
            splashColor: Colors.amber,
            padding: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
              side: BorderSide(
                width: 2,
                color: Colors.black,
              ),
            ),
            onPressed: () => print("object"),
          ),
          SizedBox(height: 20),
          FlutterButton(
            child: Text("BUTTON"),
            height: 80,
            color: Colors.white,
            splashColor: Colors.amber,
            highlightColor: Colors.red,
            padding: const EdgeInsets.all(16),
            shape: CircleBorder(
              side: BorderSide(
                width: 2,
                color: Colors.black,
              ),
            ),
            onPressed: () => print("object"),
          ),
          SizedBox(height: 20),
          FlutterButton(
            height: 56,
            child: Text(
              "BUTTON",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 24),
            color: Colors.grey,
            splashColor: Colors.amber,
            padding: const EdgeInsets.all(16),
            onPressed: () => print("object"),
          ),
          SizedBox(height: 20),
          FlutterButton(
            height: 56,
            child: Text(
              "BUTTON",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 24),
            color: Colors.blueGrey,
            splashColor: Colors.amber,
            padding: const EdgeInsets.all(16),
            onPressed: () => print("object"),
          ),
        ],
      ),
    );
  }
}
