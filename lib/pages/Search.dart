import 'package:flutter/material.dart';
import '../services/ScreenAdapter.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          ),
          height: ScreenAdapter.height(60),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(233, 233, 233, 0.8),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
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
            onTap: () {},
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Text(
              "热搜",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            const Divider(),
            Wrap(
              runSpacing: 10,
              spacing: 10,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(233, 233, 233, 0.9),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text("女装"),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(233, 233, 233, 0.9),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text("男装"),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(233, 233, 233, 0.9),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text("笔记本电脑"),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(233, 233, 233, 0.9),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text("鞋子"),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(233, 233, 233, 0.9),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text("奥特曼"),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(233, 233, 233, 0.9),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text("裤子哦噢噢噢噢"),
                ),
              ],
            ),
            const SizedBox(
              height: 100,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                width: ScreenAdapter.width(400),
                height: ScreenAdapter.height(64),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black45, width: 1)),
                child: Row(
                  children: const [Icon(Icons.delete), Text("清空历史记录")],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
