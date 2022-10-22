import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import '../../services/ScreenAdaper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 轮播图
  Widget _swiperWidget() {
    List<Map> imgList = [
      {"url": "https://www.itying.com/images/flutter/slide01.jpg"},
      {"url": "https://www.itying.com/images/flutter/slide02.jpg"},
      {"url": "https://www.itying.com/images/flutter/slide03.jpg"},
    ];

    return AspectRatio(
      aspectRatio: 2 / 1,
      child: Swiper(
        itemBuilder: (BuildContext context, index) =>
            Image.network(imgList[index]["url"], fit: BoxFit.fill),
        itemCount: imgList.length,
        pagination: const SwiperPagination(),
        autoplay: true,
      ),
    );
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
    // ListView 不能直接嵌套 ListView
    return Container(
      height: ScreenAdaper.height(234),
      padding: EdgeInsets.all(ScreenAdaper.width(20)),
      child: ListView.builder(
        itemBuilder: (context, index) => Column(
          children: [
            Container(
              height: ScreenAdaper.height(140),
              width: ScreenAdaper.width(160),
              margin: EdgeInsets.only(right: ScreenAdaper.width(20)),
              child: Image.network(
                  "https://www.itying.com/images/flutter/hot${index + 1}.jpg",
                  fit: BoxFit.cover),
            ),
            Container(
              height: ScreenAdaper.height(44),
              margin: EdgeInsets.only(top: ScreenAdaper.height(10)),
              child: Text("第$index条"),
            )
          ],
        ),
        scrollDirection: Axis.horizontal,
        itemCount: 10,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        _swiperWidget(),
        const SizedBox(
          height: 12,
        ),
        _titleWidget("猜你喜欢"),
        const SizedBox(
          height: 12,
        ),
        _hotProductListWidget(),
        const SizedBox(
          height: 12,
        ),
        _titleWidget("热门推荐")
      ],
    );
  }
}
