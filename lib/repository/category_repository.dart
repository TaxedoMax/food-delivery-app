import 'dart:convert';

import 'package:antons_app/entities/category.dart';
import 'package:antons_app/dto/single_category_response.dart';
import 'package:antons_app/repository/api_repository.dart';
import 'package:dio/dio.dart';

class CategoryRepository extends ApiRepository{
  Future<List<Category>> getCategories() async{
    Response response;
    response = await ApiRepository.dio.get('/categories');

    if(response.statusCode == 200){
      List<dynamic> data = response.data;

      // Parsing unprocessed list
      List<SingleCategoryResponse> unprocessedList = data
          .map((category) => SingleCategoryResponse.fromJson(category))
          .toList();

      // Processed list (result)
      List<Category> resultList = [];

      // All questions, why does it so - to backend
      for(SingleCategoryResponse category in unprocessedList){
        // Main categories
        if(category.upperCategoryName == null || category.upperCategoryName == ''){
          int index = resultList.indexWhere((element) => element.name == category.name);
          if(index == -1){
            resultList.add(Category(id: category.id, name: category.name, imageUrl: category.imageUrl, subCategories: []));
          }
          else{
            List<Category> subCategories = resultList[index].subCategories;
            resultList.removeAt(index);
            resultList.add(Category(id: category.id, name: category.name, imageUrl: category.imageUrl, subCategories: subCategories));
          }
        }
        // Subcategories
        else{
          int index = resultList.indexWhere((element) => element.name == category.upperCategoryName);
          if(index != -1) {
            resultList[index].subCategories
              .add(Category(id: category.id, name: category.name, imageUrl: category.imageUrl, subCategories: []));
          }
          else{
            resultList.add(Category(id: '', name: category.upperCategoryName!, imageUrl: '', subCategories:
            [
              Category(id: category.id, name: category.name, imageUrl: category.imageUrl, subCategories: [])
            ]));
          }
        }
      }
      return resultList;
    }

    throw Exception(response.statusCode);
  }
}