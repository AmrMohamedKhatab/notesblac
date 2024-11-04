
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase3/widgets/componts/custom_button.dart';
import 'package:firebase3/widgets/componts/custom_text_filedadd.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key,});

  @override
  State<AddCategory> createState() => _AddCategoryState();
  
}

class _AddCategoryState extends State<AddCategory> {
    GlobalKey<FormState>formState = GlobalKey<FormState>();
    TextEditingController name=TextEditingController();
   
    CollectionReference categorise =FirebaseFirestore.instance.collection('categoris');
    bool isLoding =false;
    AddCatogry()async{
      isLoding =true;
      setState(() {
        
      });
      if(formState.currentState!.validate()){
        try{
           DocumentReference response= await categorise.add({
        "name":name.text, 'id':FirebaseAuth.instance.currentUser!.uid } );
        isLoding =false;
      Navigator.of(context).pushNamedAndRemoveUntil ('HomePage',(route)=>false);


        }catch(e){
          isLoding = false;
          setState(() {
            
          });
          print('Error $e');
        }
        
      }
    
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
    hintText: 'Enter Name',
     mycontroller: name, validator: (val){
    if(val=='')
    return  'cant To be Empty';
  }),
),
CustomButton(title: 'Add',onPressed: (){
  AddCatogry();
},)
        ],),
      ),
    );

  }
}