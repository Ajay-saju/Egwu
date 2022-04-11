import 'package:flutter/material.dart';

ValueNotifier<int> indexChaingeNotifier = ValueNotifier(0);

class MyBottumNavBar extends StatelessWidget {
  const MyBottumNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: indexChaingeNotifier,
      builder: (context, int newIndex, _) {
        return BottomNavigationBar(
          currentIndex: newIndex,
          onTap: (index) {
            indexChaingeNotifier.value = index;
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: '',
                backgroundColor: Color(0xff393372)),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_rounded),
                label: '',
                backgroundColor: Color(0xff96b2ab)),
            BottomNavigationBarItem(
                icon: Icon(Icons.search_outlined),
                label: '',
                backgroundColor: Color(0xff5691bc)),
            BottomNavigationBarItem(
                icon: Icon(Icons.music_video_rounded),
                label: '',
                backgroundColor: Color(0xffbc68fe)),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: '',
                backgroundColor: Color(0xff494949)),
          ],
        );
      },
    );
  }
}
