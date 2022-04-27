import 'package:feather_icons/feather_icons.dart';

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
          showUnselectedLabels: false,
          showSelectedLabels: true,
          currentIndex: newIndex,
          onTap: (index) {
            indexChaingeNotifier.value = index;
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                tooltip: 'Home',
                icon: Icon(FeatherIcons.home),
                label: '•',
                backgroundColor: Color(0xff393372)),
            BottomNavigationBarItem(
                tooltip: 'Favourite',
                icon: Icon(FeatherIcons.heart),
                label: '•',
                backgroundColor: Color(0xff96b2ab)),
            BottomNavigationBarItem(
                tooltip: 'Search',
                icon: Icon(FeatherIcons.search),
                label: '•',
                backgroundColor: Color(0xff5691bc)),
            BottomNavigationBarItem(
                tooltip: 'Play List',
                icon: Icon(FeatherIcons.music),
                label: '•',
                backgroundColor: Color(0xffbc68fe)),
            BottomNavigationBarItem(
                tooltip: 'Settings',
                icon: Icon(FeatherIcons.settings),
                label: '•',
                backgroundColor: Color(0xff494949)),
          ],
        );
      },
    );
  }
}
