import 'dart:convert';
import 'dart:io';

import 'package:dart_pad_web_compile_test/protos/dart_services.pb.dart';
import 'package:dart_pad_web_compile_test/services/execution.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_js/flutter_js.dart';
// import 'package:flutter_js/javascript_runtime.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:protobuf/protobuf.dart';

const _apiPath = 'api/dartservices/v2';
const action = 'compile';
const rootUrl = 'https://dart-service-2-wq5r2rbjma-uc.a.run.app/';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final descController = TextEditingController();
  String _jsResult = '';
  // late JavascriptRuntime flutterJs;

  void initState() {
    super.initState();

    // flutterJs = getJavascriptRuntime();
  }

  Future<void> _incrementCounter() async {
    print("test start");
    CompileResponse result = CompileResponse();
    final compileRequest = CompileRequest()..source = descController.text;

    final response = await http.post(
      Uri.parse('$rootUrl$_apiPath/$action'),
      encoding: utf8,
      body: json.encode(compileRequest.toProto3Json()),
    );
    final jsonBody = json.decode(response.body);
    print(jsonBody);
    // result.mergeFromProto3Json(jsonBody);
    // result.freeze();

    // print(result.result);

    try {
      // JsEvalResult jsResult = flutterJs.evaluate(result.result);
      // print(flutterJs.evaluate(result.result));
      // flutterJs.
      // setState(() {
      //   _jsResult = jsResult.stringResult;
      //   print(jsResult);
      // });
    } on Exception catch (e) {
      print('ERROR: ${e}');
    }

    // var filename =
    //     await File("/Users/kimshin/Desktop/HEM 인턴/dart_pad_web_compile_test")
    //         .writeAsString(result.result);

    // await executionService.execute(
    //   "",
    //   "",
    //   result.result,
    //   destroyFrame: false,
    // );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  print(_jsResult);
                });
              },
              child: Text('compile'),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                minLines: 5,
                controller: descController,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  labelText: "코드를 입력하세요",
                  labelStyle: TextStyle(fontSize: 14),
                  fillColor: Colors.black,
                  focusColor: Colors.black,
                  hoverColor: Colors.black,
                  border: OutlineInputBorder(),
                ),
                // minLines: 3,
                autocorrect: false,
                maxLines: null,
                onChanged: (value) {},
              ),
            ),
            // Container(
            //   padding: EdgeInsets.all(10),
            //   child: Text(_jsResult),
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// void main(){
//     print("hi");
// }
