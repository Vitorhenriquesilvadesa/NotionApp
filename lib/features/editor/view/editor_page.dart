import 'package:brill_app/core/metrics/sizes.dart';
import 'package:brill_app/core/styles/text_styles.dart';
import 'package:brill_app/core/theme/colors.dart';
import 'package:brill_app/features/editor/controller/editor_controller.dart';
import 'package:brill_app/features/editor/model/action_type.dart';
import 'package:brill_app/features/editor/plugins/block_type.dart';
import 'package:brill_app/features/editor/model/list_type.dart';
import 'package:brill_app/features/editor/plugins/plugin_registry.dart';
import 'package:brill_app/features/editor/utils/note_element_factory.dart';
import 'package:brill_app/features/editor/widgets/option_selector.dart';
import 'package:brill_app/features/editor/widgets/page_title.dart';
import 'package:brill_app/features/editor/widgets/abstract_text_node.dart';
import 'package:brill_app/features/editor/widgets/pomodoro.dart';
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
    controller.addListener(onValueChanged);
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
                            final element = controller.elements[index];

                            return Padding(
                              key: ValueKey(element),
                              padding: const EdgeInsets.only(bottom: 10),
                              child: TextElement(
                                index: index,
                                childBuilder: () {
                                  return CompositeNodeFactory.create(element);
                                },
                              ),
                            );
                          },
                          onReorder: (int oldIndex, int newIndex) {
                            setState(() {
                              final element = controller.elements.removeAt(
                                oldIndex,
                              );

                              if (newIndex > oldIndex) newIndex--;
                              controller.elements.insert(newIndex, element);
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
                              icon: Icons.notes,
                              label: "Mapa Mental",
                              value: BlockType.mentalMap,
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

  void onNodeInsert(BlockType type) {
    final plugin = NoteElementPluginRegistry().get(type);
    final element = plugin?.createElement();

    if (element != null) {
      controller.insertElement(controller.elementCount, element);
    }
  }

  void onValueChanged() {
    setState(() {});

    for (var element in controller.elements) {
      debugPrint(element.toString());
    }
  }
}
