import 'package:ajwad/presentations/features/edit_invoice/invoice_screen.dart';
import 'package:flutter/material.dart';

import '../../../widgets/custom_action_button.dart';
import '../../../widgets/custom_text_field.dart';

class EditInvoiceFormScreen extends StatefulWidget {
  const EditInvoiceFormScreen({super.key});

  @override
  State<EditInvoiceFormScreen> createState() => _EditInvoiceFormScreenState();
}

class _EditInvoiceFormScreenState extends State<EditInvoiceFormScreen> {
  final _telePhoneController = TextEditingController();
  final _phoneController = TextEditingController();
  final _userNoController = TextEditingController();
  final _taxNoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _telePhoneController.dispose();
    _phoneController.dispose();
    _userNoController.dispose();
    _taxNoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Invoice',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
            child: Form(
              key: _formKey,
              child: Center(
                child: Column(
                  children: [
                    Image.asset('assets/icons/Ajwad.png'),
                    CustomFormField(
                      label: 'Telephone',
                      hintText: '0507090016',
                      keyboardType: TextInputType.number,
                      controller: _telePhoneController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter telephone number';
                        }
                        if (!RegExp(r'^(05\d{8}|011\d{7}|012\d{7}|013\d{7})$')
                            .hasMatch(value)) {
                          return 'Enter a valid telephone number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomFormField(
                      label: 'Phone',
                      hintText: '0507090016',
                      controller: _phoneController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        if (!RegExp(r'^(05\d{8})$').hasMatch(value)) {
                          return 'Enter a valid mobile number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomFormField(
                      label: 'User No',
                      hintText: '021',
                      controller: _userNoController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter user number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 40),
                    CustomButton(
                      text: 'Save details',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => InvoiceScreen(
                                        telePhone: _telePhoneController.text,
                                        userNumber: _userNoController.text,
                                      )));
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
