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
  final IconData icon;
  final String? tooltip;

  const OptionSelector({
    super.key,
    required this.options,
    required this.defaultValue,
    required this.icon,
    this.tooltip,
  });

  @override
  State<OptionSelector> createState() => _OptionSelectorState();
}

class _OptionSelectorState<T> extends State<OptionSelector> {
  late T _selectedOption;

  @override
  void initState() {
    super.initState();
    _selectedOption = widget.defaultValue;
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<T>(
      offset: Offset(0, 60),
      popUpAnimationStyle: AnimationStyle(
        curve: Curves.decelerate,
        duration: Durations.medium1,
        reverseCurve: Curves.decelerate,
        reverseDuration: Durations.medium1,
      ),
      tooltip: widget.tooltip,
      icon: Icon(widget.icon),
      initialValue: _selectedOption,
      onSelected: (T value) {
        setState(() {
          _selectedOption = value;
          debugPrint("Selected: $value");
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
                    if (option.icon != null) SizedBox(width: 10),
                    Text(option.label, style: AppTextStyles.normal),
                  ],
                ),
              ),
          ],
    );
  }
}
