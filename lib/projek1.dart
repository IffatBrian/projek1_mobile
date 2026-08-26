import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "MyApp",
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("MyApp"),
          backgroundColor: Colors.red,
          bottom: TabBar(
            tabs: [
              Tab(text: "BERITA TERBARU"),
              Tab(text: "PERTANDINGAN HARI INI"),
            ],
          ),
        ),
        body: Center(child: Text("Welcome to the Homepage")),
      ),
    );
  }
}
