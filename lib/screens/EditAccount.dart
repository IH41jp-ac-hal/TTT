import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:trukkertrakker/screens/account.dart';

class EditAccountScreen extends StatefulWidget {
  final AccountInfo accountInfo;

  EditAccountScreen({required this.accountInfo});

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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0), // AppBarの高さをここで指定します
        child: AppBar(
          title: Text('プロフィール編集', style: TextStyle(color: Colors.white)),
          backgroundColor: Color(0xFF84a2d4),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 80,
          right: 20,
          bottom: 20,
          left: 20,
        ),
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50.0,
                backgroundImage: _imageFile != null
                    ? FileImage(_imageFile!)
                    : AssetImage(_profileImageUrl) as ImageProvider,
                backgroundColor: Color(0xFFffffff),
              ),
            ),
            SizedBox(height: 20.0),

            // 名前入力フィールド
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: '名前',
              ),
            ),
            SizedBox(height: 20.0),

            // メールアドレス入力フィールド
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'メールアドレス',
              ),
            ),
            SizedBox(height: 20.0),

            // バイオ入力フィールド
            TextField(
              controller: _bioController,
              decoration: InputDecoration(
                labelText: '自己紹介',
              ),
            ),
            SizedBox(height: 20.0),

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
              child: Text(
                '保存',
                style: TextStyle(color: Color(0xFF84a2d4)),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xFFe6e6e6),
    );
  }
}
