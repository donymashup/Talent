import 'package:alpha/constants/app_constants.dart';
import 'package:alpha/features/course_detailed/screens/freeEnrollmentScreen.dart';
import 'package:alpha/features/course_detailed/screens/paymentProcessingScreen.dart';
import 'package:alpha/models/course_details_model.dart';
import 'package:flutter/material.dart';
import 'package:alpha/features/course_detailed/services/course_details_services.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CheckoutScreen extends StatefulWidget {
  final CourseDetailsModel thisCourses;

  const CheckoutScreen({super.key, required this.thisCourses});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool agreeToTerms = false;
  String promoCode = '';
  final CourseDetailsService _courseDetailsService = CourseDetailsService();
  late Razorpay _razorpay;
  late String _orderid, _paymentid, _signature;
  bool _isPaymentProcessing = false;

  final promoCodeNameController = TextEditingController();
  final referalNameController = TextEditingController();
  final referalNumberController = TextEditingController();
  late double finalAmount, amountInRupee, amountInPaisa;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _successHandler);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _errorHandler);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _externalWalletHandler);

    finalAmount = double.parse(widget.thisCourses.details!.price!.toString());
    amountInRupee = finalAmount;
    amountInPaisa = amountInRupee * 100;
  }

  @override
  void dispose() {
    _razorpay.clear();
    promoCodeNameController.dispose();
    referalNameController.dispose();
    referalNumberController.dispose();
    super.dispose();
  }

  void _successHandler(PaymentSuccessResponse response) {
    setState(() {
      _paymentid = response.paymentId!;
      _signature = response.signature!;
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentProcessingScreen(
          signature: _signature,
          paymentid: _paymentid,
          orderid: _orderid,
          promo_code: promoCodeNameController.text,
          courseid: widget.thisCourses.details!.id!,
          amount: amountInRupee.toString(),
        ),
      ),
    );
  }

  void _errorHandler(PaymentFailureResponse response) {
    setState(() {
      _isPaymentProcessing = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Payment failed: ${response.message}'),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _externalWalletHandler(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('External wallet selected: ${response.walletName}'),
      ),
    );
  }

  void makePayment() async {
    setState(() {
      _isPaymentProcessing = true;
    });
    if (amountInPaisa != 0) {
      try {
        var ordercreated = await _courseDetailsService.createOrderId(
          context: context,
          courseId: widget.thisCourses.details!.id!,
          promoCode: promoCodeNameController.text,
          amount: amountInPaisa.toString(),
        );

        if (ordercreated!.type == "success") {
          setState(() {
            _orderid = ordercreated.orderid;
          });
          var options = {
            'key': AppConstant.RazorPay_key_id,
            'amount': amountInPaisa,
            'name': AppConstant.appName,
            'order_id': ordercreated.orderid,
            'description': widget.thisCourses.details!.name!,
            'prefill': {'contact': userData.phone, 'email': userData.email}
          };
          _razorpay.open(options);
        } else {
          _handleOrderCreationError(ordercreated);
        }
      } catch (e) {
        _handleOrderCreationError(null);
      }
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FreeEnrollmentScreen(
            promo_code: promoCodeNameController.text,
            courseid: widget.thisCourses.details!.id!,
            amount: amountInRupee.toString(),
          ),
        ),
      );
    }
  }

  void _handleOrderCreationError(ordercreated) {
    setState(() {
      _isPaymentProcessing = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(ordercreated?.orderid ?? 'Error Subscribing the Course'),
        backgroundColor:
            ordercreated?.type == "danger" ? Colors.red : Colors.blue,
      ),
    );
  }

  void _verifyPromoCode() async {
    try {
      var promoDetails = await _courseDetailsService.verifyPromoCode(
        promoCode: promoCode,
        courseId: widget.thisCourses.details?.id ?? '0',
        context: context,
      );

      if (promoDetails?.type == "success") {
        setState(() {
          amountInRupee = double.parse(promoDetails!.finalAmount.toString());
          amountInPaisa = amountInRupee * 100;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                promoDetails?.message ?? 'Promo code applied successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(promoDetails?.message ?? 'Invalid promo code!'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred while verifying the promo code.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Checkout',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          iconSize: 16,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Course Details',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                const SizedBox(height: 10),
                _buildCourseDetailsCard(),
                const SizedBox(height: 20),
                const Text('Referral Details (optional)',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                const SizedBox(height: 10),
                _buildReferralDetails(),
                const SizedBox(height: 20),
                const Text('Promo Code (optional)',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                const SizedBox(height: 10),
                _buildPromoCodeField(),
                const SizedBox(height: 20),
                _buildTermsAndConditions(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: agreeToTerms ? makePayment : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Proceed to Payment',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }

  Widget _buildCourseDetailsCard() {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(
            color: Color.fromARGB(255, 173, 173, 173), width: 2),
      ),
      shadowColor: Colors.grey.shade100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Image.network(
              widget.thisCourses.details?.image ?? '',
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.thisCourses.details?.name ?? 'Course Name',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 8),
                    Text(
                        'Duration: ${widget.thisCourses.details?.duration} Days',
                        style: const TextStyle(fontSize: 15)),
                  ],
                ),
                Text('Fee: ₹$amountInRupee',
                    style: const TextStyle(fontSize: 15)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReferralDetails() {
    return Column(
      children: [
        TextField(
          controller: referalNameController,
          decoration: const InputDecoration(
            labelText: 'Referrer Name',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: referalNumberController,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            labelText: 'Referrer Phone Number',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  Widget _buildPromoCodeField() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: TextField(
            controller: promoCodeNameController,
            decoration: const InputDecoration(
              labelText: 'Enter Promo Code',
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.discount, color: Colors.redAccent),
            ),
            onChanged: (value) {
              setState(() {
                promoCode = value.toUpperCase();
              });
            },
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
          flex: 1,
          child: ElevatedButton(
            onPressed: _verifyPromoCode,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              minimumSize: const Size(150, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Verify',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  Widget _buildTermsAndConditions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          value: agreeToTerms,
          onChanged: (value) {
            setState(() {
              agreeToTerms = value ?? false;
            });
          },
          activeColor: Colors.redAccent,
        ),
        const Expanded(
          child: Text('I agree to the Terms & Conditions',
              style: TextStyle(fontSize: 14)),
        ),
      ],
    );
  }
}
