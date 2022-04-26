import 'package:egvu/database/hiveModelClass.dart';

import 'package:egvu/spashScreen/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(LocalSongsAdapter());
  await Hive.openBox<List>(boxName);

  final box = Boxes.getInstance();

  List<dynamic> favkeys = box.keys.toList();
  if (!favkeys.contains('favourites')) {
    List<dynamic> likedsongs = [];
    await box.put('favourites', likedsongs);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (ctx) => MaterialApp(
        // builder: (context, child) {
        //   return MediaQuery(
        //       data: const MediaQueryData(textScaleFactor: .8), child: child!);
        // },
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: const SplashScreen(),
      ),
      designSize: const Size(286.86614173, 619.84251969),
    );
  }
}
