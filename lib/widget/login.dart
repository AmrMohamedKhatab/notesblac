import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase3/widgets/componts/custom_Text_filed.dart';
import 'package:firebase3/widgets/componts/custom_button.dart';
import 'package:firebase3/widgets/componts/custom_logo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController Email =TextEditingController();
  TextEditingController password =TextEditingController();

  GlobalKey<FormState>formState = GlobalKey<FormState>();
  bool isLoding =false;

  Future signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  if(googleUser ==null){
    return ;
  }

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
   await FirebaseAuth.instance.signInWithCredential(credential);

  Navigator.of(context).pushNamedAndRemoveUntil('HomePage', (route) => false);
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('login ')),

      body: isLoding ?Center(child: CircularProgressIndicator(),): Container(
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
              
                  const Text('Login',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
                  Container(height: 10,),
                  const Text('Login To Contiun Using The App',style: TextStyle(color: Colors.grey),),
                  Container(height: 20,),
                  const Text('Email',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                  Container(height: 10,),
                  CustomTextForimFeild(
                    hintText: 'Entr yor email',
                     mycontroller: Email,validator: (val) {
                       if(val ==''){
                       return ' Cant To be Empty';
                       }
                     },
                     ),
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
             
                     InkWell(
                      onTap: () async{
                        if(Email.text ==''){
                           AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.rightSlide,
            title: 'Error',
            desc: 'please enter your email and then click forgot password',
           
            ).show();
                          return ;
                        }
                       try{
                         await FirebaseAuth.instance
                         .sendPasswordResetEmail(email: Email.text);

                       }catch(e){
                         AwesomeDialog(
            context: context,
            dialogType: DialogType.success ,
            animType: AnimType.rightSlide,
            title: 'Error',
            desc: 'please make sure your email is correct',
           
            ).show();
                       }
                         AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.rightSlide,
            title: 'Error',
            desc: 'A link has been sent to reset your password',
           
            ).show();
                      },
                       child: Container(
                                           margin: const EdgeInsets.only(top: 10 ,bottom: 20),
                                           alignment: Alignment.bottomRight,
                                           child: const Text(
                        'For get password ?',
                        textAlign: TextAlign.right,
                        style: TextStyle(color: Colors.black,fontSize: 10),),
                                         ),
                     ),
             
                 
             
                     
             ],
             ),
           ),
           CustomButton(title: 'Login',onPressed: ()async{
            if(formState.currentState!.validate()){
              try {
                bool isLoding =true;
                setState(() {
                  
                });
  final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: Email.text,
    password: password.text,
  );
   isLoding =false;
   setState(() {
     
   });
  if(credential.user!.emailVerified){
    Navigator.of(context).pushReplacementNamed('HomePage');
  }else{
    FirebaseAuth.instance.currentUser!.sendEmailVerification();
     AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.rightSlide,
            title: 'Error',
            desc: 'please enter link of the gmail',
           
            ).show();
  }
} on FirebaseAuthException catch (e) {
    isLoding =false;
                setState(() {});
  if (e.code == 'user-not-found') {
    print('No user found for that email.');
    AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.rightSlide,
            title: 'Error',
            desc: 'No user found for that email',
           
            ).show();
  } else if (e.code == 'wrong-password') {
    print('Wrong password provided for that user.');
    AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.rightSlide,
            title: 'Error',
            desc: 'Wrong password provided for that user.',
           
            ).show();
  }
}
            }else{
              print('Not valid');
            }
           },),

           Container(height: 10,),
                 MaterialButton(
          height: 40,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
                color: Colors.grey,
                textColor: Colors.white,
                onPressed: (){
                  signInWithGoogle();
                },
                child:const Text('Login with Google'),),

                Container(height: 10,),

                
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).pushReplacementNamed('SignUp');
                  },
                  child: Center(
                    child: Text.rich(TextSpan(children:[
                      TextSpan(text: 'Dont Have An Acount?',),
                      TextSpan(text: 'Register',style: TextStyle(
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