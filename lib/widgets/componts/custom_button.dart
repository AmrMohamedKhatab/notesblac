import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.title, this.onPressed});

 final String title;
 final void Function()? onPressed;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
          height: 40,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
                color: Colors.black,
                textColor: Colors.white,
                onPressed: onPressed,
                child: Text(title),
                );

                
  }
}



class CustomButtonUpload extends StatelessWidget {
  const CustomButtonUpload
  ({super.key, required this.title, this.onPressed, required this.isSelected});

 final String title;
 final void Function()? onPressed;
 final bool isSelected;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
          height: 35,
          minWidth: 200,
          shape:  RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
                color: isSelected?Colors.green: Colors.black,
                textColor: Colors.white,
                onPressed: onPressed,
                child: Text(title),
                );

                
  }
}