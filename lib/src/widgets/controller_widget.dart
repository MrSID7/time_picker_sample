import 'package:flutter/material.dart';
import 'package:time_picker_sample/src/utils/constants/colors.dart';
import 'package:time_picker_sample/src/utils/extensions/extensions.dart';

class ControllerWidget extends StatefulWidget {
  const ControllerWidget({
    this.controllerDetails = const {},
    required this.onChanged,
    super.key,
  });

  final Map<String, ControllerDetails> controllerDetails;
  final void Function(double value, String key) onChanged;

  @override
  State<ControllerWidget> createState() => _ControllerWidgetState();
}

class _ControllerWidgetState extends State<ControllerWidget> {
  double currentSliderValue = 0;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: kwhite,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: context.width * 0.3,
          maxWidth: context.width,
          maxHeight: context.height * 0.3,
          minHeight: 0,
        ),
        child: ListView.builder(
          itemCount: widget.controllerDetails.length,
          itemBuilder: (context, index) {
            final key = widget.controllerDetails.keys.elementAt(index);
            return ListTile(
              title: Column(
                children: [
                  Text(key),
                  Slider(
                    activeColor: kRed,
                    inactiveColor: kGrey,
                    key: Key(key),
                    divisions: widget.controllerDetails[key]?.divisions ?? 1,
                    value: currentSliderValue,
                    min: (widget.controllerDetails[key]?.values.start ?? 0) % 1,
                    max: (widget.controllerDetails[key]?.values.start ?? 1) % 1,
                    onChanged: (value) => _onChanged(value, key),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _onChanged(double value, String key) {
    currentSliderValue = value;
    widget.onChanged(value, key);
  }
}

enum ControllerType {
  slider,
  dropDown,
}

class ControllerDetails<T> {
  final ControllerType type;
  final RangeValues values;
  final int? divisions;

  const ControllerDetails({
    required this.type,
    required this.values,
    this.divisions,
  });
}

final controllerDetails = <String, ControllerDetails>{};
