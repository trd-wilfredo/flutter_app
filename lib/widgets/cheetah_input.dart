import 'package:flutter/material.dart';
import 'package:flutter_features/widgets/widget.dart';

class CheetahInput extends StatefulWidget {
  final String labelText;
  final String initVal;
  final bool hideText;
  final Function onSaved;
  const CheetahInput({
    Key? key,
    required this.hideText,
    required this.labelText,
    required this.initVal,
    required this.onSaved,
  }) : super(key: key);

  @override
  State<CheetahInput> createState() => _CheetahInputState();
}

class _CheetahInputState extends State<CheetahInput> {
  String textVal = '';
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.hideText,
      initialValue: widget.initVal,
      decoration: textInputDocoration.copyWith(
          // fillColor: Colors.white,
          // filled: true,
          // labelText: widget.labelText,
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(16),
          // ),
          // floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
      validator: (value) {
        setState(() {
          textVal = '$value';
        });

        var labelText = widget.labelText;
        if (value!.isNotEmpty) {
          widget.onSaved(value);
          if (widget.labelText == 'Email') {
            return RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value!)
                ? null
                : "Please enter a valid email";
          }
          if (widget.labelText == 'Password' && value!.length < 6) {
            return 'Password must be at least 6 charaters';
          }
          if (widget.labelText == 'Name' || labelText == 'Product Name')
            return null;
        } else {
          return '$labelText is required';
        }
      },
      onSaved: widget.onSaved(textVal),
    );
  }
}
