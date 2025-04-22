import 'package:brill_app/features/editor/plugins/list/model/list_note_element.dart';
import 'package:brill_app/features/editor/plugins/list/model/list_type.dart';
import 'package:get/get.dart';

class ListController extends GetxController {
  RxList<ListItem> elements = <ListItem>[].obs;
  Rx<ListType> type = ListType.dots.obs;

  int get elementCount => elements.length;

  void setListType(ListType type) {
    if (type == this.type.value) return;

    this.type.value = type;

    RxList<ListItem> newElements = <ListItem>[].obs;

    for (int i = 0; i < elementCount; i++) {
      final label = elements[i].label;
      switch (type) {
        case ListType.dots:
          newElements.add(BulletedListItem(label: label));
        case ListType.numbers:
          newElements.add(EnumeratedListItem(index: i, label: label));
        case ListType.tasks:
          newElements.add(TodoListItem(done: false, label: label));
      }
    }

    elements.assignAll(newElements);
  }
}
