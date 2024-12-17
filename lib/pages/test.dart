import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:finalproject/controllers/SelectedListController.dart';
import 'package:get/get.dart';

List<String> DefaultList = [
  'Flutter',
  'Dart',
  'Java',
  'Kotlin',
];

void main(List<String> args) {
  runApp(MaterialApp(
    home: Test(),
  ));
}

class Test extends StatelessWidget {

  var controller = Get.put(Selectedlistcontroller());

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
        controller.selectedList.value = List<String>.from(list!);
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Obx(
          () => controller.selectedList.length == 0
              ? Text('No item selected')
              : Wrap(
                  children: controller.selectedList
                      .map((e) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Chip(label: Text(e))))
                      .toList(),
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openFilterDialog(context),
        child: const Icon(Icons.filter_list),
      ),
    ));
  }
}
