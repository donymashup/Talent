import 'package:alpha/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomPeformanceMessage extends StatelessWidget {
  const CustomPeformanceMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.backgroundColor,
      appBar: AppBar(
        title: const Text('Performance Index' ,style: TextStyle(fontSize: 20),),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          }, 
          icon: Icon(Icons.arrow_back,size: 16,),
          ),
      ),
      body: SafeArea(
        child: Center(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Lottie Animation
              Lottie.asset(
                'assets/lottie/nodata.json', 
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              // Message
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(20),
                child: const Text(
                  "Insufficient data to generate performance insights.",
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}