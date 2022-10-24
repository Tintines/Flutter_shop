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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("商品列表"),
      ),
      body: Padding(
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
                                style:
                                    TextStyle(color: Colors.red, fontSize: 16),
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
      ),
    );
  }
}
