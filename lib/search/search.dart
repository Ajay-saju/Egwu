import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff90caf4), Color(0xffdee3e3)])),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
              child: Padding(
            padding: EdgeInsets.all(20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Search',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontFamily: 'Poppins-Regular',
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.h, left: 10.w),
                    child: Text(
                      'Search Your Songs.....',
                      style: TextStyle(
                          fontFamily: 'Poppins-Regular',
                          fontSize: 10.sp,
                          color: Colors.grey),
                    ),
                  ),
                  height: 50.h,
                  width: 300.w,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r)),
                )
              ],
            ),
          ))),
    );
  }
}
