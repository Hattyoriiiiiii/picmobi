// import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({Key? key}) : super(key: key);

  // XFile? _image;
  // final ImagePicker = ImagePicker();

  // // カメラから画像を取得するメソッド
  // Future getImageFromCamera() async {
  //   final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
  //   setState(() {
  //     if (pickedFile != null) {
  //       _image = XFile(pickedFile.path);
  //     }
  //   });
  // }

  // // ギャラリーから画像を取得するメソッド
  // Future getImageFromGarally() async {
  //   final pickedFile = await ImagePicker.pickImage(source: ImageSource.gallery);
  //   setState(() {
  //     if (pickedFile != null) {
  //       _image = XFile(pickedFile.path)
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('撮影'),
      ),

      // body: const Center(
      //   child: _image == null
      //     ? Text(
      //       '写真を選択してください',
      //       // style: Theme.of(context).textTheme.headline4,
      //       style: TextStyle(fontSize: 32.0)
      //       )
          // : Image.file(_image!.path)),
      body:
          const Center(child: Text('撮影画面', style: TextStyle(fontSize: 32.0))),

      floatingActionButton: 
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          FloatingActionButton(
            onPressed: null, // getImageFromCamera,
            child: const Icon(Icons.photo_camera)
          ),
          FloatingActionButton(
            onPressed: null, //getImageFromGarally,
            child: const Icon(Icons.photo_album),
          )
    ]));
  }
}