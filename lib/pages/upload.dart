import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_management/core/res/color.dart';
import 'package:task_management/models/task.dart';
import 'package:task_management/widgets/circle_gradient_icon.dart';
import 'package:task_management/widgets/task.dart';
import 'package:image_picker/image_picker.dart';
import 'home.dart';
import 'dart:async'; // new
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({Key? key}) : super(key: key);

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  String defaultImage = "logo.png";
  String defaultImamgeURL = "https://handong.edu/site/handong/res/img/logo.png";
  String pickedImageName = "";

  PickedFile? pickedFile;
  FirebaseStorage storage = FirebaseStorage.instance;
  XFile? upLoadimage;
  // final ImagePicker _picker = ImagePicker();

  bool isLoaded = false;
  List<String> url = [];

  Future getImageFromGalley() async {
    var image =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    setState(() {
      pickedFile = image;
      if (pickedFile != null) isLoaded = true;
      url = pickedFile!.path.split("/");
      pickedImageName = url.last;
    });
    uploadFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: TextButton(
          onPressed: () async {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
          child: const Text(
            "Cancel",
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
            ),
          ),
        ),
        title: const Text("Add"),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            child: const Text(
              "Save",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Container(
              child: (isLoaded)
                  ? Image.file(File(pickedFile!.path))
                  : Image.network(
                      defaultImamgeURL,
                      fit: BoxFit.cover,
                    ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: getImageFromGalley,
                  child: Row(
                    children: const [
                      Icon(Icons.camera_alt),
                      Text("갤러리"),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: getImageFromGalley,
                  child: Row(
                    children: const [
                      Icon(Icons.camera_alt),
                      Text("카메라"),
                    ],
                  ),
                ),
              ],
            ),
            const Text(
              "주제",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter a title",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "어떻게 환경을 지켰는지 설명해주세요",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter a description",
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              // onPressed: () {
              //   Navigator.push(context,
              //       MaterialPageRoute(builder: (context) => HomeScreen()));
              // },
              // child: const Text("제출"),
              // style: ElevatedButton.styleFrom(
              //   backgroundColor: Colors.blue,
              //   // shape: RoundedRectangleBorder(
              //   //     // borderRadius: BorderRadius.circular(32.0),
              //   //     ),
              // ),
              onPressed: () async {
                addMessageToProduct();
              },
              child: Row(
                children: const [
                  Icon(Icons.send),
                  SizedBox(width: 4),
                  Text('SEND'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<DocumentReference> addMessageToProduct() async {
    String image = await FirebaseStorage.instance
        .ref()
        .child(
          isLoaded ? pickedImageName : defaultImage,
        )
        .getDownloadURL();
    var returnValue = await FirebaseFirestore.instance
        .collection('product')
        .add(<String, dynamic>{
      'title': _titleController.text,
      'description': _descriptionController.text,
      'image': image,
      'createdAt': DateTime.now(),
    });
    return returnValue;
  }

  Future uploadFile() async {
    try {
      final ref = storage.ref().child(url.last);
      await ref.putFile(File(pickedFile!.path));
    } catch (e) {
      print('error occured');
    }
  }
}
