import 'package:flutter/material.dart';
import 'package:talent_app/constants/app_constants.dart';

class EditPen extends StatelessWidget {
  const EditPen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: MediaQuery.of(context).size.width * 0.45 - 15, 
      child: GestureDetector(
         onTap: () {
           // Add your edit pen functionality here
         },
         child: Container(
          decoration: BoxDecoration(
            color: Colors.white, 
            shape: BoxShape.circle,
            border: Border.all(
            color:Colors.white , // Border color
            width: 2, // Border width
            ),
          ),
           child: const CircleAvatar(
             radius: 15,
             backgroundColor: AppConstant.primaryColor, 
             child: Icon(
     Icons.edit,
     color: Colors.white,
     size: 16,
             ),
           ),
         ),
      ),
    );
  }
}

