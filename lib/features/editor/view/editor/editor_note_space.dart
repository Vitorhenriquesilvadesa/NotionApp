import 'package:brill_app/core/metrics/sizes.dart';
import 'package:brill_app/core/theme/colors.dart';
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

class EditorNoteSpace extends StatelessWidget {
  EditorNoteSpace({super.key});

  final EditorController controller = Get.find();

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
                      onSubmitted: (value) {
                        controller.onPageTitleInsert(value);
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
                        itemCount: controller.elementCount,
                        itemBuilder: (context, index) {
                          final element = controller.elements[index];
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
                        onReorder: controller.reorderElement,
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
    );
  }

  void onNodeInsert(BlockType type) {
    final plugin = NoteElementPluginRegistry().get(type);
    final element = plugin?.createElement();

    if (element != null) {
      controller.insertElement(controller.elementCount, element);
    }
  }
}
