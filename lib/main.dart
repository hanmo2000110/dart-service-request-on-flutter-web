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

import 'crypto.dart';

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
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final descController = TextEditingController();
  final nameController = TextEditingController();
  final commitController = TextEditingController();
  String _jsResult = '';
  // late JavascriptRuntime flutterJs;

  void initState() {
    super.initState();

    // flutterJs = getJavascriptRuntime();
  }

  var code = """
    void main(){
      print("hello world");
    } 
  """;

  Future<void> _createFile(
      String filename, String code, String commitMessage) async {
    var result123 = await http.put(
      Uri.parse(
          "https://api.github.com/repos/hanmo2000110/dart-pad-firebase-test/contents/lib/$filename"),
      headers: {
        "Accept": "application/vnd.github.v3+json",
        'Authorization': "token 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",
      },
      body: jsonEncode({
        'content': base64.encode(utf8.encode(code)),
        'message': commitMessage,
      }),
    );

    print(result123.body);
  }

  Future<void> _incrementCounter() async {
    var result123 = await http.get(Uri.parse(
        "https://cors-anywhere.herokuapp.com/http://sugang.handong.edu/servlets/stud/basket?attribute=sugang_save&gwamok_code=ECE30092&bunban=01&jaeisu=0&fake=Thu%20Jan%2027%202022%2021:58:31%20GMT+0900%20(%C7%D1%B1%B9%20%C7%A5%C1%D8%BD%C3)"));

    print(result123.body);
  }

  Future<void> _crypto_test() async {
    print("crypto test");
    normalExample();
  }

  // curl \
  // -X PUT \
  // -H "Accept: application/vnd.github.v3+json" \
  // -H 'authorization: token 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' \
  // https://api.github.com/repos/hanmo2000110/dart-pad-firebase-test/contents/lib/test2.txt \
  // -d '{"message":"message","content":"aGVsbG8gd29ybGQ="}'

  // Future<void> _incrementCounter() async {
  //   print("test start");
  //   CompileResponse result = CompileResponse();
  //   final compileRequest = CompileRequest()..source = descController.text;

  //   final response = await http.post(
  //     Uri.parse('$rootUrl$_apiPath/$action'),
  //     encoding: utf8,
  //     body: json.encode(compileRequest.toProto3Json()),
  //   );
  //   final jsonBody = json.decode(response.body);
  //   print(jsonBody);
  //   // result.mergeFromProto3Json(jsonBody);
  //   // result.freeze();

  //   // print(result.result);

  //   try {
  //     // JsEvalResult jsResult = flutterJs.evaluate(result.result);
  //     // print(flutterJs.evaluate(result.result));
  //     // flutterJs.
  //     // setState(() {
  //     //   _jsResult = jsResult.stringResult;
  //     //   print(jsResult);
  //     // });
  //   } on Exception catch (e) {
  //     print('ERROR: ${e}');
  //   }

  //   // var filename =
  //   //     await File("/Users/kimshin/Desktop/HEM 인턴/dart_pad_web_compile_test")
  //   //         .writeAsString(result.result);

  //   // await executionService.execute(
  //   //   "",
  //   //   "",
  //   //   result.result,
  //   //   destroyFrame: false,
  //   // );
  // }

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
                minLines: 1,
                controller: descController,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  labelText: "파일 이름을 입력하세요",
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
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                minLines: 5,
                controller: nameController,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  labelText: "파일 내용을 입력하세요",
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
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                minLines: 5,
                controller: commitController,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  labelText: "커밋 메세지를 입력하세요",
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
        onPressed: () {
          // _createFile(
          //     descController.text, nameController.text, commitController.text);
          _crypto_test();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// void main(){
//     print("hi");
// }
