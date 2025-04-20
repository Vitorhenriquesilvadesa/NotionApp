import 'package:brill_app/core/metrics/sizes.dart';
import 'package:brill_app/core/styles/text_styles.dart';
import 'package:brill_app/core/theme/colors.dart';
import 'package:brill_app/features/editor/model/note_element.dart';
import 'package:brill_app/features/editor/widgets/page_title.dart';
import 'package:brill_app/features/editor/widgets/text_node.dart';
import 'package:flutter/material.dart';

class NoteEditorPage extends StatefulWidget {
  const NoteEditorPage({super.key});

  @override
  State<NoteEditorPage> createState() => _NoteEditorPageState();
}

class _NoteEditorPageState extends State<NoteEditorPage> {
  late FocusNode pageTitleFocus;
  List<NoteElement> elements = [];
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    pageTitleFocus = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
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
                      Container(
                        height: 48,
                        width: double.infinity,
                        child: Row(children: []),
                        decoration: BoxDecoration(
                          color: AppColorsDark.mainBackground,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(100),
                              offset: Offset(0, 20),
                              blurRadius: 50,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 50),
                      Container(
                        alignment: Alignment.center,
                        width: 800,
                        child: PageTitle(onSubmitted: onPageTitleInsert),
                      ),
                      SizedBox(height: 50),
                      SizedBox(
                        width: 800,
                        child: ReorderableListView.builder(
                          buildDefaultDragHandles: false,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: elements.length,
                          onReorder: (oldIndex, newIndex) {
                            setState(() {
                              if (newIndex > oldIndex) newIndex--;
                              final item = elements.removeAt(oldIndex);
                              elements.insert(newIndex, item);
                            });
                          },
                          onReorderStart: (_) {
                            setState(() {
                              _isDragging = true;
                            });
                          },
                          onReorderEnd: (_) {
                            setState(() {
                              _isDragging = false;
                            });
                          },
                          itemBuilder: (context, index) {
                            final element = elements[index];
                            return Padding(
                              key: ValueKey(element),
                              padding: const EdgeInsets.only(bottom: 10),
                              child: TextNode(
                                index: index,
                                elementType: element.type,
                                focusNode: element.focusNode,
                                controller: element.controller,
                                onAddAbove: () {
                                  insertElementAt(index);
                                },

                                onAddBelow: () {
                                  insertElementAt(index + 1);
                                },

                                onRemove: () {
                                  if (elements.length > 1) {
                                    removeElementAt(index);
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
          SizedBox(
            width: AppSizes.leftMenuWidth,
            child: Container(color: AppColorsDark.menuBackground),
          ),
        ],
      ),
    );
  }

  void insertElementAt(int index) {
    setState(() {
      FocusNode focusNode = FocusNode();
      var controller = TextEditingController();
      var element = NoteElement(
        type: ElementType.normal,
        focusNode: focusNode,
        controller: controller,
      );
      elements.insert(index, element);
      focusNode.requestFocus();
    });
  }

  void removeElementAt(int index) {
    setState(() {
      elements.removeAt(index);
      if (index > 0) {
        elements[index - 1].focusNode.requestFocus();
      } else {
        elements[0].focusNode.requestFocus();
      }
    });
  }

  void onPageTitleInsert(String title) {
    if (elements.isEmpty) {
      setState(() {
        FocusNode focusNode = FocusNode();
        var controller = TextEditingController();
        var element = NoteElement(
          type: ElementType.normal,
          focusNode: focusNode,
          controller: controller,
        );
        elements.add(element);
        focusNode.requestFocus();
      });
    }
  }
}
