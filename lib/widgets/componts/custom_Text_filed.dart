import 'package:flutter/material.dart';

class CustomTextForimFeild extends StatelessWidget {
  const CustomTextForimFeild({super.key, required this.hintText, required this.mycontroller,required this.validator,});

  final String hintText;
  final TextEditingController mycontroller;
 final String? Function(String?)? validator;
  
  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      validator: validator,
      controller: mycontroller,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 2,horizontal: 20),
                  filled: true,
                  hintText: hintText,
                  hintStyle: TextStyle(color: Colors.grey,fontSize: 14),
                  
                
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(50)
                   ),
                   enabledBorder: OutlineInputBorder(
                     borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(50)
                   )
                ),
              );
  }
}