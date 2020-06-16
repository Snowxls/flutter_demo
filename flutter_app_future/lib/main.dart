/*
    dart 单线程语言
    异步 != 多线程
 */

import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

String _data = '0';

void main() {
//  getData();

//  testFuture();

//  testFuture2();

//  testFuture3();

//  testFuture4();

//  test1();

//  computeTest();

/*
  //无序
  Future(() {
    compute(func1, 123).then((value) => print('1'));
  });
  Future(() {
    compute(func1, 123).then((value) => print('2'));
  });
  Future(() {
    compute(func1, 123).then((value) => print('3'));
  });
  Future(() {
    compute(func1, 123).then((value) => print('4'));
  });

  //有序
  loadData().then((value) => print('#1'));
  loadData().then((value) => print('#2'));
  loadData().then((value) => print('#3'));
  loadData().then((value) => print('#4'));
 */

/*
  Future x = Future(() {
    print('异步任务');
    scheduleMicrotask(() {
      return print('微任务1');
    });
  });

  Future x2 = Future(() {
    print('异步任务2');
  });

  x.then((value) => print('异步1结束')).then((value) => print('异步1then结束'));
  print('主任务');
 */

  Timer.run(() {
    print('异步任务');
  });
  print('主任务');

  print('其他事情');

  dioDemo();

//  dioDemo2();
}

void dioDemo() {
  //创建dio对象
  final dio = Dio();
  //发送请求
//  dio.get('http://www.baidu.com').then((value) => print(value));
  //下载
  var downloadUrl =
      'http://pub.idqqimg.com/pc/misc/groupgift/fudao/CourseTeacher_1.3.16.80_DailyBuild.dmg';
  String savePath = '/Users/snow/Desktop/down/腾讯课堂.dmg';

  //获取沙盒路径
  String savePath2 = Directory.systemTemp.path + '/腾讯课堂.dmg';
  print(savePath2);

  download(dio, downloadUrl, savePath2);
}

void download(Dio dio, String downloadUrl, String savePath) {
  dio
      .download(downloadUrl, savePath, onReceiveProgress: showDownloadProgress)
      .then((value) => print(value))
      .whenComplete(() => print('end'));
}

void dioDemo2() {
  //创建dio对象
  final dio = Dio();

  //下载
  var downloadUrl =
      'http://pub.idqqimg.com/pc/misc/groupgift/fudao/CourseTeacher_1.3.16.80_DailyBuild.dmg';
  String savePath = '/Users/snow/Desktop/down/腾讯课堂.dmg';

  download2(dio, downloadUrl, savePath);
}

void download2(Dio dio, String downloadUrl, String savePath) {
  dio.download(downloadUrl, (header) {
    return savePath;
  }, onReceiveProgress: showDownloadProgress);
}

void showDownloadProgress(int count, int total) {
//  print('count:$count     total:$total');
  if (total != -1) {
    print((count / total * 100.0).toStringAsFixed(1) + '%');
  }
}

Future loadData() {
  return Future(() {
    //如果返回的是computer的Future 那么这个任务在子Isolate事件队列中
    compute(func1, 123);
  });
}

void func1(int count) {}

int a = 10;

//另一个子线程 基于 Isolate 封装
void computeTest() async {
  print('外部代码1');

  int x = await compute(func3, 10); //能把函数的返回直接传出来

  print(x);

  sleep(Duration(seconds: 1));

  print('外部代码2');
}

int func3(int count) {
  print('complete3');
  return 10000;
}

void test1() async {
  print('外部代码1');

  /*日常使用
  创建Port (线程间的沟通)
   */
  ReceivePort port = ReceivePort();

  /*异步线程 子线程 >Thread 更像进程 有独立的内存空间
    不用担心多线程的资源抢夺 不需要锁
   */
  Isolate iso = await Isolate.spawn(func, port.sendPort); //函数里的a不是外面的a 只是用了a的名字

  //接收信息
  port.listen((message) {
    a = message;
    print(a);
    port.close(); //端口关闭
    iso.kill(); //结束后需要自己干掉
  });

//  Isolate.spawn(func2, 10);
//  Isolate.spawn(func, 10);
//  Isolate.spawn(func2, 10);
//  Isolate.spawn(func, 10);
//  Isolate.spawn(func2, 10);
//  Isolate.spawn(func, 10);
//  Isolate.spawn(func2, 10);
//  Isolate.spawn(func, 10);
//  Isolate.spawn(func2, 10);

  sleep(Duration(seconds: 1));

  print('回来的a:$a');

  print('外部代码2');
}

void func(SendPort send) {
//  a = count;
  print('complete');
//  print('现在的a:$a');
  send.send(1000);
}

void func2(int count) {
  print('complete2');
}

void testFuture4() {
  //顺序执行
  Future x1 = Future(() {
    return null;
  });

  Future x = Future(() {
    print('1');
  });

  Future(() {
    print('2');
  });

  //优先级最高
  scheduleMicrotask(() {
    print('3');
  });

  //是x的then 在x后执行
  x.then((value) {
    print('4');
    Future(() {
      print('9'); //这个是在这个链式结束后才开始创建的
    });
  }).then((value) {
    print('10');
  });

  //不参与异步执行 进入函数后直接执行
  print('5');

  //是x1的then 在x1后执行
  x1.then((value) {
    print('6');
    scheduleMicrotask(() {
      print('7'); //这个微任务是这个时候创建的 会在这个链式结束后立马执行
    });
  }).then((value) {
    print('8'); //then是这个链式的一部分 所以会比 7 早执行
  });
}

void testFuture3() {
  print('外部代码1');

  //时间队列 then类似微任务队列
  Future(() {
    print('A');
  }).then((value) {
    print('A结束');
  });

  Future(() {
    print('B');
  }).then((value) {
    print('B结束');
  });

  //微任务 优先级高于 Future
  scheduleMicrotask(() {
    print('微任务');
  });

  sleep(Duration(seconds: 1));

  print('外部代码2');
}

void testFuture2() {
  Future.wait([
    Future(() {
      return '任务1';
    }),
    Future(() {
      return '任务2';
    }),
  ]).then((value) {
    //数组中的数据都返回后执行
    print(value[0] + value[1]);
  });
}

// then 优先级比 Future 高
void testFuture() {
  //异步代码顺序执行
  Future(() {
    sleep(Duration(seconds: 1)); //后续的任务会等这个任务执行结束后才会执行
    return '任务1';
  }).then((value) {
    print('$value结束');
//    return '任务5';
    throw Exception('Error_233');
  }).then((value) {
    print('$value结束');
    return '任务6';
  }).then((value) {
    print('$value结束');
  }).catchError((e) {
    print('错误信息：' + e.toString());
  });

  Future(() {
    return '任务2';
  }).then((value) => print('$value结束'));

  Future(() {
    return '任务3';
  }).then((value) => print('$value结束'));

  Future(() {
    return '任务4';
  }).then((value) => print('$value结束'));

  print('任务添加完毕');
}

void getData() async {
  print('开始:$_data');

  //异步  使用await后 需要在函数添加 async 修饰
  //await 标识后面的操作必须是异步
  Future future = Future(() {
    //耗时操作
    for (int i = 0; i < 1000000; i++) {
      _data = '网络数据';
    }

    throw Exception('网络异常');

    //return '数据'; //这个就是then后的value的值
  });

  //异常处理 链式使用 先then再catchError
  future.then((value) {
    //使用then来接收数据
    print('then');
    print(value);
  }).catchError((e) {
    print('捕获到了:' + e.toString());
  }).whenComplete(() {
    print('完成了');
  });
  ;

//  future.then((value) {
//    print('then');
//    print(value);
//  }, onError: (e) {
//    print('捕获到了:' + e.toString());
//  });

  print('结束:$_data');

  print('其他事情2');
}
