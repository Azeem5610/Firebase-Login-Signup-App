import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class myButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool isLoading;
  const myButton({
  super.key,
  required this.title,
  required this.onTap,
  this.isLoading=false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
                      style: ButtonStyle( 
                        backgroundColor:const WidgetStatePropertyAll( 
                           Colors.black87
                        ),
                        minimumSize: WidgetStatePropertyAll( 
                            Size(250.w,50.h)
                        ),
                        shape: WidgetStatePropertyAll( 
                          RoundedRectangleBorder( 
                            borderRadius: BorderRadius.circular(12.r)
                          )
                        )
                      ),
                     
                     
                      onPressed:onTap,
                       child:isLoading?const CircularProgressIndicator(): Center(child: Text(title,style: TextStyle(fontSize: 15.sp,fontWeight:FontWeight.w500,color:Colors.white),))
                      );
  }
}