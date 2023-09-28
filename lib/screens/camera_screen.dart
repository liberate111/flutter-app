import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? photoFile;

  Future<void> takePhoto() async {
    var photo = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      photoFile = photo;
    });
  }

  // preview image
  Widget previewImage() {
    if (photoFile != null) {
      return Center(
        child: Image.file(
          File(photoFile!.path),
          fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
        ),
      );
    } else {
      return const Center(
        child: Text('take a shot by press button'),
      );
    }
  }

  // upload image to server
  Future<void> uploadImage() async {
    var bytesImage = await File(photoFile!.path).readAsBytes();
    var base64Image = base64Encode(bytesImage);
    var url = Uri.parse('https://api.codingthailand.com/api/upload');
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'picture': 'data:image/jpeg;base64,$base64Image'}));
    if (response.statusCode == 200) {
      var resp = jsonDecode(response.body);
      Get.defaultDialog(
        title: '${resp['data']['message']}',
        content: Text('${resp['data']['url']}'),
        actions: [
          OutlinedButton(onPressed: () {
            Get.back();
          }, child: const Text('OK'))
        ]
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CAMERA'),
        actions: [
          photoFile != null
              ? IconButton(
                  onPressed: () async {
                    await uploadImage();
                  },
                  icon: const Icon(Icons.upload_file))
              : const SizedBox()
        ],
      ),
      body: previewImage(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await takePhoto();
        },
        tooltip: 'take a shot',
        child: const Icon(Icons.camera),
      ),
    );
  }
}
