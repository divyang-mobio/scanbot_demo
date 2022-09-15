import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:scanbot_demo/photo_model.dart';
import 'package:scanbot_demo/save_data_screen.dart';
import 'package:scanbot_sdk/common_data.dart' as cd;
import 'package:scanbot_sdk/document_scan_data.dart';
import 'package:scanbot_sdk/scanbot_sdk_ui.dart';
import 'database.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Image> currentPreviewImage = [];

  void scanDocument() async {
    var config = DocumentScannerConfiguration(
      multiPageEnabled: true,
      bottomBarBackgroundColor: Colors.blueAccent,
      cancelButtonTitle: "Cancel",
    );
    var result = await ScanbotSdkUi.startDocumentScanner(config);

    if (result.operationResult == cd.OperationResult.SUCCESS) {
      displayPageImage(result.pages);
    }
  }

  void displayPageImage(List<cd.Page> pages) {
    for (cd.Page i in pages) {
      File data = File.fromUri(i.documentPreviewImageFileUri as Uri);
      currentPreviewImage.add(Image.file(data, width: 300, height: 300));

      List<int> imageBytes = data.readAsBytesSync();
      String imageString = base64Encode(imageBytes);

      DatabaseHelper.instance.add(PhotoModel(image: imageString));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const SaveDataScreen()));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              MaterialButton(
                  onPressed: scanDocument, child: const Text("Scan Document")),
              if (currentPreviewImage.isNotEmpty) ...[
                const Text("scan Image"),
                ...currentPreviewImage
                    .map((image) => Container(
                        margin: const EdgeInsets.all(10), child: image))
                    .toList()
              ]
            ],
          ),
        ),
      ),
    );
  }
}
