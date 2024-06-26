import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'src/app.dart';

void main() {
  WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized(); //アプリ起動時のスプラッシュ画面表示
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}
