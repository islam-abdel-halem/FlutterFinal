import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:finalproject/controllers/SearchController.dart'; // Import the controller
import 'package:filter_list/filter_list.dart';

List<String> DefaultList = ['Pasta', 'Tomato', 'Cheese','Pizza base'];

class TestPage extends StatelessWidget {
  final SearchBarController searchBarcontroller = Get.put(SearchBarController());
  final FocusNode searchFocusNode = FocusNode();

  void openFilterDialog(context) async {
    await FilterListDialog.display<String>(
      context,
      listData: DefaultList,
      selectedListData: searchBarcontroller.selectedIngredients.toList(),
      choiceChipLabel: (item) => item,
      validateSelectedItem: (list, val) => list!.contains(val),
      onItemSearch: (item, query) {
        return item!.toLowerCase().contains(query.toLowerCase());
      },
      onApplyButtonClick: (list) {
        searchBarcontroller.updateSelectedIngredients(List<String>.from(list!));
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
            focusNode: searchFocusNode,
            onTapOutside: (event) => searchFocusNode.unfocus(),

            onChanged: (value) {
              searchBarcontroller.updateSearchQuery(value);
            },
            decoration: InputDecoration(
              hintText: 'Search...',
            ),
          ),
        ),
       body: Obx(() {
          if (searchFocusNode.hasFocus) {
            // show widget from down to up when search bar is focused
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: searchBarcontroller.itemList.length,
                    itemBuilder: (context, index) {
                      final recipe = searchBarcontroller.itemList[index];
                      return ListTile(
                        title: Text(recipe.name),
                        subtitle: Text('Ingredients: ${recipe.ingredients.join(', ')}'),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (searchBarcontroller.filteredRecipe.isEmpty) {
            return Center(child: Text('No recipes found'));
          } else {
            return ListView.builder(
              itemCount: searchBarcontroller.filteredRecipe.length,
              itemBuilder: (context, index) {
                final recipe = searchBarcontroller.filteredRecipe[index];
                return ListTile(
                  title: Text(recipe.name),
                  subtitle: Text('Ingredients: ${recipe.ingredients.join(', ')}'),
                );
              },
            );
          }
        }),
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
