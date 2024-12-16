import 'package:finalproject/models/diet_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SearchBarController extends GetxController {
  var itemList = <DietModel>[].obs;
  var searchQuery = ''.obs;
  var selectedIngredients = <String>[].obs;
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
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  void updateSelectedIngredients(List<String> selectedIngredients) {
    selectedIngredients = selectedIngredients;
  }

  List<DietModel> get filteredRecipe {
    var filteredItems = itemList;
    if (selectedIngredients.isNotEmpty) {
      filteredItems = filteredItems
          .where((item) {
            return selectedIngredients.any((ingredient) => item.ingredients.contains(ingredient));
          })
          .toList()
          .obs;
    }
    if (searchQuery.isNotEmpty) {
      filteredItems = filteredItems
          .where((item) {
            return item.name.contains(searchQuery.value);
          })
          .toList()
          .obs;
    }
    return filteredItems;
  }

  // TODO: complete the search and filter logic
}

