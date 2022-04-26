import 'package:egvu/database/hiveModelClass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditPlayList extends StatelessWidget {
  EditPlayList({Key? key, required this.playlistName}) : super(key: key);

  final String playlistName;
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
              key: formkey,
              child: TextFormField(
                autofocus: true,
                cursorHeight: 20,
                initialValue: playlistName,
                style: const TextStyle(
                  color: Colors.white70,
                  fontFamily: 'Poppins-regular',
                ),
                onChanged: (value) {
                  _title = value.trim();
                },
                validator: (value) {
                  List keys = _box.keys.toList();
                  if (value!.trim() == "") {
                    return 'Name Requred';
                  } else if (keys
                      .where((element) => element == value.trim())
                      .isNotEmpty) {
                    return "This name is already exist";
                  } else {
                    _title = value.trim();
                    return null;
                  }
                },
              )),
        ),
        Row(
          children: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(fontFamily: 'Poppins-Regular'),
                )),
            TextButton(
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    List? playlists = _box.get(playlistName);
                    _box.put(_title, playlists!);
                    _box.delete(playlistName);
                    Navigator.of(context).pop();
                  }
                },
                child: const Text(
                  'Save',
                  style: TextStyle(fontFamily: 'Poppins-Regular'),
                ))
          ],
        )
      ]),
    );
  }
}
