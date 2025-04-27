import 'package:brill_app/core/metrics/sizes.dart';
import 'package:brill_app/core/theme/colors.dart';
import 'package:brill_app/features/editor/controller/editor_controller.dart';
import 'package:brill_app/features/notes/note_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActivityBar extends StatelessWidget {
  ActivityBar({super.key});

  final EditorController editorController = Get.find();
  final NoteController noteController = Get.find();

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: AppSizes.leftMenuWidth,
      child: Container(
        padding: EdgeInsets.all(10),
        color: AppColorsDark.menuBackground,
        child: Column(
          children: [
            SizedBox(
              height: 30,
              child: Text(
                "My documents",
                style: TextStyle(fontSize: 18, fontFamily: "Montserrat"),
              ),
            ),
            Expanded(
              child: Obx(
                () => ReorderableListView.builder(
                  buildDefaultDragHandles: false,
                  itemCount: noteController.noteCount,
                  itemBuilder: (context, index) {
                    return DocumentThumbnailDragger(
                      index: index,
                      key: ValueKey(index),
                    );
                  },
                  onReorder: noteController.onReorder,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DocumentThumbnailDragger extends StatefulWidget {
  const DocumentThumbnailDragger({super.key, required this.index});

  final int index;

  @override
  State<DocumentThumbnailDragger> createState() =>
      _DocumentThumbnailDraggerState();
}

class _DocumentThumbnailDraggerState extends State<DocumentThumbnailDragger> {
  bool _hovering = false;

  final EditorController editorController = Get.find();
  final NoteController noteController = Get.find();

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
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onDoubleTap: () {
                  final note = noteController.getByIndex(widget.index);
                  editorController.openExistent(note);
                },
                child: Container(
                  height: 25,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 20),
                      Text(
                        noteController.getByIndex(widget.index).title,
                        style: TextStyle(fontFamily: "Montserrat"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
