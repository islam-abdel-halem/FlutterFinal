import 'package:get/get.dart';

class Selectedlistcontroller extends GetxController {
  var selectedList = List<String>.empty(growable: true).obs;  

  getSelectedList() {
    return selectedList;
  }

  setSelectedList(List<String> list) {
    selectedList = list.obs;
  }

  



}