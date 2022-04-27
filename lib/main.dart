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
  Hive.registerAdapter(StoreNotificationAdapter());
  await Hive.openBox<StoreNotification>(storeBoxname);

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

  
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (ctx) => MaterialApp(
       
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
