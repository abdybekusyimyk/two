import 'package:flutter/material.dart';

class AddProductView extends StatelessWidget {
  AddProductView({Key? key}) : super(key: key);

  final title = TextEditingController();
  final description = TextEditingController();
  final datetime = TextEditingController();
  final phonnumber = TextEditingController();
  final username = TextEditingController();
  final address = TextEditingController();
  final price = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddProductView'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
        children: [
          CustomTextfield(
            controller: title,
            hintText: 'Title',
          ),
          CustomTextfield(
            controller: description,
            hintText: 'Description',
          ),
          CustomTextfield(
            controller: datetime,
            hintText: 'DateTime',
          ),
          CustomTextfield(
            controller: phonnumber,
            hintText: 'PhoneNumber',
          ),
          CustomTextfield(
            controller: username,
            hintText: 'UserName',
          ),
          CustomTextfield(
            controller: address,
            hintText: 'Address',
          ),
          CustomTextfield(
            controller: price,
            hintText: 'Price',
          ),
          ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.publish),
              label: const Text('Add to fireStore'))
        ],
      ),
    );
  }
}

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    super.key,
    this.hintText,
    this.controller,
    this.maxLines,
    this.opTap,
  });

  final String? hintText;
  final TextEditingController? controller;
  final int? maxLines;
  final void Function()? opTap;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      onTap: opTap,
      decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)))),
    );
  }
}
