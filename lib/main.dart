import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Hello Flutter',
            style: TextStyle(fontSize: 28),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: Image.asset(
                    "images/petpuls_logo.png",
                    width: 150,
                  ),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'id'),
                ),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'password'),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 16),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('login'),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 0.5),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('join'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
