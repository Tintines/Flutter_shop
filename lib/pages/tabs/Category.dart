import 'package:flutter/material.dart';
import '../../services/ScreenAdaper.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  int _selectIndex = 0;

  @override
  Widget build(BuildContext context) {
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
        SizedBox(
          width: leftWidth,
          height: double.infinity,
          child: ListView.separated(
            itemCount: 25,
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    _selectIndex = index;
                  });
                },
                child: Container(
                  width: double.infinity,
                  height: ScreenAdaper.height(56),
                  child: Text("第$index条", textAlign: TextAlign.center),
                  color: _selectIndex == index ? Colors.red : Colors.white,
                ),
              );
            },
          ),
        ),
        Expanded(
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
                  itemCount: 18,
                  itemBuilder: (context, index) {
                    return Column(children: [
                      AspectRatio(
                        aspectRatio: 1 / 1,
                        child: Image.network(
                            "https://www.itying.com/images/flutter/list8.jpg",
                            fit: BoxFit.cover),
                      ),
                      SizedBox(
                        height: ScreenAdaper.height(28),
                        child: const Text("女装"),
                      )
                    ]);
                  },
                )))
      ],
    );
  }
}
