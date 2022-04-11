import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class PlayList extends StatefulWidget {
  const PlayList({Key? key}) : super(key: key);

  @override
  State<PlayList> createState() => _PlayListState();
}

class _PlayListState extends State<PlayList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xffbc68fe),
            Color(0xffc6c4c8),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: SafeArea(
              child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Playlist',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontFamily: 'Poppins-Regular'),
                ),

                SizedBox(
                  height: 20.h,
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.only(top: 50.h, left: 20.w),
                    child: Text(
                      'My Mood',
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16.sp,
                          fontFamily: 'Poppins-Regular'),
                    ),
                  ),
                  width: 600.w,
                  height: 110.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                        image: AssetImage('asset/pop.jpg'), fit: BoxFit.fill),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.only(top: 50.h, left: 20.w),
                    child: Text(
                      'Chill Vibe',
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16.sp,
                          fontFamily: 'Poppins-Regular'),
                    ),
                  ),
                  width: 600.w,
                  height: 110.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                        image: AssetImage('asset/headphones_2.jpg'),
                        fit: BoxFit.fill),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.only(top: 50.h, left: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Create Playlist',
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16.sp,
                              fontFamily: 'Poppins-Regular'),
                        ),
                        TextButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  backgroundColor: Colors.black,
                                  title: const Text(
                                    'Create playlist',
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontFamily: 'Poppins-Regular'),
                                  ),
                                  content: TextFormField(
                                    initialValue: 'Playlist name',
                                    style: const TextStyle(
                                        color: Colors.white70,
                                        fontFamily: 'Poppins-Regular'),
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontFamily: 'Poppins-Regular'),
                                        )),
                                    TextButton(
                                        onPressed: () {
                                          setState(() {});
                                        },
                                        child: const Text(
                                          'Create',
                                          style: TextStyle(
                                              fontFamily: 'Poppins-Regular'),
                                        ))
                                  ],
                                ),
                              );
                            },
                            child: Text(
                              'Add',
                              style: TextStyle(
                                  fontFamily: 'Poppins-Regular',
                                  fontSize: 12.sp,
                                  color: Colors.white),
                            ))
                      ],
                    ),
                  ),
                  width: 600.w,
                  height: 110.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                        image: AssetImage('asset/createPlaylist.jpg'),
                        fit: BoxFit.fill),
                  ),
                ),
                // ListView.builder(
                //     shrinkWrap: true,
                //     itemBuilder: (BuildContext context, int index) {
                //       return const Card();
                //     }),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
