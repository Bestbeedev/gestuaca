import 'package:flutter/material.dart';
//import 'package:clean_dialog/clean_dialog.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'This is a custom dialog',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
    // showDialog(
    //   context: context,
    //   builder: (context) => CleanDialog(
    //     title: 'Error',
    //     content: 'We were not able to update your information.',
    //     backgroundColor: const Color(0XFFbe3a2c),
    //     titleTextStyle: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
    //     contentTextStyle: const TextStyle(fontSize: 16, color: Colors.white),
    //     actions: [
    //       CleanDialogActionButtons(
    //         actionTitle: 'Cancel',
    //         onPressed: () => Navigator.pop(context),
    //       ),
    //       CleanDialogActionButtons(
    //         actionTitle: 'Try again',
    //         textColor: const Color(0XFF27ae61),
    //         onPressed: () {},
    //       ),
    //     ],
    //   ),
    // );
  }
}
