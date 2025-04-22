import 'dart:math';

import 'package:brill_app/features/editor/plugins/mental_map/model/mental_map_note_element.dart';
import 'package:brill_app/features/editor/utils/keyboard_util.dart';
import 'package:brill_app/features/editor/plugins/shared/abstract_text_node.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class MentalMapCompositeNode extends TextCompositeNode<MentalMapNoteElement> {
  const MentalMapCompositeNode({
    super.key,
    required super.element,
    this.isDragging = false,
  });

  final bool isDragging;

  @override
  TextCompositeNodeState<TextCompositeNode> createState() =>
      MentalMapCompositeNodeState();
}

class DraggableNode extends StatefulWidget {
  final MentalMapNode node;
  final ValueChanged<Offset> onPositionChanged;

  const DraggableNode({
    super.key,
    required this.node,
    required this.onPositionChanged,
  });

  @override
  State<DraggableNode> createState() => _DraggableNodeState();
}

class _DraggableNodeState extends State<DraggableNode> {
  Offset offset = Offset.zero;

  @override
  void initState() {
    super.initState();
    offset = widget.node.position;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          offset += details.delta;
        });
        widget.onPositionChanged(offset);
      },
      child: Container(
        width: 120,
        height: 120,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 89, 89, 89),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

class MentalMapCompositeNodeState
    extends TextCompositeNodeState<MentalMapCompositeNode> {
  late MentalMapNoteElement element;

  @override
  void initState() {
    super.initState();
    element = widget.element;
  }

  void addNode() {
    final id = const Uuid().v4();
    setState(() {
      element.nodes.add(
        MentalMapNode(
          id: id,
          position: Offset(100 + Random().nextDouble() * 200, 100),
        ),
      );
    });
  }

  void updateNodePosition(String id, Offset newPosition) {
    setState(() {
      final node = element.nodes.firstWhere((n) => n.id == id);
      node.position = newPosition;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      child: Stack(
        children: [
          ...element.nodes.map(
            (node) => Positioned(
              left: node.position.dx,
              top: node.position.dy,
              child: DraggableNode(
                node: node,
                onPositionChanged: (pos) => updateNodePosition(node.id, pos),
              ),
            ),
          ),
          Positioned(
            right: 20,
            bottom: 20,
            child: FloatingActionButton(
              onPressed: addNode,
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Map<KeyCombination, VoidCallback> get keyHandlers => {};
}
