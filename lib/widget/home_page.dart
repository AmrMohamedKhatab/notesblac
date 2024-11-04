
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase3/categorise/edit.dart';
import 'package:firebase3/note/view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<QueryDocumentSnapshot> data =[];
  bool isLoding =true;

  getData()async{
 QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('categoris').where('id',isEqualTo:FirebaseAuth.instance.currentUser!.uid ).get();
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
        
        Navigator.of(context).pushNamed('AddCategory');
      },
      child: Icon(Icons.add,color: Colors.white,),
      ),
      appBar: AppBar(title: Text('HomePage'),
      actions: [
        IconButton(onPressed: ()async{
          GoogleSignIn googleSignIn =GoogleSignIn();

          googleSignIn .disconnect();
          await FirebaseAuth.instance.signOut();
          Navigator.of(context).pushNamedAndRemoveUntil('Login', (route)=>false);
        }, icon: Icon(Icons.exit_to_app))
      ],
      ),
      body:isLoding ==true
      ?Center(child: CircularProgressIndicator(),): GridView.builder(
        itemCount:data.length ,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
        mainAxisExtent: 160),
        itemBuilder: (context, index) {
          return  InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NoteView(categoryid: data[index].id)));
            },
            onLongPress: () {
              AwesomeDialog(
            context: context,
            dialogType: DialogType.warning,
            animType: AnimType.rightSlide,
            title: 'Error',
            desc: 'are you sure yyou want to delete',
            btnCancelText: "Delete",
            btnOkText: 'update',
           btnCancelOnPress: ()async {
              await FirebaseFirestore.instance.collection('categoris').doc(data[index].id).delete();
              Navigator.of(context).pushReplacementNamed('HomePage');
           },
            btnOkOnPress: () async{
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditCategory(docid: data[index].id, oldname: data[index]['name'])));
            },
           
            ).show();
            },
            child: Card(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(children: [
                Image.network(
                  'https://cdn.icon-icons.com/icons2/1129/PNG/512/blackpapernotesnotebookwithspring_79964.png',
                  height: 100,
                  ),
                Text("${data[index]['name']}",style: TextStyle(fontWeight: FontWeight.bold),)
              ],),
            ),
                    ),
          );
        }
        
       
       
       
      
      ),

    );
  }
}