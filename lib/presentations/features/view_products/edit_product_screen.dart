import 'package:ajwad/widgets/custom_action_button.dart';
import 'package:ajwad/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/product_provider.dart';
import '../../../widgets/custom_snack_bar.dart';
import '../../models/product_model.dart';

class EditProductScreen extends StatefulWidget {
  final Product product;

  const EditProductScreen({super.key, required this.product});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _unitController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product.name);
    _priceController =
        TextEditingController(text: widget.product.unitPrice.toString());
    _unitController = TextEditingController(text: widget.product.unit);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _unitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Product',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CustomFormField(
                    controller: _nameController,
                    label: 'Product Name',
                    hintText: ''),
                const SizedBox(height: 16),
                CustomFormField(
                    controller: _priceController,
                    label: 'Product Price',
                    hintText: ''),
                const SizedBox(height: 16),
                CustomFormField(
                    controller: _unitController, label: 'Unit', hintText: ''),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
        child: CustomButton(
            text: 'Update ${_nameController.text}',
            onPressed: () {
              final updatedProduct = Product(
                id: widget.product.id,
                name: _nameController.text,
                unitPrice: double.parse(_priceController.text),
                unit: _unitController.text,
              );
              Provider.of<ProductProvider>(context, listen: false)
                  .updateProduct(updatedProduct)
                  .then((_) {
                CustomSnackbar.show(
                  context,
                  message: 'Product updated successfully!',
                  backgroundColor: Colors.green,
                  icon: Icons.check_circle,
                  durationInSeconds: 2,
                );
                Navigator.pop(context);
              });
            }),
      ),
    );
  }
}
