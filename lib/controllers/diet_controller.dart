import 'package:finalproject/models/diet_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:finalproject/data/data_helper.dart';

class DietController extends GetxController {
  var itemList = List<DietModel>.empty(growable: true).obs;
  var searchQuery = ''.obs;
  var selectedIngredients = List<String>.empty(growable: true).obs;
  @override
  void onInit() {
    super.onInit();
    // Initialize with some items

    List<DietModel> items = [
      DietModel(
          name: 'Canai Bread',
          ingredients: ['Pasta', 'Tomato', 'Cheese'],
          iconPath: 'assets/icons/canai-bread.svg',
          level: 'Easy',
          duration: '20mins',
          calorie: '230kCal',
          viewIsSelected: false,
          boxColor: const Color(0xffEEA4CE)),
      DietModel(
          name: 'Honey Pancake',
          ingredients: ['Pizza base', 'Tomato', 'Cheese'],
          iconPath: 'assets/icons/honey-pancakes.svg',
          level: 'Easy',
          duration: '30mins',
          calorie: '180kCal',
          viewIsSelected: false,
          boxColor: const Color(0xff9DCEFF)),
      DietModel(
          name: 'Honey Pancake',
          ingredients: ['Burger bun', 'Tomato', 'Cheese'],
          iconPath: 'assets/icons/honey-pancakes.svg',
          level: 'Easy',
          duration: '30mins',
          calorie: '180kCal',
          viewIsSelected: false,
          boxColor: const Color(0xff9DCEFF)),
      DietModel(
          name: 'Canai Bread',
          ingredients: ['Bread', 'Tomato', 'Cheese'],
          iconPath: 'assets/icons/canai-bread.svg',
          level: 'Easy',
          duration: '20mins',
          calorie: '230kCal',
          viewIsSelected: false,
          boxColor: const Color(0xffEEA4CE)),
    ];
    itemList.addAll([items[0], items[1], items[2], items[3]]);
    addDiet(items[0]);
    addDiet(items[1]);
    addDiet(items[2]);
    addDiet(items[3]);

  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  void updateSelectedIngredients(List<String> selectedIngredients) {
    this.selectedIngredients.value = selectedIngredients;
  }

  List<DietModel> get filteredRecipe {

    if ( searchQuery.isEmpty) {
      return List.empty();
    }
    var filteredItems = itemList.toList();

    if (selectedIngredients.isNotEmpty) {

      filteredItems = filteredItems
          .where((item) {
            return item.ingredients.any((ingredient) {
              return selectedIngredients.contains(ingredient);
            });
          })
          .toList();
         
    }
    if (searchQuery.isNotEmpty) {
      filteredItems = filteredItems
          .where((item) {
            return item.name.contains(searchQuery.value);
          })
          .toList(); 
    }
    return filteredItems;
  }

final dbHelper = DatabaseHelper();

void addDiet(DietModel diet) async {
  await dbHelper.insertDiet(diet);
  print('Diet added to the database!');
}



}