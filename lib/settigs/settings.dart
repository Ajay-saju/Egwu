import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _toggled = false;

  @override
  void initState() {
    getSwitchValues();
    super.initState();
  }

  getSwitchValues() async {
    _toggled = await getSwitchState();
  }

  Future<bool> saveSwithState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('notification', value);
    return prefs.setBool('notification', value);
  }

  Future<bool> getSwitchState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool? _toggled = prefs.getBool('notification');

    return _toggled ?? true;
  }

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
                child: SwitchListTile(
                    title: Text(
                      'Notifications',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontFamily: 'Poppins-Regular'),
                    ),
                    secondary: const Icon(
                      Icons.notifications,
                      color: Colors.white,
                    ),
                    value: _toggled,
                    onChanged: (bool value) {
                      setState(() {
                        _toggled = value;
                        saveSwithState(value);
                        if (_toggled == true) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                                  content: Text(
                            'App need to Restart to see the Changes',
                            style: TextStyle(fontFamily: 'Poppins-Regular'),
                          )));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'App need to Restart to see the Changes',
                                style: TextStyle(fontFamily: 'Poppins'),
                              ),
                            ),
                          );
                        }
                      });
                    }),
              ),
              Padding(
                padding: EdgeInsets.all(10.w),
                child: ListTile(
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
