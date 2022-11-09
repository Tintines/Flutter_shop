import 'package:flutter/material.dart';
import '../services/ScreenAdapter.dart';
import '../config/Config.dart';
import 'package:dio/dio.dart';
import '../model/ProductModel.dart';
import '../widget/LoadingWidget.dart';

class ProductList extends StatefulWidget {
  final Map? arguments;
  const ProductList({Key? key, this.arguments}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // 用于上拉分页
  final ScrollController _scrollController = ScrollController();

  // 分页
  int _page = 1;
  final int _pageSize = 8;

  List _productList = [];
  // 排序:价格升序 sort=price_1 价格降序 sort=price_-1  销量升序 sort=salecount_1 销量降序 sort=salecount_-1
  String _sort = "";
  // 解决重复请求的问题
  bool flag = true;
  // 是由有数据
  bool _hasMore = true;

  // 二级导航
  final List<Map<String, dynamic>> _subHeaderList = [
    {"id": 1, "title": "综合", "fileds": "all", "sort": -1},
    {"id": 2, "title": "销量", "fileds": "salecount", "sort": -1},
    {"id": 3, "title": "价格", "fileds": "price", "sort": -1},
    {"id": 4, "title": "综合"},
  ];
  // 二级导航选中判断
  int _selectHeaderId = 1;

  // 获取搜索框的控制器
  final TextEditingController _initKeywordsController = TextEditingController();

  // 分类id    如果指定类型可空时 String? _cid;
  String? _cid;
  // 搜索关键词
  String? _keywords;

  @override
  void initState() {
    super.initState();

    _cid = widget.arguments?["cid"];
    _keywords = widget.arguments?["keywords"];
    // 给搜索框赋值
    if (_keywords != null) {
      _initKeywordsController.text = _keywords!; // 此时一定有值
    }

    _getProductListData();

    // 上拉监听 (通过监听滚动条滚动事件)
    _scrollController.addListener(() {
      // _scrollController.position.pixels           获取滚动条滚动的高度
      // _scrollController.position.maxScrollExtent  获取页面的高度
      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent - 20) {
        // 避免重复请求
        if (flag && _hasMore) {
          _getProductListData();
        }
      }
    });
  }

  // 获取商品列表数据
  _getProductListData() async {
    setState(() {
      flag = false;
    });
    // Map 数据类型 取值 map["xxx"]
    final String api;
    if (_keywords == null) {
      api =
          '${Config.domain}api/plist?cid=$_cid&page=$_page&sort=$_sort&pageSize=$_pageSize';
    } else {
      api =
          '${Config.domain}api/plist?search=$_keywords&page=$_page&sort=$_sort&pageSize=$_pageSize';
    }
    print(api);
    var result = await Dio().get(api);
    var productList = ProductModel.fromJson(result.data);
    print(productList.result.length);

    // 判断是否有搜索数据, 且当请求第一页时就进行判断!!!(当不是第一页,如第二页返回时数据为空时会导致误判)
    if (productList.result.isEmpty && _page == 1) {
      _hasMore = false;
    } else {
      _hasMore = true;
    }

    // 判断是否为最后一页
    if (productList.result.length < _pageSize) {
      setState(() {
        _productList.addAll(productList.result); // 追加数据(上拉加载)
        _hasMore = false;
        flag = true;
      });
    } else {
      setState(() {
        _productList.addAll(productList.result);
        _page++;
        flag = true;
      });
    }
  }

  // 导航改变时触发
  _subHeaderChange(id) {
    if (id == 4) {
      _scaffoldKey.currentState!.openDrawer();
      setState(() {
        _selectHeaderId = id;
      });
    } else {
      setState(() {
        _selectHeaderId = id;
        _sort =
            "${_subHeaderList[id - 1]["fileds"]}_${_subHeaderList[id - 1]["sort"]}";
        // 重置数据
        _page = 1;
        _productList = [];
        _hasMore = true;
        _subHeaderList[id - 1]['sort'] = _subHeaderList[id - 1]['sort'] * -1;
        // 回到顶部
        _scrollController.jumpTo(0);
        // 重新请求
        _getProductListData();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Container(
          child: TextField(
            autofocus: true,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none),
                contentPadding:
                    const EdgeInsets.only(left: 20, right: 20)), // 垂直居中
            onChanged: (value) {
              _keywords = value;
            },
          ),
          height: ScreenAdapter.height(60),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(233, 233, 233, 0.8),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        // 导航栏左侧菜单
        leading: IconButton(
          // 注意：新版本的Flutter中加入Drawer组件会导致默认的返回按钮失效，所以需要手动加上返回按钮
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        // 导航栏右侧菜单按钮  返回空Widget(隐藏自动生成的menu菜单按钮)
        actions: <Widget>[
          InkWell(
            child: SizedBox(
              height: ScreenAdapter.height(60),
              width: ScreenAdapter.width(100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Text(
                    "搜索",
                    style: TextStyle(color: Colors.black87),
                  )
                ],
              ),
            ),
            onTap: () {
              _subHeaderChange(1);
            },
          )
        ],
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
  Widget _productListWidget() {
    if (_productList.isNotEmpty) {
      return Container(
        padding: const EdgeInsets.all(10),
        margin: EdgeInsets.only(top: ScreenAdapter.height(80)),
        child: ListView.builder(
          controller: _scrollController, // 滚动控制器
          itemCount: _productList.length,
          itemBuilder: ((context, index) {
            String pic = _productList[index].pic;
            pic = Config.domain + pic.replaceAll('\\', '/');

            return Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    // 左侧商品图片
                    SizedBox(
                      width: ScreenAdapter.width(180),
                      height: ScreenAdapter.height(180),
                      child: Image.network(pic, fit: BoxFit.cover),
                    ),
                    // 右侧商品详情
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: ScreenAdapter.height(
                            180), // 定高, 用于子元素Colum 设置主轴排列方式
                        margin: const EdgeInsets.only(left: 10),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${_productList[index].title}",
                                  maxLines: 2, overflow: TextOverflow.ellipsis),
                              Row(
                                children: <Widget>[
                                  Container(
                                    height: ScreenAdapter.height(36),
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
                                    height: ScreenAdapter.height(36),
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
                              Text(
                                "${_productList[index].price}",
                                style: const TextStyle(
                                    color: Colors.red, fontSize: 16),
                              )
                            ]),
                      ),
                    )
                  ],
                ),
                const Divider(
                  height: 20,
                ),
                // 底部加载状态
                _showMore(index)
              ],
            );
          }),
        ),
      );
    } else {
      return const LoadingWidget();
    }
  }

  // 筛选
  Widget _subHeaderWidget() {
    return Positioned(
      top: 0,
      height: ScreenAdapter.height(80),
      width: ScreenAdapter.width(750), // LIGHT: 设计稿尺寸
      child: Container(
        width: ScreenAdapter.width(750),
        height: ScreenAdapter.height(80),
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1, color: Color.fromRGBO(233, 233, 233, 0.9)))),
        child: Row(
            children: _subHeaderList
                .map(
                  (item) => Expanded(
                      flex: 1,
                      child: InkWell(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              0,
                              ScreenAdapter.height(16),
                              0,
                              ScreenAdapter.height(16)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                item['title'],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: _selectHeaderId == item["id"]
                                        ? Colors.red
                                        : Colors.black54),
                              ),
                              _showIcon(item["id"])
                            ],
                          ),
                        ),
                        onTap: () {
                          _subHeaderChange(item["id"]);
                        },
                      )),
                )
                .toList()),
      ),
    );
  }

  // header icon
  Widget _showIcon(id) {
    if (id == 2 || id == 3) {
      if (_subHeaderList[id - 1]["sort"] == 1) {
        return const Icon(Icons.arrow_drop_down);
      }
      return const Icon(Icons.arrow_drop_up);
    }
    return const Text("");
  }

  // 页面底部状态  加载中... / 底线
  Widget _showMore(index) {
    if (_hasMore) {
      return (index == _productList.length - 1)
          ? const LoadingWidget()
          : const Text("");
    } else {
      return (index == _productList.length - 1)
          ? const Text("--我是有底线的--")
          : const Text("");
    }
  }
}
