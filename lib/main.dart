import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:trukkertrakker/Login.dart';
import 'firebase_options.dart';
import 'src/app.dart';

void main() {

  runApp(const MyApp());

  runApp(LoginApp());
}
