import 'package:brill_app/core/metrics/sizes.dart';
import 'package:brill_app/core/styles/text_styles.dart';
import 'package:brill_app/core/theme/colors.dart';
import 'package:brill_app/features/editor/controller/editor_controller.dart';
import 'package:brill_app/features/editor/controller/note_editing_controller.dart';
import 'package:brill_app/features/editor/model/action_type.dart';
import 'package:brill_app/features/editor/model/block_type.dart';
import 'package:brill_app/features/editor/model/color_type.dart';
import 'package:brill_app/features/editor/model/element_text_style.dart';
import 'package:brill_app/features/editor/model/list_type.dart';
import 'package:brill_app/features/editor/model/note_element.dart';
import 'package:brill_app/features/editor/model/text_alignment.dart';
import 'package:brill_app/features/editor/widgets/option_selector.dart';
import 'package:brill_app/features/editor/widgets/page_title.dart';
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
                          onSubmitted: (p0) {
                            setState(() {
                              controller.onPageTitleInsert(p0);
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 50),
                      SizedBox(
                        width: 800,
                        child: ReorderableListView.builder(
                          buildDefaultDragHandles: false,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.elementCount,
                          onReorder: (oldIndex, newIndex) {
                            setState(() {
                              if (newIndex > oldIndex) newIndex--;
                              final item = controller.removeByIndex(oldIndex);
                              controller.insert(newIndex, item);
                            });
                          },
                          onReorderStart: (_) {},
                          onReorderEnd: (_) {},
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
                              child: TextNode(
                                index: index,
                                elementType: element.type,
                                focusNode: focusNode,
                                controller: element.controller,
                                onAddAbove: () {
                                  setState(() {
                                    controller.insertElementAt(index);
                                  });
                                },

                                onAddBelow: () {
                                  setState(() {
                                    controller.insertElementAt(index + 1);
                                  });
                                },

                                onRemove: () {
                                  if (controller.elementCount > 1) {
                                    setState(() {
                                      controller.removeElementAt(index);
                                    });
                                  }
                                },

                                onDownPress: () {
                                  if (controller.elementCount > 1) {
                                    setState(() {
                                      controller.swapTo(index + 1);
                                    });
                                  }
                                },

                                onUpPress: () {
                                  if (controller.elementCount > 1) {
                                    setState(() {
                                      controller.swapTo(index - 1);
                                    });
                                  }
                                },

                                key: ValueKey(element),
                              ),
                            );
                          },
                        ),
                      ),
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
                child: Container(color: AppColorsDark.menuBackground),
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
                          defaultValue: TextAlignment.left,
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

                        OptionSelector<ElementTextStyle>(
                          icon: Icons.text_fields,
                          defaultValue: ElementTextStyle.normal,
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

                        OptionSelector<ListType>(
                          icon: Icons.format_list_bulleted,
                          defaultValue: ListType.dots,
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

                        OptionSelector<ColorType>(
                          icon: Icons.color_lens_outlined,
                          defaultValue: ColorType.foreground,
                          options: [
                            Option(
                              icon: Icons.format_color_text,
                              label: "Cor do Texto",
                              value: ColorType.foreground,
                            ),
                            Option(
                              icon: Icons.format_color_fill,
                              label: "Cor do Fundo",
                              value: ColorType.background,
                            ),
                          ],
                        ),

                        OptionSelector<BlockType>(
                          icon: Icons.notes,
                          defaultValue: BlockType.paragraph,
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

                        OptionSelector<ActionType>(
                          defaultValue: ActionType.duplicate,
                          icon: Icons.more_vert,
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
}
