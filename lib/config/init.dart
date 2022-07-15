import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

import '../data/service/local/locator.dart';

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();

  await Firebase.initializeApp();
}
