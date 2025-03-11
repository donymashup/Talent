import 'package:alpha/common%20widgets/bottom_navigation_bar.dart';
import 'package:alpha/constants/app_constants.dart';
import 'package:alpha/features/auth/screen/registration.dart';
import 'package:alpha/features/auth/services/login_service.dart';
import 'package:alpha/features/auth/widgets/custom_elavatedbutton.dart';
import 'package:alpha/features/auth/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? phoneNumber;
  String? countryCode;
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isRegEnabled = false;

  initState() {
    super.initState();
    _isRegistrationEnabled();
    // Add listeners to this class
  }

  _isRegistrationEnabled() async {
    var res = await AuthService().isRegistrationEnabled();
    if (res.type == 'success') {
      setState(() {
        _isRegEnabled = true;
      });
    }
  }

  Future<void> handleLogin() async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });

    var res = await AuthService().loginUser(
      phone: phoneNumber ?? '',
      code: countryCode ?? '',
      password: passwordController.text,
      context: context,
    );

    setState(() {
      _isLoading = false; // Hide loading indicator
    });
    if (res?.type == 'success') {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => CustomBottomNavigation()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppConstant.backgroundColor,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Gradient Background
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 200, // Gradient height
              decoration: BoxDecoration(
                gradient: AppConstant.redWhiteGradient,
              ),
            ),
          ),

          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Image.asset(
                        'assets/images/talentlogo.png', // Replace with your logo asset path
                        height: 100, // Adjust the height as needed
                      ),
                    ),
                    const Text(
                      'Login',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Please enter your phone number and\npassword to continue',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withAlpha(25),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          IntlPhoneField(
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 18),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  color: Colors.grey, // Stroke color
                                  width: 1.0, // Stroke width
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Enter phone number',
                              hintStyle: const TextStyle(color: Colors.grey),
                            ),
                            initialCountryCode: 'IN',
                            keyboardType: TextInputType.phone,
                            onChanged: (phone) {
                              debugPrint(
                                  "completeNumber ${phone.completeNumber}"); //get complete number
                              debugPrint(
                                  "countryCode ${phone.countryCode}"); // get country code only
                              debugPrint(
                                  "number ${phone.number}"); // only phone number
                              debugPrint(
                                  "countryISOCode ${phone.countryISOCode}"); // only phone number
                              setState(() {
                                countryCode = phone.countryCode;
                                phoneNumber = phone.number;
                              });
                            },
                            onCountryChanged: (country) {
                              debugPrint(
                                  'Country changed to: ${country.dialCode}');
                              setState(() {
                                countryCode = country.dialCode;
                              });
                            },
                          ),
                          const SizedBox(height: 5),
                          CustomTextField(
                            labelText: "Password",
                            hintText: "Enter your password",
                            isPassword: true,
                            controller: passwordController,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: CustomElavatedButton(
                        onPressed: _isLoading ? null : handleLogin,
                        child: _isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    Visibility(
                      visible: _isRegEnabled,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegistrationScreen()),
                          );
                        },
                        child: const Text(
                          "Don't have an account? Sign Up",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black, // Customize color
                          ),
                        ),
                      ),
                    )
                    // "Don't have an account?" TextButton
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 50), // Extra spacing before gradient
        ],
      ),
    );
  }
}
