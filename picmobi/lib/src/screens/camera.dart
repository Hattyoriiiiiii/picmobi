import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File? _image;
  final ImagePicker imagePicker = ImagePicker();
  String? _label; // ラベルを保存する変数
  int _quantity = 0; // 個数を保存する変数

  Future<void> predictImage() async {
    if (_image == null) return;

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('http://192.168.0.17:8000/predict'),
    );
    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        _image!.path,
      ),
    );

    final response = await request.send();
    final responseText = await response.stream.bytesToString();
    final result = jsonDecode(responseText);

    setState(() {
      _label = result['prediction']; // サーバーからのレスポンスを元にラベルを設定
    });
  }

  Future getImageFromCamera() async {
    final pickedFile = await imagePicker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
    predictImage(); // 追加
  }

  Future getImageFromGallery() async {
    final pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
    predictImage(); // 追加
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
            Text(
              _label ?? 'No label',
              style: TextStyle(fontSize: 24.0),
            ),
            Row( // 個数を選ぶボタンを追加
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      _quantity = (_quantity > 0) ? _quantity - 1 : 0; // 個数を減らす
                    });
                  },
                  icon: Icon(Icons.remove),
                ),
                Text(
                  '$_quantity',
                  style: TextStyle(fontSize: 24.0),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _quantity += 1; // 個数を増やす
                    });
                  },
                  icon: Icon(Icons.add),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FloatingActionButton(
                  onPressed: getImageFromCamera,
                  tooltip: 'Pick Image From Camera',
                  child: Icon(Icons.add_a_photo),
                ),
                FloatingActionButton(
                  onPressed: getImageFromGallery,
                  tooltip: 'Pick Image From Gallery',
                  child: Icon(Icons.photo_library),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
