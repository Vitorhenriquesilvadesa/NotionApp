import 'package:flutter/services.dart';

typedef KeyCallback = void Function();
typedef RichKeyHandlerMap = Map<KeyCombination, KeyCallback>;

enum AppModifierKey {
  shiftModifier,
  controlModifier,
  altModifier,
  metaModifier,
}

class KeyCombination {
  final LogicalKeyboardKey key;
  final Set<AppModifierKey> modifiers;

  const KeyCombination(this.key, [this.modifiers = const {}]);

  @override
  bool operator ==(Object other) =>
      other is KeyCombination &&
      other.key == key &&
      other.modifiers.length == modifiers.length &&
      modifiers.containsAll(other.modifiers);

  @override
  int get hashCode =>
      key.hashCode ^ modifiers.fold(0, (a, b) => a.hashCode ^ b.hashCode);
}
