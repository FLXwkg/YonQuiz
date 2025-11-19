import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app.dart';
import 'features/auth/data/models/user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialiser Hive
  await Hive.initFlutter();
  
  // Enregistrer les adapters
  Hive.registerAdapter(UserModelAdapter());
  
  // Ouvrir la box des préférences
  await Hive.openBox('app_prefs');
  
  runApp(const MyApp());
}
