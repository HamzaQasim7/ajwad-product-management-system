import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/product_provider.dart';
import '../../../widgets/custom_snack_bar.dart';
import '../../../widgets/product_list_tile.dart';
import 'edit_product_screen.dart';

class ViewProductsScreen extends StatelessWidget {
  const ViewProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Products',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      ),
      body: Consumer<ProductProvider>(builder: (context, pProvider, child) {
        if (pProvider.products.isEmpty) {
          return const Center(child: Text('No products added yet.'));
        }
        return ListView.builder(
          addAutomaticKeepAlives: true,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          reverse: true,
          itemCount: pProvider.products.length,
          itemBuilder: (context, index) {
            final product = pProvider.products[index];
            return ProductListItem(
              productName: product.name,
              unit: product.unit,
              price: product.unitPrice,
              onEdit: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProductScreen(product: product),
                  ),
                );
              },
              onDelete: () {
                Provider.of<ProductProvider>(context, listen: false)
                    .deleteProduct(product.id!)
                    .then((_) {
                  CustomSnackbar.show(
                    context,
                    message: '${product.name} Product deleted successfully!',
                    backgroundColor: Colors.green,
                    icon: Icons.check_circle,
                    durationInSeconds: 2,
                  );
                });
              },
            );
          },
        );
      }),
    );
  }
}
