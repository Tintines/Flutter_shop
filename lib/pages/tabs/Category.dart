import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../../services/ScreenAdaper.dart';
import '../../config/Config.dart';
import '../../model/CateModel.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin {
  int _selectIndex = 0;
  List _leftCateList = [];
  List _rightCateList = [];

  @override
  void initState() {
    super.initState();
    _getLeftCateData();
  }

  // 左侧分类接口请求
  _getLeftCateData() async {
    var api = '${Config.domain}api/pcate';
    var result = await Dio().get(api);
    var leftCateList = CateModel.fromJson(result.data);
    // print(leftCateList.result);
    setState(() {
      _leftCateList = leftCateList.result;
    });
    _getRightCateData(leftCateList.result[0].sId);
  }

  // 右侧分类
  _getRightCateData(pid) async {
    var api = '${Config.domain}api/pcate?pid=$pid';
    var result = await Dio().get(api);
    var rightCateList = CateModel.fromJson(result.data);
    // print(rightCateList.result);
    setState(() {
      _rightCateList = rightCateList.result;
    });
  }

  // 左侧分类
  Widget _leftCateWidget(leftWidth) {
    if (_leftCateList.isNotEmpty) {
      // 左侧
      return SizedBox(
        width: leftWidth,
        height: double.infinity,
        child: ListView.separated(
          itemCount: _leftCateList.length,
          separatorBuilder: (BuildContext context, int index) =>
              // Divider 默认高度16
              const Divider(
            height: 1,
          ),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                setState(() {
                  _selectIndex = index;
                  // 请求对应分类数据
                  _getRightCateData(_leftCateList[index].sId);
                });
              },
              child: Container(
                width: double.infinity,
                height: ScreenAdaper.height(84),
                padding: EdgeInsets.only(top: ScreenAdaper.height(28)),
                child: Text("第${_leftCateList[index].title}条",
                    textAlign: TextAlign.center),
                color: _selectIndex == index
                    ? const Color.fromRGBO(240, 246, 246, 0.9)
                    : Colors.white,
              ),
            );
          },
        ),
      );
    } else {
      // 空数据时, 定宽度 占位 防变形
      return SizedBox(
        width: leftWidth,
        height: double.infinity,
      );
    }
  }

  // 右侧分类
  Widget _rightCateWidget(rightItemWidth, rightItemHeight) {
    if (_rightCateList.isNotEmpty) {
      return Expanded(
          flex: 1,
          child: Container(
              padding: const EdgeInsets.all(10),
              height: double.infinity,
              color: const Color.fromRGBO(240, 246, 246, 0.9),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: rightItemWidth / rightItemHeight,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: _rightCateList.length,
                itemBuilder: (context, index) {
                  String pic = _rightCateList[index].pic;
                  pic = Config.domain + pic.replaceAll('\\', '/');
                  return Column(children: [
                    AspectRatio(
                      aspectRatio: 1 / 1,
                      child: Image.network(pic, fit: BoxFit.cover),
                    ),
                    SizedBox(
                      height: ScreenAdaper.height(28),
                      child: Text("${_rightCateList[index].title}"),
                    )
                  ]);
                },
              )));
    } else {
      // 空数据时, 定宽度 占位 防变形
      return Expanded(
        flex: 1,
        child: Container(
          padding: const EdgeInsets.all(10),
          height: double.infinity,
          color: const Color.fromRGBO(240, 246, 246, 0.9),
          child: const Center(
            child: Text("加载中..."),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // LIGHT: 使用使用了AutomaticKeepAliveClientMixin方法时, 需要调用

    // 左侧宽度
    var leftWidth = ScreenAdaper.getScreenWidth() / 4;
    // 右侧每一项宽度 = (总宽度-左侧宽度-GridView外侧元素左右的Padding-GridView中的间距) / 3
    var rightItemWidth =
        (ScreenAdaper.getScreenWidth() - leftWidth - 20 - 20) / 3;
    // 获取计算后宽度
    rightItemWidth = ScreenAdaper.width(rightItemWidth);
    // 获取计算后的高度
    var rightItemHeight = rightItemWidth + ScreenAdaper.height(20);

    return Row(
      children: [
        // 左侧
        _leftCateWidget(leftWidth),

        // 右侧
        _rightCateWidget(rightItemWidth, rightItemHeight),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true; // 按需返回true进行页面状态保持
}
