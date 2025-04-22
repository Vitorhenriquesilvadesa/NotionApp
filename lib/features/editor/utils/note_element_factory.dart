import 'package:brill_app/features/editor/model/note_element.dart';
import 'package:brill_app/features/editor/plugins/shared/plugin_registry.dart';
import 'package:brill_app/features/editor/plugins/shared/abstract_text_node.dart';

class CompositeNodeFactory {
  static TextCompositeNode create(NoteElement element) {
    final plugin = NoteElementPluginRegistry().get(element.type);

    if (plugin != null) {
      return plugin.createWidget(element);
    } else {
      throw Exception("Plugin ${element.type} not registered.");
    }
  }
}
