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
      body: const Text('搜索'),
    );
  }
}
