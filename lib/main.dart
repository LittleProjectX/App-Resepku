import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:seleraku/app/core/theme/app_theme.dart';
import 'package:seleraku/app/core/utils/page_transition.dart';
import 'package:seleraku/firebase_options.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Seleraku",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      customTransition: SlideZoomTransition(),
      transitionDuration: Duration(milliseconds: 400),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
