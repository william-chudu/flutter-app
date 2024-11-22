import 'package:chudu24/constants/index.dart';
import 'package:chudu24/modules/favourite_hotel/index.dart';
import 'package:chudu24/modules/home/index.dart';
import 'package:chudu24/modules/journey/index.dart';
import 'package:chudu24/modules/account/index.dart';
import 'package:chudu24/modules/travel_news/index.dart';
import 'package:flutter/material.dart';

final class BottomTabsScreen extends StatefulWidget {
  static const String routeName = '/bottom-tabs';
  static Route route() {
    return MaterialPageRoute(
      builder: (BuildContext context) => const BottomTabsScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const BottomTabsScreen({super.key});

  @override
  State<BottomTabsScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<BottomTabsScreen> {
  int _indexPage = 0;
  final List<Widget> pages = [
    HomeScreen.screen,
    FavouriteHotel.screen,
    Journey.screen,
    TravelNews.screen,
    Account.screen,
  ];
  void _onItemTapped(value) {
    setState(() {
      _indexPage = value;
    });
  }

  final List<BottomNavigationBarItem> _items = [
    BottomNavigationBarItem(
      icon: const Icon(Icons.home),
      label: AppConstants.shared.label.home,
      activeIcon: const Icon(Icons.home, size: 25),
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.favorite),
      label: AppConstants.shared.label.favorite,
      activeIcon: const Icon(Icons.favorite, size: 25),
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.shopping_bag_outlined),
      label: AppConstants.shared.label.journey,
      activeIcon: const Icon(Icons.shopping_bag_outlined, size: 25),
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.edit_document),
      label: AppConstants.shared.label.news,
      activeIcon: const Icon(Icons.edit_document, size: 25),
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.person_pin),
      label: AppConstants.shared.label.account,
      activeIcon: const Icon(Icons.person_pin, size: 25),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        // backgroundColor: Colors.grey[50],
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: AppConstants.accent,
        unselectedItemColor: Colors.grey,
        currentIndex: _indexPage,
        elevation: 1,
        iconSize: 20,
        items: _items,
        onTap: _onItemTapped,
      ),
      body: pages[_indexPage],
    );
  }
}
