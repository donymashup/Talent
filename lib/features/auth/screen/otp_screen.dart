import 'package:alpha/common%20widgets/bottom_navigation_bar.dart';
import 'package:alpha/constants/app_constants.dart';
import 'package:alpha/features/auth/widgets/custom_elavatedbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();
  final FocusNode _otpFocusNode = FocusNode();
  String? _otpCode;

  @override
  void dispose() {
    _otpController.dispose();
    _otpFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppConstant.titlecolor,
      ),
      decoration: BoxDecoration(
        color: AppConstant.cardBackground,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: AppConstant.shadowColor,
            blurRadius: 4,
            spreadRadius: 2,
            offset: Offset(-2, 3),
          ),
        ],
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        border: Border.all(color: AppConstant.primaryColor),
        borderRadius: BorderRadius.circular(10),
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: AppConstant.backgroundColor,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            color: AppConstant.backgroundColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Phone Number\nAuthentication',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'An OTP has been sent to your Phone Number',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Pinput(
                    length: 6,
                    controller: _otpController,
                    focusNode: _otpFocusNode,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    submittedPinTheme: submittedPinTheme,
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return 'Enter a valid OTP';
                      }
                      return null;
                    },
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    onCompleted: (pin) {
                      setState(() {
                        _otpCode = pin;
                      });
                      print('OTP Entered: $pin');
                    },
                  ),
                  const SizedBox(height: 50),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: CustomElavatedButton(
                      child: Text(
                        'Verify OTP',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        if (_otpCode != null && _otpCode!.length == 6) {
                          print('Verifying OTP: $_otpCode');
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CustomBottomNavigation()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please enter a valid OTP')),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                gradient: AppConstant.redWhiteGradient,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
