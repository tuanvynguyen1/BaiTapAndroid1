import 'dart:convert';

import 'package:http/http.dart' as http;

class product{
  final int id;
  final String title;
  final String price;
  final String description;
  final String category;
  final String image;
  final String rate;
  final int count;
   product(this.id, this.title, this.price, this.description, this.category, this.image, this.rate, this.count);
//  product(this.id, this.title, this.description, this.category, this.image, this.count);
  static Future<List<product>> fetchData() async{
      String url = "https://fakestoreapi.com/products";
      var client = http.Client();
      var response = await client.get(Uri.parse(url));
      List<product> ls = [];
      if(response.statusCode == 200){
        print('Tai du lieu thanh cong');
        var result = response.body;
        var jsonData = jsonDecode(result);

        for(var item in jsonData){
          var id = item['id'];
          var title = item['title'];
          var price = item['price'].toString();
          var description = item['description'];
          var category = item['category'];
          var image = item['image'];
          var rate = item['rating']['rate'].toString();
          var count = item['rating']['count'];
          product p = product(id, title, price, description, category, image, rate, count);
          ls.add(p);
        }
        return ls;
      }
      else{
        print('Tai du lieu that bai');
        throw Exception("Loi lay du lieu. Chi tiết: ${response.statusCode}");
      }
  }

}