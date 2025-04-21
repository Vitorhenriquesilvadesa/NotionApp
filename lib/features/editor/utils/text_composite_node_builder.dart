import 'package:brill_app/core/styles/text_styles.dart';
import 'package:brill_app/features/editor/model/note_element.dart';
import 'package:brill_app/features/editor/widgets/abstract_text_node.dart';
import 'package:brill_app/features/editor/widgets/code_node.dart';
import 'package:brill_app/features/editor/widgets/text_node.dart';
import 'package:flutter/material.dart';

class TextCompositeNodeBuilder {
  final Map<Type, AbstractNodeBuilder> _builders = {
    CodeNodeBuilder: CodeNodeBuilder(),
    ParagraphNodeBuilder: ParagraphNodeBuilder(),
  };

  T buildWith<T extends AbstractNodeBuilder>() {
    return _builders[T] as T;
  }
}

abstract class AbstractNodeBuilder<T extends TextCompositeNode> {
  T build();
}

class CodeNodeBuilder extends AbstractNodeBuilder<CodeCompositeNode> {
  CodeNoteElement configuration = CodeNoteElement(
    controller: TextEditingController(),
    focusNode: FocusNode(),
    key: GlobalKey(),
    index: 0,
    language: 'java',
  );

  CodeNodeBuilder withConfiguration(CodeNoteElement element) {
    configuration = element;
    return this;
  }

  @override
  CodeCompositeNode build() {
    return CodeCompositeNode(
      controller: configuration.controller,
      key: configuration.key,
      index: configuration.index,
      focusNode: configuration.focusNode,
    );
  }
}

class ParagraphNodeBuilder extends AbstractNodeBuilder<ParagraphCompositeNode> {
  ParagraphNoteElement configuration = ParagraphNoteElement(
    color: Colors.white,
    controller: TextEditingController(),
    focusNode: FocusNode(),
    key: GlobalKey(),
    index: 0,
  );

  ParagraphNodeBuilder withConfiguration(ParagraphNoteElement element) {
    configuration = element;
    return this;
  }

  @override
  ParagraphCompositeNode build() {
    return ParagraphCompositeNode(
      controller: configuration.controller,
      focusNode: configuration.focusNode,
      index: configuration.index,
      key: configuration.key,
      tag: ElementTag.h5,
      isDragging: false,
      onSubmitted: (p0) {},
    );
  }
}
