import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:trukkertrakker/screens/account.dart';

class EditAccountScreen extends StatefulWidget {
  final AccountInfo accountInfo;

  const EditAccountScreen({super.key, required this.accountInfo});

  @override
  _EditAccountScreenState createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _bioController;
  late String _profileImageUrl;
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.accountInfo.name);
    _emailController = TextEditingController(text: widget.accountInfo.email);
    _bioController = TextEditingController(text: widget.accountInfo.bio);
    _profileImageUrl = widget.accountInfo.profileImageUrl;
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('プロフィール編集'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50.0,
                backgroundImage: _imageFile != null
                    ? FileImage(_imageFile!)
                    : AssetImage(_profileImageUrl) as ImageProvider,
              ),
            ),
            const SizedBox(height: 20.0),

            // 名前入力フィールド
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: '名前',
              ),
            ),
            const SizedBox(height: 20.0),

            // メールアドレス入力フィールド
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'メールアドレス',
              ),
            ),
            const SizedBox(height: 20.0),

            // バイオ入力フィールド
            TextField(
              controller: _bioController,
              decoration: const InputDecoration(
                labelText: '自己紹介',
              ),
            ),
            const SizedBox(height: 20.0),

            // 保存ボタン
            ElevatedButton(
              onPressed: () {
                widget.accountInfo.name = _nameController.text;
                widget.accountInfo.email = _emailController.text;
                widget.accountInfo.bio = _bioController.text;
                if (_imageFile != null) {
                  widget.accountInfo.profileImageUrl = _imageFile!.path;
                }

                Navigator.pop(context, widget.accountInfo);
              },
              child: const Text('保存'),
            ),
          ],
        ),
      ),
    );
  }
}
