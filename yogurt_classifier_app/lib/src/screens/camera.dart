import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File? _image;
  final ImagePicker imagePicker = ImagePicker();

  // カメラから画像を取得するメソッド
  Future getImageFromCamera() async {
    final pickedFile = await imagePicker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  // ギャラリーから画像を取得するメソッド
  Future getImageFromGallery() async {
    final pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('撮影'),
      ),
      body: Center(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 300,
                child: _image == null
                    ? Center(child: Text('No image selected.', style: TextStyle(fontSize: 24.0)))
                    : Image.file(_image!),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FloatingActionButton(
                onPressed: getImageFromCamera, //カメラから画像を取得
                tooltip: 'Pick Image From Camera',
                child: Icon(Icons.add_a_photo),
              ),
              FloatingActionButton(
                onPressed: getImageFromGallery, //ギャラリーから画像を取得
                tooltip: 'Pick Image From Gallery',
                child: Icon(Icons.photo_library),
              ),
              ],
            ),
            SizedBox(height: 20), // 余白を追加
          ],
        ),
      ),
    );
  }
}
