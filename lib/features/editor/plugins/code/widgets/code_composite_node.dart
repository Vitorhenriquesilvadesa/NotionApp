import 'package:brill_app/core/styles/text_styles.dart';
import 'package:brill_app/features/editor/plugins/code/controller/code_controller.dart';
import 'package:brill_app/features/editor/plugins/code/model/code_note_element.dart';
import 'package:brill_app/features/editor/utils/code_lexer.dart';
import 'package:brill_app/features/editor/utils/keyboard_util.dart';
import 'package:brill_app/features/editor/utils/languages.dart';
import 'package:brill_app/features/editor/plugins/shared/abstract_text_node.dart';
import 'package:brill_app/features/editor/widgets/option_selector.dart';
import 'package:flutter/material.dart';

enum CodeMode { editing, highlighting }

class CodeCompositeNode extends TextCompositeNode<CodeNoteElement> {
  const CodeCompositeNode({super.key, required super.element});

  @override
  TextCompositeNodeState<TextCompositeNode> createState() =>
      CodeCompositeNodeState();
}

class CodeCompositeNodeState extends TextCompositeNodeState<CodeCompositeNode> {
  late final CodeController codeController;
  late final TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    textEditingController.text = widget.element.source;

    codeController = CodeController(
      textEditingController: textEditingController,
      language: widget.element.language,
    );

    codeController.addListener(onValueChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          alignment: Alignment.centerLeft,
          // padding: EdgeInsets.all(10),
          color: Colors.white.withAlpha(50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  OptionSelector<String>(
                    maxMenuHeight: 300,
                    options: [
                      for (var l in languages) Option(label: l, value: l),
                    ],
                    defaultValue: widget.element.language,
                    icon: Icons.code_sharp,
                    onSelect: onLanguageSelect,
                  ),
                  Text(codeController.language, style: AppTextStyles.codeField),
                ],
              ),
              OptionSelector<CodeMode>(
                options: [
                  Option(
                    label: "Editar Código",
                    value: CodeMode.editing,
                    icon: Icons.edit_document,
                  ),
                  Option(
                    label: "Visualizar Sintaxe",
                    value: CodeMode.highlighting,
                    icon: Icons.highlight,
                  ),
                ],
                defaultValue: CodeMode.editing,
                icon: Icons.edit_document,
                onSelect: onModeSelect,
              ),
            ],
          ),
        ),
        Container(
          color: Colors.black,
          width: double.infinity,
          padding: EdgeInsets.all(10),
          child:
              codeController.mode == CodeMode.editing
                  ? TextField(
                    textAlignVertical: TextAlignVertical.top,
                    maxLines: null,
                    onChanged: (value) {
                      widget.element.source = value;
                    },
                    controller: codeController.textEditingController,
                    style: AppTextStyles.codeField,
                    textAlign: TextAlign.justify,
                    decoration: const InputDecoration.collapsed(hintText: ''),
                    cursorColor: Theme.of(context).colorScheme.primary,
                  )
                  : buildHighlight(),
        ),
      ],
    );
  }

  void onModeSelect(CodeMode mode) {
    codeController.setMode(mode);
  }

  Widget buildHighlight() {
    PythonScanner scanner = PythonScanner("${textEditingController.text}\n");
    final tokens = scanner.scanTokens();

    List<Widget> lines = [];
    List<Widget> line = [];

    int currentLine = 1;
    int index = 0;

    for (var token in tokens) {
      if (token.type != TokenType.newLine) {
        if (token.type == TokenType.space || token.type == TokenType.eof) {
          line.add(Text(" ", style: CodeHighlightStyles.eof));
        } else {
          if (token.type == TokenType.identifier) {
            if (tokens[index + 1].lexeme == "(") {
              line.add(
                Text(
                  token.lexeme,
                  style:
                      _isLowercase(token.lexeme[0])
                          ? CodeHighlightStyles.identifier
                          : CodeHighlightStyles.type,
                ),
              );
            } else {
              line.add(
                Text(
                  token.lexeme,
                  style:
                      _isLowercase(token.lexeme[0])
                          ? CodeHighlightStyles.variable
                          : CodeHighlightStyles.type,
                ),
              );
            }
          } else {
            line.add(
              Text(
                token.lexeme,
                style: CodeHighlightStyles.tokenStyles[token.type],
              ),
            );
          }
        }
      } else {
        line.insert(0, SizedBox(width: 20));
        line.insert(
          0,
          SizedBox(
            width: 40,
            child: Text(currentLine.toString(), style: CodeHighlightStyles.eof),
          ),
        );

        currentLine++;
        lines.add(Row(children: line));
        line = [];
      }
      index++;
    }

    if (line.isNotEmpty) {
      lines.add(Row(children: line));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: lines,
      ),
    );
  }

  bool _isLowercase(String c) =>
      (c.compareTo('a') >= 0 && c.compareTo('z') <= 0) || c == '_';

  @override
  Map<KeyCombination, VoidCallback> get keyHandlers => {};

  void onLanguageSelect(String language) {
    codeController.setLanguage(language);
  }

  void onValueChanged() {
    setState(() {});
  }
}
