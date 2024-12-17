import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/product_provider.dart';
import '../../../widgets/custom_action_button.dart';
import '../../../widgets/custom_snack_bar.dart';
import '../../../widgets/custom_text_field.dart';
import '../../models/product_model.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _productNameController = TextEditingController();
  final _priceController = TextEditingController();
  final _unitController = TextEditingController(text: 'pcs');

  @override
  void dispose() {
    _productNameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
            child: Center(
              child: Column(
                children: [
                  Image.asset('assets/icons/Ajwad.png'),
                  CustomFormField(
                    label: 'Product Name',
                    hintText: 'Enter product name',
                    controller: _productNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter product name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomFormField(
                    label: 'Price',
                    hintText: 'Enter price',
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter price';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomFormField(
                    label: 'Unit',
                    hintText: 'Piece',
                    controller: _unitController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your unit';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 40),
                  CustomButton(
                    text: 'Add Product',
                    onPressed: () {
                      final name = _productNameController.text;
                      final price = double.parse(_priceController.text);
                      final unit = _unitController.text;

                      final product =
                          Product(name: name, unitPrice: price, unit: unit);
                      Provider.of<ProductProvider>(context, listen: false)
                          .addProduct(product)
                          .then((_) {
                        CustomSnackbar.show(
                          context,
                          message: 'Product added successfully!',
                          backgroundColor: Colors.green,
                          icon: Icons.check_circle,
                          durationInSeconds: 2,
                        );
                        Navigator.pop(context);
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
