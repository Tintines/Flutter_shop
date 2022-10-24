// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'routers/router.dart';

// import 'pages/tabs/Tabs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(750, 1334), // 配置设计稿的宽度高度
        builder: () => MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                // Try running your application with "flutter run". You'll see the
                // application has a blue toolbar. Then, without quitting the app, try
                // changing the primarySwatch below to Colors.green and then invoke
                // "hot reload" (press "r" in the console where you ran "flutter run",
                // or simply save your changes to "hot reload" in a Flutter IDE).
                // Notice that the counter didn't reset back to zero; the application
                // is not restarted.
                primarySwatch: Colors.blue,
              ),
              // home: const MyHomePage(title: 'Flutter Demo'),
              // home: const Tabs(),

              // initialRoute: '/',
              initialRoute: '/productList',
              onGenerateRoute: onGenerateRoute, // 命名路由
              debugShowCheckedModeBanner: false, // 去掉debug图标
            ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _msg = "";

  // 请求数据
  _getData() async {
    // 获取数据的接口： https://jd.itying.com/api/httpGet
    var response = await Dio().get('https://jd.itying.com/api/httpGet');
    print(response.data);
    print(response.data is Map); // true
    setState(() {
      _msg = response.data["msg"]; // 获取map中的数据
    });
  }

  // 提交数据
  _postData() async {
    // 地址：https://jd.itying.com/api/httpPost
    var response = await Dio().post('https://jd.itying.com/api/httpPost',
        data: {"username": "张三111", "age": "20"});
    print(response.data);
    print(response.data is Map);
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(_msg),
            ElevatedButton(
              child: const Text('Get请求数据'),
              onPressed: _getData,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Post提交数据'),
              onPressed: _postData,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
