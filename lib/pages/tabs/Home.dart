import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

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
      height: ScreenUtil().setHeight(34),
      margin: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
      padding: EdgeInsets.only(left: ScreenUtil().setHeight(20)),
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(
                  color: Colors.red, width: ScreenUtil().setWidth(10)))),
      child: Text(
        value,
        style:
            TextStyle(color: Colors.black54, fontSize: ScreenUtil().setSp(26)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
        _titleWidget("热门推荐")
      ],
    );
  }
}
