// import 'package:email_auth/email_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

// class RegisterAdmin extends StatefulWidget {
//   const RegisterAdmin({super.key});

//   @override
//   State<RegisterAdmin> createState() => _RegisterAdminState();
// }

// class _RegisterAdminState extends State<RegisterAdmin> {
//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();
//   final _otpController = TextEditingController();
//   bool _showOtpField = false;

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _otpController.dispose();
//     super.dispose();
//   }

//   void _sendOtp() async {
//     EmailAuth.sessionName = "My App";
//     var res = await EmailAuth.sendOtp(receiverMail: _emailController.text);

//     if (res) {
//       setState(() {
//         _showOtpField = true;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("OTP sent to ${_emailController.text}")));
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text("Failed to send OTP to ${_emailController.text}")));
//     }
//   }

//   void _verifyOtp() {
//     var res = EmailAuth.validate(
//         receiverMail: _emailController.text, userOTP: _otpController.text);

//     if (res) {
//       // Save the admin data to the database
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text("OTP verification succeeded")));
//     } else {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text("Invalid OTP")));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Register Admin")),
//       body: Form(
//         key: _formKey,
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: _emailController,
//                 keyboardType: TextInputType.emailAddress,
//                 decoration: InputDecoration(
//                     labelText: "Email",
//                     hintText: "Enter your email address",
//                     border: OutlineInputBorder()),
//                 validator: (value) {
//                   if (value.isEmpty) {
//                     return "Please enter your email address";
//                   } else if (!value.contains("@")) {
//                     return "Please enter a valid email address";
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               if (_showOtpField)
//                 TextFormField(
//                   controller: _otpController,
//                   keyboardType: TextInputType.number,
//                   decoration: InputDecoration(
//                       labelText: "OTP",
//                       hintText: "Enter the OTP sent to your email",
//                       border: OutlineInputBorder()),
//                   validator: (value) {
//                     if (value.isEmpty) {
//                       return "Please enter the OTP";
//                     }
//                     return null;
//                   },
//                 ),
//               SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState.validate()) {
//                     if (_showOtpField) {
//                       _verifyOtp();
//                     } else {
//                       _sendOtp();
//                     }
//                   }
//                 },
//                 child: Text(_showOtpField ? "Verify OTP" : "Send OTP"),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }