import 'package:flutter/material.dart';

class SwitchExample extends StatefulWidget {
  final Function callback; // Callback function

  const SwitchExample(this.callback, {super.key});

  @override
  State<SwitchExample> createState() => SwitchExampleState();
}

class SwitchExampleState extends State<SwitchExample> {
  bool light = false;
  final switchKey = GlobalKey<SwitchExampleState>();

  @override
  Widget build(BuildContext context) {
    final MaterialStateProperty<Color?> trackColor = MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        // Track color when the switch is selected.
        if (states.contains(MaterialState.selected)) {
          return Colors.green.shade200;
        }
        // Otherwise return null to set default track color
        // for remaining states such as when the switch is
        // hovered, focused, or disabled.
        return null;
      },
    );
    final MaterialStateProperty<Color?> overlayColor = MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        // Material color when switch is selected.
        if (states.contains(MaterialState.selected)) {
          return Colors.green.shade200.withOpacity(0.54);
        }
        // Material color when switch is disabled.
        if (states.contains(MaterialState.disabled)) {
          return Colors.red.shade200.withOpacity(0.54);
        }
        // Otherwise return null to set default material color
        // for remaining states such as when the switch is
        // hovered, or focused.
        return null;
      },
    );
    final MaterialStateProperty<Color?> thumbColor = MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        // Track color when the switch is selected.
        if (states.contains(MaterialState.selected)) {
          return Colors.green;
        }
        if (states.contains(MaterialState.disabled)) {
          return Colors.red;
        }
        // Otherwise return null to set default track color
        // for remaining states such as when the switch is
        // hovered, focused, or disabled.
        return null;
      },
    );
    final MaterialStateProperty<Icon?> thumbIcon = MaterialStateProperty.resolveWith<Icon?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return const Icon(Icons.check);
        }
        return const Icon(Icons.close);
      },
    );

    return Row(
      children: [
        Text(
          'Active?',
          style: TextStyle(fontSize: 16),
        ),
        Switch(
          key: switchKey,
          value: light,
          overlayColor: overlayColor,
          trackColor: trackColor,
          thumbColor: thumbColor,
          thumbIcon: thumbIcon,
          onChanged: (bool value) {
            setState(() {
              light = value;

            });
            widget.callback(value); // Call the callback function with the new value
          },
        ),
      ],
    );
  }

  void reset() {
    setState(() {
      light = false;
    });
    widget.callback(light);
  }
}
 