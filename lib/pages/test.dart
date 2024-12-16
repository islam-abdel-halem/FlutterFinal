// import 'package:filter_list/filter_list.dart';
// import 'package:flutter/material.dart';
// import  'package:finalproject/controllers/SelectedListController.dart';
// import 'package:get/get.dart';

// List<String> DefaultList = [
//   'Flutter',
//   'Dart',
//   'Java',
//   'Kotlin',
// ];

// void main(List<String> args) {
//   runApp(Test());
// }

// class Test extends StatelessWidget {

//   var controller = Get.put(Selectedlistcontroller());

  
//     void openFilterDialog() async {
//     await FilterListDialog.display<String>(
//         listData: DefaultList,
//         selectedListData: controller.getSelectedList(),



//     )
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const SafeArea(child: 
//     Scaffold(

//       body: Center(
      
        
//         ),
//       floatingActionButton: 
//       ),
      
//     );
//   }
// }