import 'package:ajwad/presentations/features/add_product/add_product_screen.dart';
import 'package:ajwad/presentations/features/calculate_bill/calculate_bill_screen.dart';
import 'package:ajwad/presentations/features/edit_invoice/invoice_screen.dart';
import 'package:ajwad/presentations/features/home/widgets/action_grid_item.dart';
import 'package:ajwad/presentations/features/view_products/product_screen.dart';
import 'package:flutter/material.dart';

import '../edit_invoice/edit_invoice_form.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icons/Ajwad.png'),
            ActionGrid(
              onAddProducts: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const AddProductScreen()));
              },
              onCalculateBill: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const CalculateBillScreen()));
              },
              onViewProducts: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const ViewProductsScreen()));
              },
              onEditInvoice: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const EditInvoiceFormScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
