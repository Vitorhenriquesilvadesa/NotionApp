import 'package:brill_app/core/styles/text_styles.dart';
import 'package:flutter/material.dart';

class Option<T> {
  final String label;
  final T value;
  final IconData? icon;

  Option({required this.label, required this.value, this.icon});
}

class OptionSelector<T> extends StatefulWidget {
  final List<Option<T>> options;
  final T defaultValue;
  final Widget? icon;
  final String? tooltip;
  final void Function(T option) onSelect;
  final double? maxMenuHeight;

  const OptionSelector({
    super.key,
    required this.options,
    required this.defaultValue,
    this.icon,
    this.tooltip,
    this.maxMenuHeight,
    required this.onSelect,
  });

  @override
  State<OptionSelector<T>> createState() => _OptionSelectorState<T>();
}

class _OptionSelectorState<T> extends State<OptionSelector<T>> {
  late T _selectedOption;

  @override
  void initState() {
    super.initState();
    _selectedOption = widget.defaultValue;
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<T>(
      offset: const Offset(0, 60),
      constraints:
          widget.maxMenuHeight != null
              ? BoxConstraints(maxHeight: widget.maxMenuHeight!)
              : null,
      popUpAnimationStyle: AnimationStyle(
        curve: Curves.decelerate,
        duration: Durations.medium1,
        reverseCurve: Curves.decelerate,
        reverseDuration: Durations.medium1,
      ),
      tooltip: widget.tooltip,
      icon: Row(
        children: [
          if (widget.icon != null) widget.icon!,
          const Icon(Icons.arrow_drop_down),
        ],
      ),
      initialValue: _selectedOption,
      onSelected: (T value) {
        setState(() {
          _selectedOption = value;
          widget.onSelect(value);
        });
      },
      itemBuilder:
          (BuildContext context) => [
            for (var option in widget.options)
              PopupMenuItem(
                value: option.value,
                child: Row(
                  children: [
                    if (option.icon != null) Icon(option.icon),
                    if (option.icon != null) const SizedBox(width: 10),
                    Text(option.label, style: AppTextStyles.normal),
                  ],
                ),
              ),
          ],
    );
  }
}
