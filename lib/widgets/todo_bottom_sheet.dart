import 'package:flutter/material.dart';

class TodoBottomSheet extends StatefulWidget {
  const TodoBottomSheet({super.key});

  @override
  State<TodoBottomSheet> createState() => _TodoBottomSheetState();
}

TextEditingController textControler = TextEditingController();

String? errorText;

class _TodoBottomSheetState extends State<TodoBottomSheet> {
  bool validate() {
    final text = textControler.value.text;

    if (text.isEmpty) {
      errorText = "Pole nie moze byc puste!";
      return false;
    }

    setState(() {
      errorText = null;
    });
    return true;
  }

  // @override
  // void initState() {
  //   textControler.clear();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Wrap(
        runSpacing: 30,
        children: [
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
            child: TextField(
              //keyboardType: TextInputType.streetAddress,
              textInputAction: TextInputAction.done,
              controller: textControler,
              decoration: InputDecoration(
                labelText: "Dodaj TODO",
                errorText: errorText,
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                validate();
              },
              onEditingComplete: () {
                validate() ? Navigator.pop(context, textControler.text) : null;
                textControler.clear();
              },
            ),
          ),
        ],
      ),
    );
  }
}
