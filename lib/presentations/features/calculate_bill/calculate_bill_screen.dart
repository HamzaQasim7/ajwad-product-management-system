import 'package:ajwad/data/product_provider.dart';
import 'package:ajwad/presentations/features/edit_invoice/invoice_screen.dart';
import 'package:ajwad/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widgets/product_list_tile.dart';
import '../../models/product_model.dart';

class CalculateBillScreen extends StatefulWidget {
  const CalculateBillScreen({super.key});

  @override
  State<CalculateBillScreen> createState() => _CalculateBillScreenState();
}

class _CalculateBillScreenState extends State<CalculateBillScreen> {
  final _quantityController = TextEditingController();

  // final _taxController =
  //     TextEditingController(text: 0.12449999999999999.toString());
  Product? _selectedProduct;

  @override
  void dispose() {
    _quantityController.dispose();
    // _taxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculate Bills',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Total: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: 'SAR ${provider.totalAmount.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                ActionButton(
                  text: 'Proceed to checkout',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const InvoiceScreen(
                                  telePhone: '',
                                )));
                  },
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                ),
              ],
            ),
            const SizedBox(height: 20),
            const ProductTable(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) {
                return StatefulBuilder(
                  builder: (context, setDialogState) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      titlePadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      title: const Text(
                        'Add item',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white, // White background
                              border: Border.all(
                                  color: Colors.grey,
                                  width: 1), // Grey border with 1px width
                              borderRadius: BorderRadius.circular(
                                  8), // Rounded corners (optional)
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: DropdownButton<Product>(
                              underline: const SizedBox.shrink(),
                              focusColor: Colors.white,
                              dropdownColor: Colors.white,
                              isExpanded: true,
                              value: _selectedProduct,
                              hint: const Text('Select Product'),
                              items: provider.products.map((product) {
                                return DropdownMenuItem(
                                  value: product,
                                  child: Text(product.name),
                                );
                              }).toList(),
                              onChanged: (product) {
                                setDialogState(() {
                                  _selectedProduct = product;
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 8),
                          CustomFormField(
                              keyboardType: TextInputType.number,
                              controller: _quantityController,
                              label: 'Quantity',
                              hintText: '07'),
                        ],
                      ),
                      actions: [
                        ActionButton(
                            height: 45,
                            text: 'Add',
                            onPressed: () {
                              if (_selectedProduct != null &&
                                  _quantityController.text.isNotEmpty) {
                                provider.addToBill(
                                  _selectedProduct!,
                                  int.parse(_quantityController.text),
                                );
                                setState(() {});
                                Navigator.pop(context);
                              }
                            },
                            backgroundColor: Colors.green,
                            textColor: Colors.white)
                      ],
                    );
                  },
                );
              });
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 25,
        ),
      ),
    );
  }
}

class ProductTable extends StatelessWidget {
  const ProductTable({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: constraints.maxWidth),
            child: DataTable(
              columnSpacing: 12.0,
              headingRowColor: WidgetStateProperty.all(Colors.grey[300]),
              border: TableBorder.all(color: Colors.grey.shade300),
              columns: const [
                DataColumn(
                  label: Text(
                    'S.NO',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'PRODUCT NAME',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'QTY',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'UNIT',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'UNIT PRICE',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'TOTAL',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                DataColumn(label: Text('')),
              ],
              rows: List<DataRow>.generate(provider.billItems.length, (index) {
                final item = provider.billItems[index];
                return DataRow(cells: [
                  DataCell(Text('${index + 1}')),
                  DataCell(Text(item['name'])),
                  DataCell(Text('${item['quantity']}')),
                  DataCell(Text(item['unit'])),
                  DataCell(Text('SAR ${item['unitPrice']}')),
                  DataCell(
                      Text('SAR ${item['totalPrice'].toStringAsFixed(2)}')),
                  DataCell(
                    ActionButton(
                      text: 'Delete',
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      onPressed: () {
                        if (item['id'] != null) {
                          provider.removeFromBill(item['id']);
                        } else {
                          print('Error: Item ID is null');
                        }
                      },
                    ),
                  ),
                ]);
              }),
            ),
          ),
        );
      },
    );
  }
}
