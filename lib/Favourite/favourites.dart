import 'package:egvu/Favourite/customeContainer/custumeContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff8f9e9d), Color(0xffcacbcb)])),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Favourites',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontFamily: 'Poppins-Regular'),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    const CustomeContainer(
                        imageLink: 'asset/Trance_film_poster.jpg',
                        title: 'Noolupoya',
                        artist: 'Sushin Shyam'),
                    SizedBox(
                      height: 18.h,
                    ),
                    const CustomeContainer(
                        imageLink: 'asset/Mahaan-feat.jpg',
                        title: 'Missing Me',
                        artist: 'Santhosh Narayanan, Dhruv Vikram'),
                    SizedBox(
                      height: 18.h,
                    ),
                    const CustomeContainer(
                        imageLink: 'asset/o-kadhal-kanmani-movie-poster.jpg',
                        title: 'Mental Manathil',
                        artist: 'A R Rehman, Jonitha Gandhi'),
                    SizedBox(
                      height: 18.h,
                    ),
                    const CustomeContainer(
                        imageLink:
                            'asset/2016-Malayalam-Film-Kismath-Nice-Pictures-And-Posters-In-HD.jpg',
                        title: 'Chilatunaam',
                        artist: 'Madhushree')
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
