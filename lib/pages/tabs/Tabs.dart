import 'package:flutter/material.dart';
import '../../services/ScreenAdapter.dart';

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
      appBar: _currentIndex != 3
          ? AppBar(
              leading: const IconButton(
                icon: Icon(
                  Icons.center_focus_weak,
                  size: 28,
                  color: Colors.black87,
                ),
                onPressed: null,
              ),
              title: InkWell(
                child: Container(
                  height: ScreenAdapter.height(60),
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(233, 233, 233, 0.8),
                      borderRadius: BorderRadius.circular(30)),
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: Colors.black87),
                      Text(
                        "笔记本",
                        style: TextStyle(
                            fontSize: ScreenAdapter.size(28),
                            color: Colors.black87),
                      )
                    ],
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, "/search");
                },
              ),
              actions: const [
                IconButton(
                  icon: Icon(
                    Icons.message,
                    size: 28,
                    color: Colors.black87,
                  ),
                  onPressed: null,
                )
              ],
            )
          : AppBar(
              title: const Text(
                "用户中心",
                style: TextStyle(color: Colors.black87),
              ),
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
