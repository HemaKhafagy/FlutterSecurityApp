import 'package:flutter/material.dart';

class Product {
  final String id;
   var title;
   var description;
   final double price;
   final String imageUrl;
   //var text;
  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
   // @required this.text
  });
}

class Products with ChangeNotifier {
  List<Product> productsList = [];

  void add(
      {var id,
      var title,
      var description,
      double price,
      String imageUrl,
      //var text,
      }) {
    productsList.add(Product(
      id: id,
      title: title,
      description: description,
      price: price,
      imageUrl: imageUrl,
      //text: text,
    ));

    print(imageUrl);

    notifyListeners();
  }

  void delete(String id) {
    productsList.removeWhere((element) => element.id == id);
    notifyListeners();
    print("Item Deleted");
  }

  void update(String id,String title,String description,double price ,String imageUrl){
    final prodIndex = productsList.indexWhere((element) =>
    element.id == id);
    productsList[prodIndex]=Product(
      id: id,
      title: title,
      description: description,
      price: price,
      imageUrl: imageUrl,
    );
    notifyListeners();
  }



}
