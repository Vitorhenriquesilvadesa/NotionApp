import 'package:brill_app/features/editor/plugins/block_type.dart';
import 'block_plugin.dart';

class NoteElementPluginRegistry {
  static final NoteElementPluginRegistry _instance =
      NoteElementPluginRegistry._internal();
  final Map<BlockType, NoteElementPlugin> _plugins = {};

  factory NoteElementPluginRegistry() => _instance;

  NoteElementPluginRegistry._internal();

  void register(NoteElementPlugin plugin) {
    _plugins[plugin.type] = plugin;
  }

  NoteElementPlugin? get(BlockType type) => _plugins[type];

  List<NoteElementPlugin> get all => _plugins.values.toList();
}
