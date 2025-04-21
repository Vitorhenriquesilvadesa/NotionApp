import 'package:brill_app/features/editor/model/note_element.dart';
import 'package:brill_app/features/editor/utils/text_element_factory.dart';
import 'package:brill_app/features/editor/widgets/abstract_text_node.dart';
import 'package:get/get.dart';

class NodeCreationController extends GetxController {
  TextCompositeNodeFactory elementFactory = TextCompositeNodeFactory();

  TextCompositeNode createNode(NoteElement element) {
    return elementFactory.accept(element);
  }
}
