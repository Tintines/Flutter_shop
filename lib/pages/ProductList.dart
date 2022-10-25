import 'package:flutter/material.dart';
import '../services/ScreenAdaper.dart';
import '../config/Config.dart';
import 'package:dio/dio.dart';

class ProductList extends StatefulWidget {
  final Map? arguments;
  const ProductList({Key? key, this.arguments}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("商品列表"),
        // 导航栏左侧菜单
        leading: IconButton(
          // 注意：新版本的Flutter中加入Drawer组件会导致默认的返回按钮失效，所以需要手动加上返回按钮
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        // 导航栏右侧菜单按钮  返回空Widget(隐藏自动生成的menu菜单按钮)
        actions: const <Widget>[Text("")],
      ),
      endDrawer: const Drawer(child: Text("实现是啊选功能")),
      body: Stack(
        children: <Widget>[
          _productListWidget(),
          _subHeaderWidget(), // 下层元素遮挡上层元素
        ],
      ),
    );
  }

  // 商品列表
  Padding _productListWidget() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
        itemBuilder: ((context, index) {
          return Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  // 左侧商品图片
                  SizedBox(
                    width: ScreenAdaper.width(180),
                    height: ScreenAdaper.height(180),
                    child: Image.network(
                        "https://www.itying.com/images/flutter/list2.jpg",
                        fit: BoxFit.cover),
                  ),
                  // 右侧商品详情
                  Expanded(
                    flex: 1,
                    child: Container(
                      height:
                          ScreenAdaper.height(180), // 定高, 用于子元素Colum 设置主轴排列方式
                      margin: const EdgeInsets.only(left: 10),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                                "戴尔(DELL)灵越3670 英特尔酷睿i5 高性能 台式电脑整机(九代i5-9400 8G 256G)",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis),
                            Row(
                              children: <Widget>[
                                Container(
                                  height: ScreenAdaper.height(36),
                                  margin: const EdgeInsets.only(right: 10),
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  // 注意 如果Container里面加上decoration属性，这个时候color属性必须得放在BoxDecoration
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color.fromRGBO(
                                        230, 230, 230, 0.9),
                                  ),

                                  child: const Text("4g"),
                                ),
                                Container(
                                  height: ScreenAdaper.height(36),
                                  margin: const EdgeInsets.only(right: 10),
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color.fromRGBO(
                                        230, 230, 230, 0.9),
                                  ),
                                  child: const Text("126"),
                                ),
                              ],
                            ),
                            const Text(
                              "¥990",
                              style: TextStyle(color: Colors.red, fontSize: 16),
                            )
                          ]),
                    ),
                  )
                ],
              ),
              const Divider(
                height: 20,
              )
            ],
          );
        }),
        itemCount: 10,
      ),
    );
  }

  // 筛选
  Widget _subHeaderWidget() {
    return Positioned(
      top: 0,
      height: ScreenAdaper.height(80),
      width: ScreenAdaper.width(750), // LIGHT: 设计稿尺寸
      child: Container(
        width: ScreenAdaper.width(750),
        height: ScreenAdaper.height(80),
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1, color: Color.fromRGBO(233, 233, 233, 0.9)))),
        child: Row(children: [
          Expanded(
              flex: 1,
              child: InkWell(
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    "综合",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red), // TODO: 动态背景色
                  ),
                ),
                onTap: () {},
              )),
          Expanded(
              flex: 1,
              child: InkWell(
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    "销量",
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: () {},
              )),
          Expanded(
              flex: 1,
              child: InkWell(
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    "价格",
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: () {},
              )),
          Expanded(
              flex: 1,
              child: InkWell(
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    "筛选",
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: () {
                  // 注意：新版本中ScaffoldState? 为可空类型 注意判断
                  if (_scaffoldKey.currentContext != null) {
                    _scaffoldKey.currentState!.openEndDrawer(); // 打开侧边栏
                  }
                },
              )),
        ]),
      ),
    );
  }
}
