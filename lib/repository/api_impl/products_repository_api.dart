import 'package:antons_app/dto/single_product_response.dart';
import 'package:antons_app/repository/api_impl/api_repository.dart';
import 'package:antons_app/repository/products_repository.dart';
import 'package:dio/dio.dart';

import '../../entities/product.dart';

class ProductsRepositoryApi extends ApiRepository implements ProductsRepository{

  @override
  Future<List<Product>> getProductsByCategoryId(String id) async {
    Response response = await ApiRepository.dio.get('/products/category/$id');

    if(response.statusCode == 200){
      List<dynamic> data = response.data;

      List<SingleProductResponse> dtoList = data.map((product) => SingleProductResponse.fromJson(product)).toList();
      List<Product> resultList = dtoList.map((product) => Product.fromSingleProductResponse(product)).toList();
      return resultList;
    }
    else{
      // TODO
    }
    throw Exception(response.statusCode.toString());
  }
}