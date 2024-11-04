
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase3/note/view.dart';
import 'package:firebase3/widgets/componts/custom_button.dart';
import 'package:firebase3/widgets/componts/custom_text_filedadd.dart';
import 'package:flutter/material.dart';

class EditNote extends StatefulWidget {
  final String notedocid;
  final String categorydocid;
  final String value;
  const EditNote({super.key, required this.notedocid, required this.categorydocid, required this.value,});

  @override
  State<EditNote> createState() => _EditNoteState();
  
}

class _EditNoteState extends State<EditNote> {
    GlobalKey<FormState>formState = GlobalKey<FormState>();
    TextEditingController Note=TextEditingController();
   
    
    bool isLoding =false;  
    EditNote()async{
      CollectionReference collectionNote =
      FirebaseFirestore.instance.collection('categoris')
      .doc(widget.categorydocid)
      .collection('note');
      
      if(formState.currentState!.validate()){
        try{
          isLoding =true;
      setState(() {  });
          
            await collectionNote.doc(widget.notedocid).update({"note":Note.text} );
       
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context)=>NoteView(
            categoryid: widget.categorydocid)), );


        }catch(e){
          isLoding = false;
          setState(() {
            
          });
          print('Error $e');
        }
        } 
      }
@override
void initState(){
  Note.text=widget.value;
  super.initState();
}

    @override
    void dispose(){
      super.dispose();
      Note.dispose();
    }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('Edit '),),

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
CustomButton(
  title: 'Save',onPressed: (){
  EditNote();
},)
        ],),
      ),
    );

  }
}