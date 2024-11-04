import 'package:firebase3/widgets/componts/custom_Text_filed.dart';
import 'package:firebase3/widgets/componts/custom_button.dart';
import 'package:firebase3/widgets/componts/custom_logo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
   TextEditingController Name =TextEditingController();
  TextEditingController Email =TextEditingController();
  TextEditingController password =TextEditingController();
  GlobalKey<FormState>formState =GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SignUp ')),

      body: Container(
           padding: EdgeInsets.all(20),
        child: ListView(
          children: [
           Form(
            key: formState,
             child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height:50 ,),
               CustomLogo(),
             
               Container(height: 20,),
              
                  const Text('SignUp',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
                  Container(height: 10,),
                  const Text('SignUp To Contiun Using The App',style: TextStyle(color: Colors.grey),),
                  Container(height: 20,),
                  const Text('name',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                  Container(height: 10,),
                  CustomTextForimFeild(
                    hintText: 'Entr yor name',
                     mycontroller: Name,validator: (val) {
                         if(val ==''){
                         return ' Cant To be Empty';
                         }
                       },),
                  Container(height: 20,),
                  const Text('Email',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                  Container(height: 10,),
                  CustomTextForimFeild(
                    hintText: 'Entr yor email',
                     mycontroller: Email,validator: (val) {
                         if(val ==''){
                         return ' Cant To be Empty';
                         }
                       },),
                     Container(height: 10,),
                     const Text('password',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                  Container(height: 10,),
                  CustomTextForimFeild(
                    hintText: 'Entr yor password',
                     mycontroller: password,validator: (val) {
                         if(val ==''){
                         return ' Cant To be Empty';
                         }
                       },),
                     Container(height: 10,),
             
                     Container(
                    margin: const EdgeInsets.only(top: 10 ,bottom: 20),
                    alignment: Alignment.bottomRight,
                    child: const Text(
                      'For get password ?',
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 10),),
                  ),
             
                 
             
                     
             ],
             ),
           ),
           CustomButton(title: 'SignUp',onPressed: ()async{
            if(formState.currentState!.validate()){
              try {
  final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: Email.text,
    password: password.text,
  );
  FirebaseAuth.instance.currentUser!.sendEmailVerification();
  Navigator.of(context).pushReplacementNamed('Login');
} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    print('The password provided is too weak.');
  } else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
  }
} catch (e) {
  print(e);
}
            }
           },),

           Container(height: 10,),
                
                Container(height: 10,),

                
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).pushReplacementNamed('Login');
                  },
                  child: Center(
                    child: Text.rich(TextSpan(children:[
                      TextSpan(text: ' Have An Acount?',),
                      TextSpan(text: 'Login',style: TextStyle(
                        color: Colors.blue,fontWeight: FontWeight.bold))
                    ] )),
                  ),
                )

          ],

          
          
        ),
      ),
    );

    
  }
}