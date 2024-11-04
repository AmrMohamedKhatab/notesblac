import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ImagePaker extends StatefulWidget {
  const ImagePaker({super.key});

  @override
  State<ImagePaker> createState() => _ImagePakerState();
}

class _ImagePakerState extends State<ImagePaker> {

  File? file;
  String? url;

  gtiImage()async{

    final ImagePicker picker = ImagePicker(); 
final XFile? imagecamera = await picker.pickImage(source: ImageSource.camera);
if(imagecamera!=null ){
  file=File(imagecamera!.path);

var imagename =basename(imagecamera!.path);

  var refstorge =FirebaseStorage.instance.ref("images/$imagename");
  await refstorge.putFile(file!);
   url =await refstorge.getDownloadURL();
}

setState(() {}); 
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ImagePaker'),),
      body: Container(
        child:Column(
          children: [
            MaterialButton(onPressed: ()async{
             await gtiImage();
            },child: Text('Get Image camira'),
            ),
           if(file !=null) Image.network(url!,width: 100,height: 100,fit: BoxFit.fill,)
          ],))
    );
  }
}



// Pick an image.
// final XFile? imagegallery = await picker.pickImage(source: ImageSource.gallery);
// // Capture a photo.