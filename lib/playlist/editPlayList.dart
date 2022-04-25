import 'package:egvu/database/hiveModelClass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditPlayList extends StatelessWidget {
  EditPlayList({Key? key, required this.PlaylistName}) : super(key: key);
  final String PlaylistName;
  final _box = Boxes.getInstance();
  String? _title;
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black,
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        Text(
          'Edit Your Play List Name',
          style: TextStyle(
              fontFamily: 'Poppins-Regular',
              color: Colors.white70,
              fontSize: 14.sp),
        ),
        Padding(
          padding: EdgeInsets.all(10.r),
          child: Form(
              child: TextFormField(
            cursorHeight: 20,
            initialValue: PlaylistName,
            style: const TextStyle(
              color: Colors.white70,
              fontFamily: 'Poppins-regular',
            ),
            onChanged: (value) {
              _title = value.trim();
            },
            validator: (value) {
              List keys = _box.keys.toList();
              if (value!.trim() == '') {
                return 'Name Requred';
              }
              if (keys.where((element) => element == value.trim()).isNotEmpty) {
                return "This name is already exist";
              }
              return null;
            },
          )),
        ),
        Row(
          children: [
            TextButton(onPressed: () {}, child: Text('Cancel')),
            TextButton(onPressed: () {}, child: Text('Save'))
          ],
        )
      ]),
    );
  }
}
