import 'package:brill_app/features/editor/plugins/list/controller/list_controller.dart';
import 'package:brill_app/features/editor/plugins/list/model/list_note_element.dart';
import 'package:brill_app/features/editor/plugins/list/model/list_type.dart';
import 'package:brill_app/features/editor/plugins/shared/abstract_text_node.dart';
import 'package:brill_app/features/editor/utils/keyboard_util.dart';
import 'package:brill_app/features/editor/widgets/option_selector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListCompositeNode extends TextCompositeNode<ListNoteElement> {
  const ListCompositeNode({super.key, required super.element});

  @override
  TextCompositeNodeState<ListCompositeNode> createState() =>
      ListCompositeNodeState();
}

class ListCompositeNodeState extends TextCompositeNodeState<ListCompositeNode> {
  final ListController listController = ListController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Container(
            color: Colors.white.withAlpha(50),
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                OptionSelector<ListType>(
                  icon: Icons.format_list_bulleted,
                  tooltip: "Tipo da lista",
                  defaultValue: ListType.dots,
                  onSelect: onListTypeChange,
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
                Spacer(),
                IconButton(
                  onPressed: () {
                    listController.elements.insert(
                      listController.elementCount,
                      BulletedListItem(label: ""),
                    );
                  },
                  icon: Icon(Icons.add),
                ),
              ],
            ),
          ),
          Container(
            height: 300,
            padding: EdgeInsets.all(10),
            child: Obx(() {
              return ReorderableListView.builder(
                buildDefaultDragHandles: false,
                itemBuilder: (context, index) {
                  return ListElementCompositeNode(
                    key: ValueKey(listController.elements[index]),
                    element: listController.elements[index],
                    index: index,
                  );
                },
                itemCount: listController.elementCount,
                onReorder: listController.reorderElement,
              );
            }),
          ),
        ],
      ),
    );
  }

  @override
  Map<KeyCombination, VoidCallback> get keyHandlers => {};

  void onListTypeChange(ListType type) {
    listController.setListType(type);
  }
}

class ListElementCompositeNode extends StatefulWidget {
  const ListElementCompositeNode({
    super.key,
    required this.element,
    required this.index,
  });

  final ListItem element;
  final int index;

  @override
  State<ListElementCompositeNode> createState() =>
      _ListElementCompositeNodeState();
}

class _ListElementCompositeNodeState extends State<ListElementCompositeNode> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: _hovering ? Colors.white.withAlpha(30) : Colors.transparent,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: buildElement(widget.element)),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 150),
              opacity: _hovering ? 1.0 : 0.25,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: ReorderableDragStartListener(
                  index: widget.index,
                  child: const Icon(
                    Icons.drag_indicator_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildElement(ListItem item) {
    final TextEditingController controller = TextEditingController(
      text: item.label,
    );

    switch (item.type) {
      case ListType.dots:
        return SizedBox(
          height: 30,
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                width: 30,
                child: Icon(Icons.circle, size: 10),
              ),
              Expanded(
                child: TextField(
                  onChanged: (value) {
                    item.label = value;
                  },
                  controller: controller,
                  decoration: InputDecoration.collapsed(hintText: 'item'),
                ),
              ),
            ],
          ),
        );
      case ListType.numbers:
        return SizedBox(
          height: 30,
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                width: 30,
                child: Text(
                  ((item as EnumeratedListItem).index + 1).toString(),
                ),
              ),
              Expanded(
                child: TextField(
                  onChanged: (value) {
                    item.label = value;
                  },
                  controller: controller,
                  decoration: InputDecoration.collapsed(hintText: 'item'),
                ),
              ),
            ],
          ),
        );
      case ListType.tasks:
        final todoItem = item as TodoListItem;
        return SizedBox(
          height: 30,
          child: Row(
            children: [
              SizedBox(
                width: 30,
                child: Checkbox(
                  value: todoItem.done,
                  onChanged: (value) {
                    setState(() {
                      todoItem.done = value ?? false;
                    });
                  },
                ),
              ),
              Expanded(
                child: TextField(
                  onChanged: (value) {
                    item.label = value;
                  },
                  controller: controller,
                  decoration: InputDecoration.collapsed(hintText: 'item'),
                ),
              ),
            ],
          ),
        );
    }
  }
}
