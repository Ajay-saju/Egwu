import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  //bool _value = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff000000), Color(0xffbebebe)])),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
              child: Column(
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 30.w),
                  child: Text(
                    'Settings',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.sp,
                      fontFamily: 'Poppins-Regular',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.w),
                child: ListTile(
                  leading: const Icon(
                    Icons.notifications,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Notifications',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontFamily: 'Poppins-Regular'),
                  ),
                  trailing: const Icon(
                    Icons.toggle_off_outlined,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.w),
                child: ListTile(
                  leading: const Icon(
                    Icons.share,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Share',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontFamily: 'Poppins-Regular'),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.w),
                child: ListTile(
                  leading: const Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Privacy and Policies ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontFamily: 'Poppins-Regular'),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.w),
                child: ListTile(
                  leading: const Icon(
                    Icons.file_copy_sharp,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Terms and Condition',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontFamily: 'Poppins-Regular'),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.w),
                child: ListTile(
                  leading: const Icon(
                    Icons.info,
                    color: Colors.white,
                  ),
                  title: Text(
                    'About',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontFamily: 'Poppins-Regular'),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ))),
    );
  }
}
