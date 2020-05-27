//Dart中没有析构函数的 垃圾回收机制

class Car {

  final String name;
  final String imageUrl;

  // 成员全部是final时可以用const修饰
  const Car({
    this.name,
    this.imageUrl
  });
//  Car(this.name,{this.imageUrl});//这时imageUrl为可选参数

  // 命名构造函数
//  Car.fromList(List<dynamic> list) {
//    name = list[0];
//    imageUrl = list[1];
//  }

  // 重定向
  Car.defaults(String name,String url):this(name:name,imageUrl:url); //defaults定向到同名的Car()函数
}
