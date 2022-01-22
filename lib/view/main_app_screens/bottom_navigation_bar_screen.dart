import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phiz/view/main_app_screens/add_product_screen.dart';
import 'package:phiz/view/main_app_screens/home_screen.dart';
import 'package:phiz/view/main_app_screens/profile_screen.dart';
import 'package:phiz/widgets/common_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  @override
  _BottomNavigationBarScreenState createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {

  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Bottom Nav Bar")),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            HomeScreen(),
            AddProductScreen(),
            ProfileScreen(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              title: commonText(title: "Home"),
              icon: Icon(Icons.home,size: 75.r,)
          ),
          BottomNavyBarItem(
              title: Text('Add Product'),
              icon: Icon(CupertinoIcons.add_circled_solid,size: 75.r,)
          ),
          BottomNavyBarItem(
              title: Text('Profile'),
              icon: Icon(CupertinoIcons.person_alt,size: 75.r,)
          ),

        ],
      ),
    );
  }
}
