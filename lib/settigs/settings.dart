import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:egvu/database/hiveModelClass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';

import 'package:share_plus/share_plus.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  AssetsAudioPlayer myAudio = AssetsAudioPlayer();
  bool _toggled =
      Hive.box<StoreNotification>(storeBoxname).getAt(0)!.isNotificationOn;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return 
    Container(
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
              SwitchListTile(
                  title: Text(
                    'Notifications',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontFamily: 'Poppins-Regular'),
                  ),
                  secondary: Icon(
                    _toggled
                        ? Icons.notifications
                        : Icons.notifications_off_outlined,
                    color: Colors.white,
                  ),
                  value: _toggled,
                  onChanged: (bool value) {
                    Hive.box<StoreNotification>(storeBoxname)
                        .putAt(0, StoreNotification(isNotificationOn: value));

                    setState(() {
                      _toggled = Hive.box<StoreNotification>(storeBoxname)
                          .getAt(0)!
                          .isNotificationOn;

                      if (_toggled == true) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                                duration: Duration(seconds: 1),
                                content: Text(
                                  'App need to Restart to see the Changes',
                                  style:
                                      TextStyle(fontFamily: 'Poppins-Regular'),
                                )));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(seconds: 1),
                            content: Text(
                              'App need to Restart to see the Changes',
                              style: TextStyle(fontFamily: 'Poppins'),
                            ),
                          ),
                        );
                      }
                    });
                  }),
              ListTile(
                onTap: () {
                  Share.share('Go Music with Offline');
                },
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
              ListTile(
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
              ListTile(
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
              ListTile(
                onTap: (() {
                  showAboutDialog(
                      context: context,
                      applicationName: 'Egvu',
                      applicationVersion: '1.0.1',
                      children: [
                        const Text(
                          'Egvu is a Offline Music Player created by Ajay ',
                          style: TextStyle(fontFamily: 'Poppins-Regular'),
                        )
                      ],
                      applicationIcon: SizedBox(
                        height: 40.h,
                        width: 40.h,
                        child: Image.asset('asset/nullMusic.png'),
                      ));
                }),
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
              ),
            ],
          ))),
    );
  }
}
