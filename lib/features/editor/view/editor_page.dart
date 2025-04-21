import 'package:brill_app/core/metrics/sizes.dart';
import 'package:brill_app/core/styles/text_styles.dart';
import 'package:brill_app/core/theme/colors.dart';
import 'package:brill_app/features/editor/controller/editor_controller.dart';
import 'package:brill_app/features/editor/controller/node_creation_controller.dart';
import 'package:brill_app/features/editor/model/action_type.dart';
import 'package:brill_app/features/editor/model/block_type.dart';
import 'package:brill_app/features/editor/model/element_text_style.dart';
import 'package:brill_app/features/editor/model/list_type.dart';
import 'package:brill_app/features/editor/model/note_element.dart';
import 'package:brill_app/features/editor/model/text_alignment.dart';
import 'package:brill_app/features/editor/widgets/option_selector.dart';
import 'package:brill_app/features/editor/widgets/page_title.dart';
import 'package:brill_app/features/editor/widgets/abstract_text_node.dart';
import 'package:brill_app/features/editor/widgets/pomodoro.dart';
import 'package:brill_app/features/editor/widgets/text_node.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoteEditorPage extends StatefulWidget {
  const NoteEditorPage({super.key});

  @override
  State<NoteEditorPage> createState() => _NoteEditorPageState();
}

class _NoteEditorPageState extends State<NoteEditorPage> {
  EditorController controller = Get.find();
  NodeCreationController nodeCreationController = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        alignment: Alignment.topLeft,
        children: [
          Row(
            children: [
              SizedBox(
                width: AppSizes.leftMenuWidth,
                child: Container(color: AppColorsDark.menuBackground),
              ),
              Container(
                color: AppColorsDark.mainBackground,
                width: screenWidth - 300,
                height: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 140),
                      Container(
                        alignment: Alignment.center,
                        width: 800,
                        child: PageTitle(
                          onSubmitted: (value) {
                            setState(() {
                              controller.onPageTitleInsert(value);
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 50),
                      SizedBox(
                        width: 800,
                        child: ReorderableListView.builder(
                          shrinkWrap: true,
                          buildDefaultDragHandles: false,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.elementCount,
                          itemBuilder: (context, index) {
                            final element = controller.getByIndex(index);
                            final focusNode = element.focusNode;
                            focusNode.addListener(() {
                              if (focusNode.hasFocus) {
                                controller.index = index;
                              }
                            });
                            return Padding(
                              key: ValueKey(element),
                              padding: const EdgeInsets.only(bottom: 10),
                              child: TextElement(
                                index: index,
                                childKey: element.key,
                                childBuilder: () {
                                  return nodeCreationController.createNode(
                                    element,
                                  );
                                },
                              ),
                            );
                          },
                          onReorder: (int oldIndex, int newIndex) {
                            setState(() {
                              final element = controller.removeByIndex(
                                oldIndex,
                              );
                              element.key = GlobalKey();

                              int index = 0;
                              for (var element in controller.elements) {
                                element.index = index;
                                index++;
                              }

                              if (newIndex > oldIndex) newIndex--;
                              controller.insertElementAt(newIndex, element);
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: AppSizes.leftMenuWidth,
                child: Container(
                  color: AppColorsDark.menuBackground,
                  child: PomodoroTimer(duration: Duration(seconds: 60)),
                ),
              ),
              Column(
                children: [
                  SizedBox(height: 20),
                  Container(
                    height: 48,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    width: screenWidth - AppSizes.leftMenuWidth - 40,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(68, 68, 68, 1),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(100),
                          offset: Offset(0, 20),
                          blurRadius: 50,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 50),
                        OptionSelector<TextAlignment>(
                          icon: Icons.format_align_left,
                          tooltip: "Alinhamento do texto",
                          defaultValue: TextAlignment.left,
                          onSelect: (option) {},
                          options: [
                            Option(
                              icon: Icons.format_align_left,
                              label: "Alinhar à esquerda",
                              value: TextAlignment.left,
                            ),
                            Option(
                              icon: Icons.format_align_right,
                              label: "Alinhar à direita",
                              value: TextAlignment.right,
                            ),
                            Option(
                              icon: Icons.format_align_center,
                              label: "Centralizar",
                              value: TextAlignment.center,
                            ),
                            Option(
                              icon: Icons.format_align_justify,
                              label: "Justificar",
                              value: TextAlignment.justify,
                            ),
                          ],
                        ),
                        SizedBox(width: 20),

                        OptionSelector<ElementTextStyle>(
                          icon: Icons.text_fields,
                          tooltip: "Estilo do texto",
                          defaultValue: ElementTextStyle.normal,
                          onSelect: onTextStyleSelect,
                          options: [
                            Option(
                              icon: Icons.text_fields,
                              label: "Normal",
                              value: ElementTextStyle.normal,
                            ),
                            Option(
                              icon: Icons.title,
                              label: "Título 1",
                              value: ElementTextStyle.title1,
                            ),
                            Option(
                              icon: Icons.subtitles,
                              label: "Título 2",
                              value: ElementTextStyle.title2,
                            ),
                            Option(
                              icon: Icons.code,
                              label: "Código",
                              value: ElementTextStyle.code,
                            ),
                            Option(
                              icon: Icons.format_quote,
                              label: "Citação",
                              value: ElementTextStyle.citation,
                            ),
                            Option(
                              icon: Icons.terminal,
                              label: "Monoespaçado",
                              value: ElementTextStyle.monospace,
                            ),
                          ],
                        ),
                        SizedBox(width: 20),

                        OptionSelector<ListType>(
                          icon: Icons.format_list_bulleted,
                          tooltip: "Tipo da lista",
                          defaultValue: ListType.dots,
                          onSelect: (option) {},
                          options: [
                            Option(
                              icon: Icons.format_list_bulleted,
                              label: "Lista com Pontos",
                              value: ListType.dots,
                            ),
                            Option(
                              icon: Icons.format_list_numbered,
                              label: "Lista Numerada",
                              value: ListType.numbers,
                            ),
                            Option(
                              icon: Icons.check_box_outlined,
                              label: "Lista de Tarefas",
                              value: ListType.tasks,
                            ),
                          ],
                        ),
                        SizedBox(width: 20),

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
                        SizedBox(width: 20),

                        OptionSelector<BlockType>(
                          icon: Icons.notes,
                          tooltip: "Inserir bloco",
                          defaultValue: BlockType.paragraph,
                          onSelect: onNodeInsert,
                          options: [
                            Option(
                              icon: Icons.notes,
                              label: "Parágrafo",
                              value: BlockType.paragraph,
                            ),
                            Option(
                              icon: Icons.table_chart,
                              label: "Tabela",
                              value: BlockType.table,
                            ),
                            Option(
                              icon: Icons.horizontal_rule,
                              label: "Separador",
                              value: BlockType.separator,
                            ),
                            Option(
                              icon: Icons.code,
                              label: "Código",
                              value: BlockType.code,
                            ),
                          ],
                        ),
                        SizedBox(width: 20),

                        OptionSelector<ActionType>(
                          defaultValue: ActionType.duplicate,
                          tooltip: "Modificar bloco",
                          icon: Icons.more_vert,
                          onSelect: (option) {},
                          options: [
                            Option(
                              label: "Duplicar Bloco",
                              value: ActionType.duplicate,
                            ),
                            Option(
                              label: "Deletar Bloco",
                              value: ActionType.delete,
                            ),
                            Option(
                              label: "Adicionar Comentários",
                              value: ActionType.comment,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void onNodeInsert(BlockType option) {
    final GlobalKey<TextCompositeNodeState<TextCompositeNode>> key =
        GlobalKey();

    switch (option) {
      case BlockType.paragraph:
        setState(() {
          NoteElement element = ParagraphNoteElement(
            color: Colors.white,
            controller: TextEditingController(),
            focusNode: FocusNode(),
            key: key,
            index: controller.editingIndex,
            alignment: TextAlign.left,
            tag: ElementTag.h5,
          );
          controller.insertElementAt(controller.elementCount, element);
        });
        break;
      case BlockType.table:
        // TODO: Handle this case.
        throw UnimplementedError();
      case BlockType.separator:
        // TODO: Handle this case.
        throw UnimplementedError();
      case BlockType.code:
        setState(() {
          CodeNoteElement element = CodeNoteElement(
            controller: TextEditingController(),
            focusNode: FocusNode(),
            key: key,
            index: controller.editingIndex,
          );
          controller.insertElementAt(controller.elementCount, element);
        });
    }
  }

  void onColorSelect(Color color) {
    final element = controller.currentElement;

    if (element is ParagraphNoteElement) {
      final state = (element.key.currentState as ParagraphCompositeNodeState);
      state.onColorChange(color);
    }
  }

  void onTextStyleSelect(ElementTextStyle style) {
    final element = controller.currentElement;

    if (element is ParagraphNoteElement) {
      final state = (element.key.currentState as ParagraphCompositeNodeState);
      state.onStyleChange(style);
    }
  }
}
