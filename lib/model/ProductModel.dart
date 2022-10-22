class ProductModel {
  List<ProductItemModel> result = [];

  ProductModel({required this.result});

  ProductModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      json['result'].forEach((v) {
        result.add(ProductItemModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result.map((v) => v.toJson()).toList();
    return data;
  }
}

class ProductItemModel {
  String? sId; // String? 表示可空类型
  String? title;
  String? cid;
  Object? price; // LIGHT: 所有的类型都继承 Object  当接口返回的数据类型不符合时, 可使用Object解决
  String? oldPrice;
  String? pic;
  String? sPic;

  ProductItemModel({sId, title, cid, price, oldPrice, pic, sPic});

  ProductItemModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    cid = json['cid'];
    price = json['price'];
    oldPrice = json['old_price'];
    pic = json['pic'];
    sPic = json['s_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['cid'] = cid;
    data['price'] = price;
    data['old_price'] = oldPrice;
    data['pic'] = pic;
    data['s_pic'] = sPic;
    return data;
  }
}
