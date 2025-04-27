import 'dart:math';
import 'dart:ui';

import 'package:brill_app/core/metrics/sizes.dart';
import 'package:brill_app/core/styles/text_styles.dart';
import 'package:brill_app/core/theme/colors.dart';
import 'package:brill_app/core/network/session_manager.dart';
import 'package:brill_app/features/editor/controller/editor_controller.dart';
import 'package:brill_app/features/editor/model/action_type.dart';
import 'package:brill_app/features/editor/plugins/list/model/list_type.dart';
import 'package:brill_app/features/editor/plugins/shared/abstract_text_node.dart';
import 'package:brill_app/features/editor/plugins/shared/block_type.dart';
import 'package:brill_app/features/editor/plugins/shared/plugin_registry.dart';
import 'package:brill_app/features/editor/utils/note_element_factory.dart';
import 'package:brill_app/features/editor/view/editor/page_title.dart';
import 'package:brill_app/features/editor/widgets/option_selector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditorNoteSpace extends StatefulWidget {
  EditorNoteSpace({super.key});

  @override
  State<EditorNoteSpace> createState() => _EditorNoteSpaceState();
}

class _EditorNoteSpaceState extends State<EditorNoteSpace> {
  final EditorController editorController = Get.find();

  @override
  void initState() {
    super.initState();
    editorController.addListener(onNoteOpen);
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Container(
      alignment: Alignment.topCenter,
      color: AppColorsDark.mainBackground,
      width: screenWidth - 300,
      height: double.infinity,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          SizedBox.expand(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: 140),
                  Container(
                    alignment: Alignment.center,
                    width: 800,
                    child: PageTitle(
                      onChange: (value) {
                        editorController.pageTitle = value;
                      },
                      controller: editorController.titleController,
                      onSubmitted: (value) {
                        editorController.onPageTitleInsert(value);
                      },
                    ),
                  ),
                  SizedBox(height: 50),
                  SizedBox(
                    width: 800,
                    child: Obx(
                      () => ReorderableListView.builder(
                        shrinkWrap: true,
                        buildDefaultDragHandles: false,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: editorController.elementCount,
                        itemBuilder: (context, index) {
                          final element = editorController.elements[index];
                          return Padding(
                            key: ValueKey(element),
                            padding: const EdgeInsets.only(bottom: 10),
                            child: TextElement(
                              index: index,
                              childBuilder:
                                  () => CompositeNodeFactory.create(element),
                            ),
                          );
                        },
                        onReorder: editorController.reorderElement,
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
          ),
          Column(
            children: [
              ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    height: 48,
                    width: screenWidth - AppSizes.leftMenuWidth,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 2),
                        Row(
                          children: [
                            OptionSelector<BlockType>(
                              icon: Row(
                                children: [
                                  Text("Inserir", style: AppTextStyles.h6),
                                  SizedBox(width: 20),
                                  Icon(Icons.notes),
                                ],
                              ),

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
                                  icon: Icons.list,
                                  label: "Lista",
                                  value: BlockType.list,
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
                          ],
                        ),
                        SizedBox(width: 20),
                        OptionSelector<ActionType>(
                          defaultValue: ActionType.duplicate,
                          tooltip: "Modificar bloco",
                          icon: Icon(Icons.more_vert),
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
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void onNoteOpen() {
    setState(() {});
  }

  void onNodeInsert(BlockType type) {
    final plugin = NoteElementPluginRegistry().get(type);

    // TODO: Colocar ID da nota ativa aqui
    final activeNoteId = 0;

    final element = plugin?.createElement(
      activeNoteId,
      String.fromCharCode(Random.secure().nextInt(255)),
    );

    if (element != null) {
      editorController.insertElement(editorController.elementCount, element);
    }
  }
}
