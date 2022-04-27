import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import 'main.dart';

class addnote extends StatefulWidget {
  @override
  State<addnote> createState() => _addnoteState();
}

class _addnoteState extends State<addnote> {
  File? file;
  ImagePicker image = ImagePicker();
  String url = "";

  getImage() async {
    var img = await image.pickImage(source: ImageSource.gallery);
    setState(() {
      file = File(img!.path);
    });
    if (file != null) {
      uploadFile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 11, 133),
        actions: [
          MaterialButton(
            onPressed: () {},
            child: Text(
              "save",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 251, 251, 251),
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => Home()));
            },
            child: Text(
              "Back",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 251, 251, 251),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: file == null ? Text('no image') : Image.file(file!),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getImage();
        },
        child: Icon(Icons.add_a_photo),
        tooltip: 'open camera',
      ),
    );
  }

  uploadFile() async {
    var rng = Random();
    var k = rng.nextInt(10000);
    try {
      var imagefile =
          FirebaseStorage.instance.ref().child("images").child("$k");
      UploadTask task = imagefile.putFile(file!);
      TaskSnapshot snapshot = await task;
      url = await snapshot.ref.getDownloadURL();

      print(url);
      if (url != null && file != null) {
        Fluttertoast.showToast(
          msg: "Done Uploaded",
          textColor: Colors.red,
        ).whenComplete(() {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => Home()));
        });
      } else {
        Fluttertoast.showToast(
          msg: "Something went wrong",
          textColor: Colors.red,
        ).whenComplete(() {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => Home()));
        });
      }
    } on Exception catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        textColor: Colors.red,
      ).whenComplete(() {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => Home()));
      });
    }
  }
}
