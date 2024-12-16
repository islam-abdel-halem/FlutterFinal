import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:finalproject/controllers/SearchController.dart'; // Import the controller
import 'package:filter_list/filter_list.dart';
import 'package:finalproject/controllers/SelectedListController.dart';

List<String> DefaultList = ['Eggs', 'bola', 'mola', 'Flour', 'Cheese', 'Milk'];

class TestPage extends StatelessWidget {
  final SearchBarController searchBarcontroller =
      Get.put(SearchBarController());
  final controller = Get.put(Selectedlistcontroller());

  void openFilterDialog(context) async {
    await FilterListDialog.display<String>(
      context,
      listData: DefaultList,
      selectedListData: controller.selectedList,
      choiceChipLabel: (item) => item,
      validateSelectedItem: (list, val) => list!.contains(val),
      onItemSearch: (item, query) {
        return item!.toLowerCase().contains(query.toLowerCase());
      },
      onApplyButtonClick: (list) {
        searchBarcontroller.selectedIngredients.value =
            List<String>.from(list!);
        searchBarcontroller
            .updateSelectedIngredients(searchBarcontroller.selectedIngredients);
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: TextField(
            onChanged: (value) {
              searchBarcontroller.updateSearchQuery(value);
            },
            decoration: InputDecoration(
              hintText: 'Search...',
            ),
          ),
        ),
        body: Center(
          child: Obx(
            () => searchBarcontroller.filteredRecipe.isEmpty
                ? Text('No item found')
                : Wrap(
                    children: searchBarcontroller.filteredRecipe
                        .map((e) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Chip(label: Text(e.name))))
                        .toList(),
                  ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => openFilterDialog(context),
          child: const Icon(Icons.filter_list),
        ),
      ),
    );
  }
}

void main(List<String> args) {
  runApp(MaterialApp(
    home: TestPage(),
  ));
}
