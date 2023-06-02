// import 'package:flutter/material.dart';
// import 'package:library_pc/controllers/db_helper.dart';

// class PopupForm extends StatefulWidget {
//   const PopupForm({Key? key, required this.onUserRegistered}) : super(key: key);
//   final Function onUserRegistered;

//   @override
//   _PopupFormState createState() => _PopupFormState();
// }

// class _PopupFormState extends State<PopupForm> {
//   final _formKey = GlobalKey<FormState>();
//   final _indexController = TextEditingController();
//   final _fullNameController = TextEditingController();
//   final _chargesController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('User Registration form'),
//       content: SingleChildScrollView(
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextFormField(
//                 controller: _indexController,
//                 decoration: InputDecoration(
//                   labelText: 'IndexNo',
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter IndexNo';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _fullNameController,
//                 decoration: InputDecoration(
//                   labelText: 'Full Name',
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter Full Name';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _chargesController,
//                 decoration: InputDecoration(
//                   labelText: 'Charges',
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter Charges';
//                   }
//                   if (double.tryParse(value) == null) {
//                     return 'Please enter a valid number';
//                   }
//                   return null;
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//       actions: [
//         ElevatedButton(
//           onPressed: () async {
//             if (_formKey.currentState!.validate()) {
//               // save the data and close the popup
//               final indexNo = _indexController.text;
//               final fullName = _fullNameController.text;
//               final charges = double.parse(_chargesController.text);
//               await DBHelper.addUser(indexNo, fullName, charges);
//               // Add the user to the database here using the DBHelper
//               // class and then close the popup
//               widget.onUserRegistered.call();
//               Navigator.of(context).pop();
//             }
//           },
//           child: Text('Register'),
//         ),
//         TextButton(
//           onPressed: () {
//             // close the popup without saving
//             Navigator.of(context).pop();
//           },
//           child: Text('Cancel'),
//         ),
//       ],
//     );
//   }
// }
