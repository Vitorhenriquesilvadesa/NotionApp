import 'package:brill_app/article/katex.dart';
import 'package:flutter/material.dart';

class KatexEditor extends StatefulWidget {
  const KatexEditor({super.key});

  @override
  State<KatexEditor> createState() => _KatexEditorState();
}

class _KatexEditorState extends State<KatexEditor> {
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();

  String equation = "";

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Container(
        child: Column(
          children: [
            TextField(
              controller: controller,
              focusNode: focusNode,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              style: const TextStyle(color: Colors.white, fontSize: 18),
              onChanged: (value) {
                setState(() {
                  equation = value;
                });

                Future.delayed(Duration.zero, () {
                  if (!focusNode.hasFocus) {
                    focusNode.requestFocus();
                  }
                });
              },
            ),
            SizedBox(height: 20),
            KatexEquation(value: equation),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }
}
