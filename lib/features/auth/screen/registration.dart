import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:pinput/pinput.dart';
import 'package:talent_app/constants/app_constants.dart';
import 'package:talent_app/features/auth/screen/complete_registration.dart';
import 'package:talent_app/features/auth/screen/login.dart';
import 'package:talent_app/features/auth/services/login_service.dart';
import 'package:talent_app/features/auth/widgets/custom_button.dart';
import 'package:talent_app/features/auth/widgets/custom_textfield.dart';
import 'package:talent_app/features/auth/widgets/wave_widget.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  String dropdownvalue = 'Class 5';
  String? phoneNumber;
  String? countryCode;
  String? _otpMessage = ' ';

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController classController = TextEditingController();
  final TextEditingController schoolController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final List<String> items = [
    'Class 1',
    'Class 2',
    'Class 3',
    'Class 4',
    'Class 5',
    'Class 6',
    'Class 7',
    'Class 8',
    'Class 9',
    'Class 10',
    'Class 11',
    'Class 12',
  ];

  //static const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
  //static const fillColor = Color.fromRGBO(243, 246, 249, 0);
  static const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle:
        const TextStyle(fontSize: 22, color: Color.fromRGBO(30, 60, 87, 1)),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(19),
      border: Border.all(color: borderColor),
    ),
  );

  final List<int> otpArray = [123456];

  // void submitForm() {
  //   if (_formKey.currentState!.validate()) {
  //     print("Form Submitted Successfully!");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Opacity(
                  opacity: 0.5,
                  child: wave_widget(
                      height: MediaQuery.of(context).size.height * 0.25),
                ),
                wave_widget(height: MediaQuery.of(context).size.height * 0.225),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.05,
                  left: 0,
                  right: 0,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 100),
                    child: Text(
                      'Tell Us a Bit About Yourself',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppConstant.cardBackground,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),    
                    ),
                  ),
                ),
              ], 
            ),
           // const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      labelText: "First Name",
                      hintText: "Enter your first name",
                      controller: firstNameController,
                    ),
                    const SizedBox(height: 17),
                    CustomTextField(
                      labelText: "Last Name",
                      hintText: "Enter your last name",
                      controller: lastNameController,
                    ),
                    const SizedBox(height: 17),
                    IntlPhoneField(
                      controller: phoneController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 18),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Enter phone number',
                        hintStyle: const TextStyle(color: Colors.grey),
                      ),
                      initialCountryCode: 'IN',
                      keyboardType: TextInputType.number,
                      onChanged: (phone) {
                        setState(() {
                          countryCode = phone.countryCode;
                          phoneNumber = phone.number;
                        });
                      },
                      onCountryChanged: (country) {
                        setState(() {
                          countryCode = country.dialCode;
                        });
                      },
                    ),
                    CustomTextField(
                      labelText: "Email id",
                      hintText: "Enter your email id",
                      controller: emailController,
                    ),
                    const SizedBox(height: 17),
                    CustomTextField(
                      labelText: "Password",
                      hintText: "Enter your password",
                      isPassword: true,
                      controller: passwordController,
                    ),
                    const SizedBox(height: 17),
                    CustomTextField(
                      labelText: "Confirm Password",
                      hintText: "Enter your password",
                      isPassword: true,
                      controller: confirmPasswordController,
                    ),
                    const SizedBox(height: 17),
                    DropdownButtonHideUnderline(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 12),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(
                                  color:
                                      const Color.fromARGB(255, 120, 120, 120)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          isExpanded: true,
                          items: items.map((String item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Text(item),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalue = newValue!;
                            });
                          },
                          value: dropdownvalue,
                        ),
                      ),
                    ),
                    const SizedBox(height: 17),
                    CustomTextField(
                      labelText: "School Name",
                      hintText: "Enter your school name",
                      controller: schoolController,
                    ),
                    const SizedBox(height: 30),
                    SafeArea(
                      child: Center(
                        child: CustomButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate() &&
                                phoneNumber != null &&
                                countryCode != null) {
                              AuthService authService = AuthService();
                              authService
                                  .sendOtp(
                                      code: countryCode!, phone: phoneNumber!)
                                  .then((response) {
                                if (response.type == 'success') {
                                  var otp = response.otp;
                                  otpArray.add(int.parse(otp));
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(25.0)),
                                    ),
                                    builder: (BuildContext context) {
                                      return SafeArea(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom),
                                          child: Container(
                                            padding: EdgeInsets.all(20),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  'Enter OTP',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(height: 20),
                                                Pinput(
                                                  length: 6,
                                                  controller: pinController,
                                                  focusNode: focusNode,
                                                  defaultPinTheme:
                                                      defaultPinTheme,
                                                  onClipboardFound: (value) {
                                                    pinController
                                                        .setText(value);
                                                  },
                                                  hapticFeedbackType:
                                                      HapticFeedbackType
                                                          .lightImpact,
                                                ),
                                                SizedBox(height: 20),
                                                Text(
                                                  'Please enter the OTP sent to your phone number.',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black54),
                                                ),
                                                Text(
                                                  _otpMessage!,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.red),
                                                ),
                                                SizedBox(height: 20),
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors
                                                                  .deepPurple),
                                                  onPressed: () {
                                                    if (otpArray.contains(
                                                        int.parse(pinController
                                                            .text))) {
                                                      Navigator.of(context)
                                                          .pop();
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                              'OTP Verified Successfully'),
                                                          backgroundColor:
                                                              Colors.green,
                                                        ),
                                                      );
                                                      Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              CompleteRegistration(
                                                            classIDName:
                                                                dropdownvalue,
                                                            countryCode:
                                                                countryCode!,
                                                            emailId:
                                                                emailController
                                                                    .text,
                                                            firstName:
                                                                firstNameController
                                                                    .text,
                                                            lastName:
                                                                lastNameController
                                                                    .text,
                                                            mobileNumber:
                                                                phoneNumber!,
                                                            password:
                                                                passwordController
                                                                    .text,
                                                            school:
                                                                schoolController
                                                                    .text,
                                                          ),
                                                        ),
                                                      );
                                                    } else {
                                                      setState(() {
                                                        _otpMessage =
                                                            'Invalid OTP. Please try again.';
                                                      });
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                              'Invalid OTP'),
                                                          backgroundColor:
                                                              Colors.red,
                                                        ),
                                                      );
                                                    }
                                                  },
                                                  child: Text('Verify OTP',
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Failed to send OTP'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              }).catchError((error) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Failed to send OTP'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              });
                            }
                          },
                        ),
                      ),
                    ),
                    //const SizedBox(height: 40),
                    const SizedBox(height: 5),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Login()),
                          );
                        },
                        child: const Text(
                          "Already have an account? Sign In",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black, // Customize color
                          ),
                        ),
                      ),
                    )
                    
                  ],
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
