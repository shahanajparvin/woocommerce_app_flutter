class OrderProducts {

  OrderProducts(
      { this.id,
        this.name,
        this.imageUrl,
        this.mrp,
        this.stock,
        this.totalCreditValue,
        this.orderCount});

  String id;
  String name;
  String imageUrl;
  String mrp;
  int stock;
  double totalCreditValue;
  int orderCount = 0;


  factory OrderProducts.fromJson(Map<String, dynamic> json,int count) {
    return OrderProducts(
      orderCount:count,
      totalCreditValue:0.0,
      id: json['id'].toString() as String,
      name: json['name'] as String,
      imageUrl: json["images"][0]["src"] as String,
      mrp: json['price'].toString() as String,
      stock: json['stock_quantity']  as int,

    );
  }


}