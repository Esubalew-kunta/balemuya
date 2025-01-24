
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:blaemuya/common/screens/newPassword.dart';
import 'package:blaemuya/widgets/large_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class Otp extends ConsumerStatefulWidget {
  static const routeName = '/otp-verification';
  final String email;

  const Otp({Key? key, required this.email})
      : super(key: key);

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends ConsumerState<Otp> {
  final TextEditingController _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void verifyOtp() async {
    final otp = _otpController.text;
    if (otp.length == 6) {
      // final authController = ref.read(authControllerProvider);

      // await authController.verifyOTP(widget.email, otp);

      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => ResetPasswordPage(email: widget.email),
      //   ),
      // );
    } else {
        //   showCustomSnackBar(
        //   context,
        //   title: 'Error',
        //   message: 'Insert Correct otp ',
        //   type: AnimatedSnackBarType.error,
        // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text(
          "Balemuya",
          style: TextStyle(
            color: Colors.black, // Set the color of the text
            fontSize: 14, // Set the font size
            fontWeight: FontWeight.w300, // Set the font weight (bold)
            letterSpacing: 1.2, // Adjust the letter spacing
          ),
        ),
        centerTitle: true,
       
      ),
      body: Center(
        child: ConstrainedBox(
            constraints: const BoxConstraints(
            maxWidth: 400, 
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 70),
              Text(
                "Enter the OTP sent to ${widget.email}",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 20),
              PinCodeTextField(
                appContext: context,
                length: 6, 
                obscureText: false,
                keyboardType: TextInputType.number,
                autoFocus: true,
                controller: _otpController,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(10),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: Colors.white,
                  inactiveFillColor: Colors.white,
                  selectedFillColor: Colors.white,
                ),
                boxShadows: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    spreadRadius: 1,
                  ),
                ],
                onChanged: (value) {
                  // Optional: Handle changes in OTP value
                },
                beforeTextPaste: (text) {
                  return true;
                },
              ),
              const SizedBox(height: 30),
              LargeButton(
                        text: 'Next',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Newpassword(email: "abc@gmail.com",),
                            ),
                          );
                        },
                      ),
            ],
          ),
        ),
      ),
    );
  }
}