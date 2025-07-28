import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';

class CustomDropdownExample extends StatefulWidget {
  final String? hintText;
  final TextEditingController controller;
  final List<String> dataSource;

  const CustomDropdownExample(
      {super.key,
      this.hintText,
      required this.controller,
      required this.dataSource});
  @override
  State<CustomDropdownExample> createState() => _CustomDropdownExampleState();
}

class _CustomDropdownExampleState extends State<CustomDropdownExample> {
  final jobRoleCtrl = TextEditingController();

  Future<List<String>> getFakeRequestData(String query) async {
    //List<String> data = ['Developer', 'Designer', 'Consultant', 'Student'];

    return await Future.delayed(const Duration(seconds: 1), () {
      return widget.dataSource.where((e) {
        return e.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomDropdown.searchRequest(
      items: widget.dataSource,
      futureRequest: getFakeRequestData,
      borderSide: const BorderSide(
        color: Colors.grey,
        width: 1,
      ),
      fillColor: Colors.grey[100],
      hintStyle: const TextStyle(fontSize: 13, color: Colors.black87),
      hintText: widget.hintText ?? 'Rechercher...',
      controller: widget.controller,
      futureRequestDelay: const Duration(
          seconds: 1), //it waits 1 seconds before start searching (before
      // execute the 'futureRequest' function)
    );
  }
}