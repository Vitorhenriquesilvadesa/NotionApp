import 'package:brill_app/features/editor/model/note_element.dart';
import 'package:get/get.dart';

class EditorController extends GetxController {
  final RxString pageTitle = ''.obs;
  final RxList<NoteElement> elements = <NoteElement>[].obs;

  void onPageTitleInsert(String title) {
    pageTitle.value = title;
  }

  int get elementCount => elements.length;

  void insertElement(int index, NoteElement element) {
    elements.insert(index, element);
  }

  void reorderElement(int oldIndex, int newIndex) {
    final element = elements.removeAt(oldIndex);
    if (newIndex > oldIndex) newIndex--;
    elements.insert(newIndex, element);
  }
}
