import 'package:egvu/PlayWidget/customePlayBackWidget.dart';
import 'package:egvu/mainScreen/mainScren.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    splash();
    // isPlayingSong = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff3e3e66),
      body: SafeArea(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            width: 500.w,
            height: 500.h,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('asset/cassette_tape.gif'))),
          ),
        ]),
      ),
    );
  }

  splash() async {
    await Future.delayed(const Duration(seconds: 5));
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: ((context) => MainScreen())));
  }
}
