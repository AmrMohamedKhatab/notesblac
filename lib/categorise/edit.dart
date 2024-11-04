
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase3/widgets/componts/custom_button.dart';
import 'package:firebase3/widgets/componts/custom_text_filedadd.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class EditCategory extends StatefulWidget {
  final String docid;
  final String oldname;
  const EditCategory({super.key, required this.docid,required this.oldname,});

  @override
  State<EditCategory> createState() => _EditCategoryState();
  
}

class _EditCategoryState extends State<EditCategory> {
    GlobalKey<FormState>formState = GlobalKey<FormState>();
    TextEditingController name=TextEditingController();
   
    CollectionReference categorise =FirebaseFirestore.instance.collection('categoris');
    bool isLoding =false;
    editCatogry()async{
      isLoding =true;
      setState(() {
        
      });
      if(formState.currentState!.validate()){
        try{
            await categorise.doc(widget.docid).set({'name':name.text});
        
      Navigator.of(context).pushNamedAndRemoveUntil ('HomePage',(route)=>false);


        }catch(e){
          isLoding = false;
          setState(() {
            
          });
          print('Error $e');
        }
        }
    }

    @override
 void dispose() {
    super.dispose();
    name.dispose();
  }

 @override
 void initState(){
  super.initState();
  name.text =widget.oldname;
 }
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
    hintText: 'Enter Name',
     mycontroller: name, validator: (val){
    if(val=='')
    return  'cant To be Empty';
  }),
),
CustomButton(title: 'save',onPressed: (){
  editCatogry();
},)
        ],),
      ),
    );

  }
}