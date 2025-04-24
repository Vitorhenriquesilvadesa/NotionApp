import 'dart:math';
import 'package:brill_app/features/editor/utils/keyboard_util.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'package:brill_app/features/editor/plugins/mental_map/model/mental_map_note_element.dart';
import 'package:brill_app/features/editor/plugins/shared/abstract_text_node.dart';

const double gridSize = 20.0;

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
  final VoidCallback? onDragStart;
  final VoidCallback? onDragEnd;

  const DraggableNode({
    super.key,
    required this.node,
    required this.onPositionChanged,
    this.onDragStart,
    this.onDragEnd,
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
      onPanStart: (_) => widget.onDragStart?.call(),
      onPanEnd: (_) => widget.onDragEnd?.call(),
      onPanUpdate: (details) {
        setState(() {
          offset += details.delta;
        });
        widget.onPositionChanged(offset);
      },
      child: Column(
        children: [
          Container(
            width: 200,
            padding: EdgeInsets.all(5),
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 89, 89, 89),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Icon(Icons.drag_indicator),
          ),
          Container(
            width: 200,
            height: 120,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 89, 89, 89),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(50),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                maxLines: null,
                decoration: InputDecoration.collapsed(hintText: 'anotação'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MentalMapCompositeNodeState
    extends TextCompositeNodeState<MentalMapCompositeNode> {
  late MentalMapNoteElement element;
  bool isDragging = false;

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

  Offset snapToGrid(Offset pos, double gridSize) {
    double snap(double value) => (value / gridSize).round() * gridSize;
    return Offset(snap(pos.dx), snap(pos.dy));
  }

  @override
  Widget build(BuildContext context) {
    const double minHeight = 300;
    const double gridSize = 20;

    final double maxNodeBottom = element.nodes
        .map((node) => node.position.dy + 150)
        .fold(minHeight, max);

    return Container(
      width: double.infinity,
      height: max(maxNodeBottom + 20, minHeight),
      child: Stack(
        children: [
          SnapGrid(gridSize: gridSize, isActive: isDragging),
          ...element.nodes.map(
            (node) => Positioned(
              left: node.position.dx,
              top: node.position.dy,
              child: DraggableNode(
                node: node,
                onDragStart: () {
                  setState(() => isDragging = true);
                },
                onDragEnd: () {
                  setState(() => isDragging = false);
                },
                onPositionChanged: (pos) {
                  final snapped = snapToGrid(pos, gridSize);
                  updateNodePosition(node.id, snapped);
                },
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

class SnapGrid extends StatelessWidget {
  final double gridSize;
  final bool isActive;

  const SnapGrid({super.key, required this.gridSize, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isActive ? 1.0 : 0.0,
      duration: Duration(milliseconds: 500),
      curve: Curves.decelerate,
      child: CustomPaint(
        size: Size.infinite,
        painter: _SnapGridPainter(gridSize: gridSize, isActive: isActive),
      ),
    );
  }
}

class _SnapGridPainter extends CustomPainter {
  final double gridSize;
  final bool isActive;

  _SnapGridPainter({required this.gridSize, required this.isActive});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.white.withAlpha(40)
          ..style = PaintingStyle.fill;

    for (double x = 0; x < size.width; x += gridSize) {
      for (double y = 0; y < size.height; y += gridSize) {
        canvas.drawCircle(Offset(x, y), 1.5, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _SnapGridPainter oldDelegate) {
    return oldDelegate.gridSize != gridSize || oldDelegate.isActive != isActive;
  }
}

class GridBackground extends StatelessWidget {
  const GridBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _GridPainter(), size: Size.infinite);
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.grey.withOpacity(0.3)
          ..style = PaintingStyle.fill;

    for (double x = 0; x < size.width; x += gridSize) {
      for (double y = 0; y < size.height; y += gridSize) {
        canvas.drawCircle(Offset(x, y), 1.5, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
