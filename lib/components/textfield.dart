import 'package:flutter/material.dart';

class TextFieldSample extends StatefulWidget {
  final Function callback;
  final String label;
  final String hint;
  const TextFieldSample(this.callback, this.label, this.hint, {super.key});

  @override
  State<TextFieldSample> createState() => TextFieldSampleState();
}

class TextFieldSampleState extends State<TextFieldSample> {
  @override
  Widget build(BuildContext context) {
    final _controller = TextEditingController();

    final label = widget.label;
    final hint = widget.hint;

    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        children: [
          TextFormField(
            onSaved: (val) {
              print("Text value: ${val!}");
            },
            validator: (val) {
              // we used the val parameter for checking instead of the value inside the variable
              if (val == null || val.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            controller: _controller,
            // an onChanged property is placed to call the callback function
            onChanged: (value) {
              // we're not going to save the value of the text inside a separate variable anymore because we're going to pass it directly to the parent widget
              widget.callback(_controller.text);
            },

            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: label, hintText: hint),
          ),
        ],
      ),
    );
  }
}
