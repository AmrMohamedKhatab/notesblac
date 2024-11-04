
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase3/note/view.dart';
import 'package:firebase3/widgets/componts/custom_button.dart';
import 'package:firebase3/widgets/componts/custom_text_filedadd.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class AddNote extends StatefulWidget {
  final String docid;
  
  const AddNote({super.key, required this.docid,});

  @override
  State<AddNote> createState() => _AddNoteState();
  
}

class _AddNoteState extends State<AddNote> {
    GlobalKey<FormState>formState = GlobalKey<FormState>();
    TextEditingController Note=TextEditingController();
   
     File? file;
  String? url;
    bool isLoding =false;
    AddNote(context)async{
      CollectionReference collectionNote =
      FirebaseFirestore.instance.collection('categoris').doc(widget.docid).collection('note');
      
      if(formState.currentState!.validate()){
        try{
          isLoding =true;
      setState(() {  });
           DocumentReference response= await collectionNote.add({
        "note":Note.text,"url":url??"none"} );
       
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context)=>NoteView(
            categoryid: widget.docid)), );


        }catch(e){
          isLoding = false;
          setState(() {
            
          });
          print('Error $e');
        }
        
      }
    }
    

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
    

    

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('Add Category'),),

      body: Form(
        key: formState,
        child: isLoding?Center(child: CircularProgressIndicator(),): Column(children: [
          
Container(
  padding: EdgeInsets.symmetric(vertical: 20,horizontal: 30),
  child: CustomTextForimFeildAdd(
    hintText: 'Enter your note',
     mycontroller: Note, validator: (val){
    if(val=='')
    return  'cant To be Empty';
  }),
),
CustomButtonUpload(title: 'Upload Image', isSelected:url==null?false:true ,onPressed: ()async{
  await gtiImage();
},),


CustomButton(title: 'Add',onPressed: (){
  AddNote(context);
},)
        ],),
      ),
    );

  }
}