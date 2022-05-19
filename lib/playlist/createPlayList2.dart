import 'package:egvu/database/hiveModelClass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreatePlayListTwo extends StatelessWidget {
   CreatePlayListTwo({Key? key}) : super(key: key);


  List<LocalSongs> playlist = [];
  final box = Boxes.getInstance();
  String? title;
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black,
      child: SizedBox(
        height: 180.h,
        width: 200.h,
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Enter playlist Name',
                style: TextStyle(
                    color: Colors.white70,
                    fontFamily: 'Poppins-Regular',
                    fontSize: 14.sp),
              ),
              SizedBox(
                height: 20.h,
              ),
              Form(
                  key: formkey,
                  child: TextFormField(
                    autofocus: true,
                    style: const TextStyle(
                        color: Colors.white70, fontFamily: 'Poppins-Regular'),
                    onChanged: (value) {
                      title = value.trim();
                    },
                    textCapitalization: TextCapitalization.sentences,
                    validator: (value) {
                      List keys = box.keys.toList();
                      if (value!.trim() == '') {
                        return 'Name requred';
                      }
                      if (keys
                          .where((element) => element == value.trim())
                          .isNotEmpty) {
                        return 'This name is already exist';
                      }
                      return null;
                    },
                  )),
              Expanded(
                child: Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            box.put(title, playlist);
                            Navigator.pop(context);
                          }
                        },
                        child: const Text(
                          'Create',
                          style: TextStyle(
                              color: Colors.green,
                              fontFamily: 'Poppins-Regular'),
                        )),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Center(
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 15,
                              fontFamily: 'Poppins'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
