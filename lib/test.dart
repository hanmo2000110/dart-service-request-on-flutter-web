import 'dart:convert';
import 'dart:io';

import 'package:dart_pad_web_compile_test/protos/dart_services.pb.dart';
import 'package:http/http.dart' as http;

const _apiPath = 'api/dartservices/v2';
const action2 = 'compile';
const action = 'compileDDC';
const rootUrl = 'https://dart-service-2-wq5r2rbjma-uc.a.run.app/';
Future<void> main() async {
  print("test start");
  CompileResponse result = CompileResponse();
  final compileRequest = CompileRequest()
    ..source = """
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '\$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
  """;
  final compileRequest2 = CompileRequest()
    ..source = """
    void main(){
      print("hi");
    }
    """;
  final response = await http.post(
    Uri.parse('$rootUrl$_apiPath/$action'),
    encoding: utf8,
    body: json.encode(compileRequest.toProto3Json()),
  );
  // final jsonBody = json.decode(response.body);
  // print(jsonBody);
  // result.mergeFromProto3Json(jsonBody);
  // result.freeze();

  // print(result.result);

  // final file = await _localFile;
  // var filename = await File(
  //         "/Users/kimshin/Desktop/HEM 인턴/dart_pad_web_compile_test/test.js")
  //     .writeAsString(result.result);
  var filename = await File(
          "/Users/kimshin/Desktop/HEM 인턴/dart_pad_web_compile_test/test2.js")
      .writeAsString(response.body);
}
