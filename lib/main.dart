import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String url = "https://jsonplaceholder.typicode.com/albums";
  List data;

  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async {
    var response = await http.get(
        // Encoding the url in case of there are any spaces
        Uri.encodeFull(url),
        // only accepting json respond
        headers: {"Accept": "application/json"});
    print(response.body);
    setState(() {
      final convertDataToJson = jsonDecode(response.body);
      data = convertDataToJson;
    });
    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Load Json From API"),
      ),
      body: ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (context, index) {
          return Container(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  data[index]["id"].toString(),
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),SizedBox(width: 10,),
                            Column(
                              children: [
                                Text(
                                  data[index]["title"].toString(),
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
