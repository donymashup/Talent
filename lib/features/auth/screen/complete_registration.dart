import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:talent_app/common%20widgets/bottom_navigation_bar.dart';
import 'package:talent_app/features/auth/services/login_service.dart';

class CompleteRegistration extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String emailId;
  final String password;
  final String mobileNumber;
  final String countryCode;
  final String school;
  final String classIDName;

  const CompleteRegistration({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.emailId,
    required this.password,
    required this.mobileNumber,
    required this.countryCode,
    required this.school,
    required this.classIDName,
  }) : super(key: key);

  @override
  _CompleteRegistrationState createState() => _CompleteRegistrationState();
}

class _CompleteRegistrationState extends State<CompleteRegistration> {
  bool _isLoading = false;
  bool _isError = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _registerUser();
  }

  Future<void> _registerUser() async {
    setState(() {
      _isLoading = true;
      _isError = false;
    });

    AuthService authService = AuthService();
    try {
      var result = await authService.registerUser(
        context: context,
        firstName: widget.firstName,
        lastName: widget.lastName,
        emailId: widget.emailId,
        password: widget.password,
        mobileNumber: widget.mobileNumber,
        countryCode: widget.countryCode,
        school: widget.school,
        classIDName: widget.classIDName,
      );

      if (result.type == 'success') {
        setState(() {
          _isLoading = false;
        });
        await Future.delayed(Duration(seconds: 1));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CustomBottomNavigation()),
        );
      } else {
        setState(() {
          _isError = true;
          _errorMessage = 'Error: ${result.message}';
        });
      }
    } catch (error) {
      setState(() {
        _isError = true;
        _errorMessage = 'Error: $error';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isLoading
            ? Lottie.asset('assets/lottie/loading.json')
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!_isError)
                    Text(
                      'Registration Complete',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  SizedBox(height: 20),
                  if (_isError && _errorMessage != null)
                    Text(
                      _errorMessage!,
                      style: TextStyle(color: Colors.red),
                    ),
                ],
              ),
      ),
    );
  }
}
