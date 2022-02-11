import 'dart:convert';
import 'dart:typed_data';

// import 'package:cryptography/cryptography.dart';
import 'package:encrypt/encrypt.dart' as en;

Future<void> normalExample() async {
  String text =
      "gh_owner=microlearnableSWF&gh_repo=MicroLearnable&gh_ref=myfirstapp&gh_path=chapter0/run_flutter_project&split=70&theme=dark&null-safety=true&run=false";
  String encryptedText2 =
      "1O9RK7yftYnChJwK5JzTdrPDcM2zE%2BGZIlt4hES6MMSgQUMJ5Mr2USVjeUMQUaEhHGFIPCTRLgtocV34M3gDRgF3CDcpicpCb3BC3o3JIHXfUr1nXAqKBK6WFglqf9dEetWvUk2p7n4DYbKcXKk/dnCuIYSPOqBzSXfHRRZoKh45D2585rNMvxzHsOaMV4zEepPnxZ9UI5yjYUa2Xy0gwQ%3D%3D";
  final key = en.Key.fromUtf8("thisiskey1234577");
  final iv = en.IV.fromLength(16);
  final encrypter = en.Encrypter(en.AES(key));

// 암호화 코드
  var encryptedText = encrypter.encrypt(text, iv: iv).base64;
  encryptedText = encryptedText
      .replaceAll('&', "%26")
      .replaceAll('=', "%3D")
      .replaceAll('+', "%2B");
  print('암호화 값 : ${encryptedText}');

  encryptedText = encryptedText
      .replaceAll("%26", '&')
      .replaceAll("%3D", '=')
      .replaceAll("%2B", '+');
// 복호화 코드
  final texten = encrypter.decrypt64(encryptedText2, iv: iv);
  print('복호화 값 : $texten');

  // 암호키
  // final key = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16];
  // // 1회용 키
  // final nonce = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13];
  // // 인증용 데이터
  // final aad = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13];

  // // 암호화할 데이터
  // final plainText = [1, 2, 3];
  // String text = "im testing crypto";

  // // AES GCM 128 알고리즘 사용
  // final algorithm = AesGcm.with128bits();

  // // 키를 SecretKey로 생성
  // final secretKey = SecretKey(key);

  // // 암호화!

  // final secretBox = await algorithm.encrypt(text.codeUnits,
  //     secretKey: secretKey, nonce: nonce, aad: aad);

  // print(secretBox.toString());

  // // 암호화된 데이터
  // print('Ciphertext: ${secretBox.cipherText}');
  // // 암호화된 유효성 검사용 MAC 데이터
  // print('MAC: ${secretBox.mac}');

  // // 복호화 시작
  // // secretKey와 aad 공통으로 사용
  // var decryptedData = <int>[];
  // try {
  //   // 복호화
  //   decryptedData = await algorithm.decrypt(
  //     secretBox,
  //     secretKey: secretKey,
  //     aad: aad,
  //   );
  // } catch (e) {
  //   print('decryption error: $e');
  // } finally {
  //   //복호화 성공시!
  //   String result = new Utf8Decoder().convert(decryptedData);
  //   print('decryptedData: ${result}');
  // }
}
