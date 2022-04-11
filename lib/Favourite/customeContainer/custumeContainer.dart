
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomeContainer extends StatelessWidget {
  final String imageLink;
  final String title;
  final String artist;

  const CustomeContainer({
    Key? key,
    required this.imageLink,
    required this.title,
    required this.artist,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(5.h),
          child: Container(
            width: 51.w,
            height: 50.h,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(imageLink), fit: BoxFit.cover)),
          ),
        ),
        SizedBox(
          width: 15.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontFamily: 'Poppins-Regular',
                  fontSize: 12.sp,
                  color: Colors.white),
            ),
            SizedBox(height: 1.h),
            SizedBox(
              width: 160.w,
              child: Text(
                artist,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontFamily: 'Poppins-Regular',
                    fontSize: 9.sp,
                    color: Colors.white70),
              ),
            ),
          ],
        ),
        const Icon(
          Icons.more_vert,
          color: Colors.white,
        ),
      ],
    );
  }
}
