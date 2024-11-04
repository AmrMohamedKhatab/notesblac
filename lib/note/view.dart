
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase3/note/add.dart';
import 'package:firebase3/note/edit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class NoteView extends StatefulWidget {
  final String categoryid;
  const NoteView({super.key, required this.categoryid, });

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {

  List<QueryDocumentSnapshot> data =[];
  bool isLoding =true;

  getData()async{
 QuerySnapshot querySnapshot = await FirebaseFirestore.instance
 .collection('categoris').doc(widget.categoryid).collection('note').get();
 data.addAll(querySnapshot.docs);
 isLoding =false;
 setState(() {
   
 });
  }

    @override
    void initState(){
      getData();
      super.initState();
    }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: (){
        
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddNote(docid: widget.categoryid)));
      },
      child: Icon(Icons.add,color: Colors.white,),
      ),
      appBar: AppBar(title: Text('Note'),
      actions: [
        IconButton(onPressed: ()async{
          GoogleSignIn googleSignIn =GoogleSignIn();

          googleSignIn .disconnect();
          await FirebaseAuth.instance.signOut();
          Navigator.of(context).pushNamedAndRemoveUntil('Login', (route)=>false);
        }, icon: Icon(Icons.exit_to_app))
      ],
      ),
      body:WillPopScope(child: isLoding ==true
      ?Center(child: CircularProgressIndicator(),):
       GridView.builder(
        itemCount:data.length ,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
        mainAxisExtent: 160),
        itemBuilder: (context, index) {
          return  InkWell(
           onLongPress: () {
              AwesomeDialog(
            context: context,
            dialogType: DialogType.warning,
            animType: AnimType.rightSlide,
            title: 'Error',
            desc: 'are you sure yyou want to delete',
           
           btnCancelOnPress: ()async {
            
           },
            btnOkOnPress: () async{
              await FirebaseFirestore.instance
              .collection('categoris')
              .doc(widget.categoryid).collection('note').doc(data[index].id) .delete();

               if(data[index]['url']!="none"){
                FirebaseStorage.instance.refFromURL(data[index]['url']).delete();
               }
              
              Navigator.of(context)
              .push(MaterialPageRoute(builder: (context)=>NoteView(categoryid: widget.categoryid)));
            },
           
            ).show();
           },
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditNote(
                notedocid: data[index].id,
               categorydocid: widget.categoryid,
                value: data[index]['note'])));
            },
            child: Card(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(children: [
               
                Text("${data[index]['note']}",
                style: TextStyle(fontWeight: FontWeight.bold),),
                if(data[index]['url']!="none")
                SizedBox(height: 10,),
                Image.network(data[index]['url'],height: 80,)
              ],),
            ),
                    ),
          );
        }
        
       
       
       
      
      ), 
      onWillPop: (){
       Navigator.of(context).pushNamedAndRemoveUntil('HomePage', (route)=>false);
        return Future.value(false);
      })

    );
  }
}