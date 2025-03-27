import 'package:brill_app/editor/element_menu.dart';
import 'package:brill_app/editor/katex_editor.dart';
import 'package:brill_app/settings/colors.dart';
import 'package:flutter/material.dart';

class ArticleEditor extends StatefulWidget {
  const ArticleEditor({super.key});

  @override
  _ArticleEditorState createState() => _ArticleEditorState();
}

class _ArticleEditorState extends State<ArticleEditor> {
  List<Widget> blocks = [];

  void _addTextBlock() {
    setState(() {
      blocks.add(
        ListTile(
          key: UniqueKey(),
          title: TextField(
            decoration: const InputDecoration(border: OutlineInputBorder()),
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          trailing: const Icon(Icons.drag_handle),
        ),
      );
    });
  }

  void _addImageBlock() {
    setState(() {
      blocks.add(
        ListTile(
          key: UniqueKey(),
          title: Container(
            height: 100,
            color: Colors.grey[300],
            child: const Center(child: Text("Imagem Aqui")),
          ),
          trailing: const Icon(Icons.drag_handle),
        ),
      );
    });
  }

  void _addKatexBlock() {
    setState(() {
      blocks.add(
        ListTile(
          key: UniqueKey(),
          title: KatexEditor(),
          trailing: const Icon(Icons.drag_handle),
        ),
      );
    });
  }

  void _showAddOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: editorBottomSheet,
      enableDrag: true,
      builder: (context) {
        return Column(
          children: [
            ElementMenu(
              icon: const Icon(Icons.text_fields),
              title: "Adicionar Texto",
              onTap: () {
                Navigator.pop(context);
                _addTextBlock();
              },
            ),
            ElementMenu(
              icon: const Icon(Icons.image),
              title: "Adicionar Imagem",
              onTap: () {
                Navigator.pop(context);
                _addImageBlock();
              },
            ),
            ElementMenu(
              icon: const Icon(Icons.image),
              title: "Adicionar Equação",
              onTap: () {
                Navigator.pop(context);
                _addKatexBlock();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ReorderableListView(
            onReorder: (oldIndex, newIndex) {
              if (newIndex > oldIndex) newIndex--;
              setState(() {
                final item = blocks.removeAt(oldIndex);
                blocks.insert(newIndex, item);
              });
            },
            children: blocks.map((widget) => widget).toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: _showAddOptions,
            child: const Text("Adicionar Bloco"),
          ),
        ),
      ],
    );
  }
}
