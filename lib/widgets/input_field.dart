import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const InputField({super.key, required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.deepPurple.withOpacity(.2)),
              child: TextFormField(
                controller: controller,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "$hintText is required";
                  }
                  return null;
                },
                decoration:  InputDecoration(
                  icon: const Icon(Icons.person),
                  border: InputBorder.none,
                  hintText: hintText,
                ),
              ),
            );
  }
}