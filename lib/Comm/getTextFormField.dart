import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:project_skripsi/Comm/comHelper.dart';
import 'comHelper.dart';

class getTextFormField extends StatelessWidget {
  TextEditingController controller;
  String hintName;
  IconData icon;
  bool isObscrueText;
  TextInputType inputType;

  getTextFormField(
      {required this.controller,
      required this.hintName,
      required this.icon,
      this.inputType = TextInputType.text,
      this.isObscrueText = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      margin: EdgeInsets.only(top: 2),
      child: TextFormField(
          controller: controller,
          obscureText: isObscrueText,
          keyboardType: inputType,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $hintName';
            }
            if (hintName == "Email" && !validateEmail(value)) {
              return 'Please Enter Valid Email';
            }
            return null;
          },
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(14),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.deepOrange),
                borderRadius: BorderRadius.circular(14),
              ),
              prefixIcon: Icon(icon),
              hintText: hintName,
              labelText: hintName,
              fillColor: Colors.grey[200],
              filled: true)),
    );
  }
}
