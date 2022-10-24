import 'package:flutter/material.dart';

import 'Home.dart';
import 'Category.dart';
import 'User.dart';
import 'Cart.dart';

class Tabs extends StatefulWidget {
  const Tabs({Key? key}) : super(key: key);

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 0;
  late PageController _pageController;
  final List<Widget> _pageList = [
    const HomePage(),
    const CategoryPage(),
    const CartPage(),
    const UserPage(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter_shop'),
      ),
      // LIGHT: 使用AutomaticKeepAliveClientMixin 进行状态保持, 必须使用 PageView 进行包裹
      body: PageView(
        controller: _pageController,
        children: _pageList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            // 使用控制器跳转
            _pageController.jumpToPage(index);
          });
        },
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.red,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: "分类"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: "购物车"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "我的")
        ],
      ),
    );
  }
}
