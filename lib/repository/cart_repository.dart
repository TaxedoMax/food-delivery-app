import 'package:antons_app/dto/single_product_response.dart';
import 'package:antons_app/entities/product.dart';
import 'package:antons_app/repository/api_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class CartRepository extends ApiRepository{
  Future<List<Product>> getCart() async {
    Response response = await ApiRepository.dio.get('shopcart');

    if(response.statusCode == 200){
      List<dynamic> data = response.data;
      List<SingleProductResponse> unprocessedList = data
          .map((product) => SingleProductResponse.fromJson(product)).toList();

      List<Product> resultList = unprocessedList
          .map((singleProductResponse) => Product.fromSingleProductResponse(singleProductResponse)).toList();

      return resultList;
    }

    throw Exception(response.statusCode.toString());
    // TODO: not 200 code
  }

  Future<void> addProduct(product) async {
    Response response = await ApiRepository.dio.put('/shopcart/add/${product.id}');
    if(response.statusCode != 200){
      // TODO: continue
      throw Exception(response.statusCode);
    }
  }

  Future<void> removeProduct(product) async {
    Response response = await ApiRepository.dio.put('/shopcart/remove/${product.id}');
    if(response.statusCode != 200){
      // TODO: continue
      throw Exception(response.statusCode);
    }
  }

  Future<bool> order() async{
    try{
      Response response = await ApiRepository.dio.post('/order/create');
      if(response.statusCode == 200){
        return true;
      }
      else{
        // TODO
        return false;
      }
    }
    catch(e){
      debugPrint(e.toString());
      return false;
    }
  }
}