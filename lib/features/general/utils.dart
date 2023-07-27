import 'dart:convert';
import 'package:crypto/crypto.dart';

extension ToSHA256 on String {
  String encryptToSHA256() {
    return sha256.convert(utf8.encode(this)).toString();
  }
}