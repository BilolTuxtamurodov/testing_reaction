import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  String label;
  TextEditingController controller;
  CustomTextFormField({Key? key, required this.label, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          Container(
            margin: const EdgeInsets.only(top: 3),
            padding: const EdgeInsets.all(10),
            height: 60,
            width: size.width - 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey.shade300,
                border: Border.all(color: Colors.grey, width: 2)
            ),
            child: TextFormField(
              controller: controller,
              decoration: const InputDecoration(
                  border: InputBorder.none
              ),
            ),
          )
        ],
      ),
    );
  }
}
