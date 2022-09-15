import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:scanbot_demo/photo_model.dart';

import 'database.dart';

class SaveDataScreen extends StatefulWidget {
  const SaveDataScreen({Key? key}) : super(key: key);

  @override
  State<SaveDataScreen> createState() => _SaveDataScreenState();
}

class _SaveDataScreenState extends State<SaveDataScreen> {
  List<Image> currentPreviewImage = [];

  getImage() async {
    List<PhotoModel> data = await DatabaseHelper.instance.getData();
    for (var i in data) {
      currentPreviewImage.add(Image.memory(base64Decode(i.image)));
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("save Image")),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const Text("Save Image"),
              if (currentPreviewImage.isNotEmpty)
                ...currentPreviewImage
                    .map((image) => Container(
                        margin: const EdgeInsets.all(10), child: image))
                    .toList()
            ],
          ),
        ),
      ),
    );
  }
}
