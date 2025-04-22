import 'package:brill_app/core/styles/text_styles.dart';
import 'package:brill_app/features/editor/controller/paragraph_controller.dart';
import 'package:brill_app/features/editor/model/paragraph_note_element.dart';
import 'package:brill_app/features/editor/utils/keyboard_util.dart';
import 'package:brill_app/features/editor/widgets/abstract_text_node.dart';
import 'package:brill_app/features/editor/widgets/option_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ParagraphCompositeNode extends TextCompositeNode<ParagraphNoteElement> {
  const ParagraphCompositeNode({
    super.key,
    required super.element,
    this.isDragging = false,
  });

  final bool isDragging;

  @override
  TextCompositeNodeState<TextCompositeNode> createState() =>
      ParagraphCompositeNodeState();
}

class ParagraphCompositeNodeState
    extends TextCompositeNodeState<ParagraphCompositeNode> {
  late final TextEditingController textController;
  late final FocusNode focusNode;
  late final ParagraphController paragraphController;

  Color color = Colors.white;
  TextStyle style = AppTextStyles.normal;
  TextAlign align = TextAlign.left;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    focusNode = FocusNode();
    paragraphController = ParagraphController(
      textEditingController: textController,
      align: align,
      color: color,
    );

    paragraphController.addListener(onValueChange);
  }

  @override
  void dispose() {
    textController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Map<KeyCombination, VoidCallback> get keyHandlers => {};

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildToolbar(),
        TextField(
          controller: textController,
          focusNode: focusNode,
          maxLines: null,
          textAlignVertical: TextAlignVertical.top,
          style: paragraphController.getTextStyle(),
          textAlign: paragraphController.align,
          decoration: const InputDecoration.collapsed(hintText: ''),
          cursorColor: Theme.of(context).colorScheme.primary,
        ),
      ],
    );
  }

  Widget _buildToolbar() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(10),
      color: Colors.white.withAlpha(50),
      width: double.infinity,
      child: Row(
        children: [
          OptionSelector<ElementTag>(
            icon: Icons.text_fields,
            tooltip: "Estilo do texto",
            defaultValue: ElementTag.normal,
            onSelect: onTagSelect,
            options: [
              Option(
                icon: Icons.text_fields,
                label: "Normal",
                value: ElementTag.normal,
              ),
              Option(
                icon: Icons.title,
                label: "Título 1",
                value: ElementTag.h2,
              ),
              Option(
                icon: Icons.subtitles,
                label: "Título 2",
                value: ElementTag.h3,
              ),
              Option(
                icon: Icons.code,
                label: "Código",
                value: ElementTag.monospace,
              ),
              Option(
                icon: Icons.format_quote,
                label: "Citação",
                value: ElementTag.citation,
              ),
              Option(
                icon: Icons.terminal,
                label: "Monoespaçado",
                value: ElementTag.monospace,
              ),
            ],
          ),
          const SizedBox(width: 20),
          OptionSelector<Color>(
            icon: Icons.format_color_text,
            tooltip: "Cor do texto",
            defaultValue: Colors.white,
            onSelect: onColorSelect,
            options: [
              Option(label: "Branco", value: Colors.white),
              Option(label: "Preto", value: Colors.black),
              Option(label: "Vermelho", value: Colors.red),
              Option(label: "Verde", value: Colors.green),
              Option(label: "Azul", value: Colors.blue),
              Option(label: "Amarelo", value: Colors.yellow),
              Option(label: "Laranja", value: Colors.orange),
              Option(label: "Rosa", value: Colors.pink),
              Option(label: "Roxo", value: Colors.purple),
              Option(label: "Cinza", value: Colors.grey),
            ],
          ),
          const SizedBox(width: 20),
          OptionSelector<TextAlign>(
            icon: Icons.format_align_left,
            tooltip: "Alinhamento do texto",
            defaultValue: TextAlign.left,
            onSelect: onTextAlign,
            options: [
              Option(
                icon: Icons.format_align_left,
                label: "Esquerda",
                value: TextAlign.left,
              ),
              Option(
                icon: Icons.format_align_center,
                label: "Centro",
                value: TextAlign.center,
              ),
              Option(
                icon: Icons.format_align_right,
                label: "Direita",
                value: TextAlign.right,
              ),
              Option(
                icon: Icons.format_align_justify,
                label: "Justificar",
                value: TextAlign.justify,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void onTagSelect(ElementTag tag) {
    paragraphController.setTag(tag);
  }

  void onColorSelect(Color color) {
    paragraphController.setColor(color);
  }

  void onTextAlign(TextAlign align) {
    paragraphController.setAlignment(align);
  }

  void onValueChange() {
    widget.element.alignment = paragraphController.align;
    widget.element.color = paragraphController.color;
    widget.element.tag = paragraphController.tag;
    widget.element.text = paragraphController.text;

    setState(() {});
  }
}
