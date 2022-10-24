import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:dio/dio.dart';
import '../../services/ScreenAdaper.dart';
import '../../config/Config.dart';
import '../../model/FocusModel.dart';
import '../../model/ProductModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  List _focusData = [];
  List _hotProductList = [];
  List _bestProductList = [];

  @override
  void initState() {
    super.initState();
    _getFocusData();
    _getHotProductData();
    _getBestProductData();
  }

  // 获取轮播图数据
  _getFocusData() async {
    var api = "${Config.domain}api/focus";
    var result = await Dio().get(api);
    // print(result.data);
    var focusList = FocusModel.fromJson(result.data);
    // print(focusList.result);
    setState(() {
      _focusData = focusList.result;
    });
  }

  // 获取猜你喜欢的数据
  _getHotProductData() async {
    var api = '${Config.domain}api/plist?is_hot=1';
    var result = await Dio().get(api);
    // print(result);
    var hotProductList = ProductModel.fromJson(result.data);
    // print(hotProductList.result);
    setState(() {
      _hotProductList = hotProductList.result;
    });
  }

  // 获取热门推荐的数据
  _getBestProductData() async {
    var api = '${Config.domain}api/plist?is_best=1';
    var result = await Dio().get(api);
    var bestProductList = ProductModel.fromJson(result.data);
    // print(bestProductList.result);
    setState(() {
      _bestProductList = bestProductList.result;
    });
  }

  // 轮播图
  Widget _swiperWidget() {
    if (_focusData.isNotEmpty) {
      return AspectRatio(
        aspectRatio: 2 / 1,
        child: Swiper(
          itemBuilder: (BuildContext context, index) {
            String pic = _focusData[index].pic;
            pic = Config.domain + pic.replaceAll('\\', '/');
            return Image.network(pic, fit: BoxFit.fill);
          },
          itemCount: _focusData.length,
          pagination: const SwiperPagination(),
          autoplay: true,
        ),
      );
    } else {
      return const Text("加载中...");
    }
  }

  // 标题
  Widget _titleWidget(value) {
    return Container(
      height: ScreenAdaper.height(34),
      margin: EdgeInsets.only(left: ScreenAdaper.width(20)),
      padding: EdgeInsets.only(left: ScreenAdaper.height(20)),
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(
                  color: Colors.red, width: ScreenAdaper.width(10)))),
      child: Text(
        value,
        style:
            TextStyle(color: Colors.black54, fontSize: ScreenAdaper.size(26)),
      ),
    );
  }

  // 热门商品
  Widget _hotProductListWidget() {
    if (_hotProductList.isNotEmpty) {
      // ListView 不能直接嵌套 ListView
      return Container(
        height: ScreenAdaper.height(184),
        padding: EdgeInsets.symmetric(horizontal: ScreenAdaper.width(20)),
        child: ListView.builder(
          itemBuilder: (context, index) {
            String sPic = _hotProductList[index].sPic;
            sPic = Config.domain + sPic.replaceAll('\\', '/');

            return Column(
              children: [
                Container(
                  height: ScreenAdaper.height(140),
                  width: ScreenAdaper.width(160),
                  margin: EdgeInsets.only(right: ScreenAdaper.width(20)),
                  child: Image.network(sPic, fit: BoxFit.cover),
                ),
                Container(
                  // height: ScreenAdaper.height(30),
                  margin: EdgeInsets.only(top: ScreenAdaper.height(10)),
                  child: Text(
                    "¥${_hotProductList[index].price}",
                    style: const TextStyle(color: Colors.red),
                  ),
                )
              ],
            );
          },
          scrollDirection: Axis.horizontal,
          itemCount: 10,
        ),
      );
    } else {
      return const Text("加载中...");
    }
  }

  // 热门推荐
  // LIGHT: 由于ListView和GridView都是可以滚动的组件, 所以嵌套的时候要注意把里面的组件改成不可滚动的组件
  Widget _recProductListWidget() {
    double _itemWidth = (ScreenAdaper.getScreenWidth() - 30) / 2;
    return Container(
      padding: const EdgeInsets.all(10),
      child: Wrap(
        runSpacing: 10,
        spacing: 10,
        children: _bestProductList.map((value) {
          String sPic = value.sPic;
          sPic = Config.domain + sPic.replaceAll('\\', '/');

          return Container(
            padding: const EdgeInsets.all(10),
            width: _itemWidth,
            decoration: BoxDecoration(
                border: Border.all(
                    color: const Color.fromRGBO(233, 233, 233, 0.9),
                    width: 1.0)),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity, // 撑满父级宽度
                  // 放置服务器返回的图片尺寸不一致
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: Image.network(sPic, fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: ScreenAdaper.height(20)),
                  child: Text(
                    "${value.title}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.black54),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: ScreenAdaper.height(20)),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "${value.price}",
                          style:
                              const TextStyle(color: Colors.red, fontSize: 16),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "${value.oldPrice}",
                          style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                              decoration: TextDecoration.lineThrough),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // LIGHT: 使用使用了AutomaticKeepAliveClientMixin方法时, 需要调用

    return ListView(
      children: <Widget>[
        _swiperWidget(),
        const SizedBox(
          height: 10,
        ),
        _titleWidget("猜你喜欢"),
        const SizedBox(
          height: 10,
        ),
        _hotProductListWidget(),
        const SizedBox(
          height: 10,
        ),
        _titleWidget("热门推荐"),
        _recProductListWidget(),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true; // 按需返回true进行页面状态保持
}
