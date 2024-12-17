import 'package:flutter/material.dart';

import '../presentations/models/product_model.dart';
import 'database_helper/database_helper.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  List<Map<String, dynamic>> _billItems = [];

  List<Product> get products => _products;

  List<Map<String, dynamic>> get billItems => _billItems;
  double get totalAmount =>
      _billItems.fold(0.0, (sum, item) => sum + item['totalPrice']);

  ProductProvider() {
    fetchProducts();
    fetchBillItems();
  }
  Future<void> fetchProducts() async {
    _products = await DatabaseHelper.instance.getAllProducts();
    notifyListeners();
  }

// Fetch bill items from SQLite
  Future<void> fetchBillItems() async {
    _billItems = await DatabaseHelper.instance.getAllBillItems();
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    await DatabaseHelper.instance.insertProduct(product);
    await fetchProducts();
  }

  Future<void> deleteProduct(int id) async {
    await DatabaseHelper.instance.deleteProduct(id);
    await fetchProducts();
  }

  Future<void> updateProduct(Product updatedProduct) async {
    await DatabaseHelper.instance.updateProduct(updatedProduct);
    final index =
        _products.indexWhere((product) => product.id == updatedProduct.id);
    if (index != -1) {
      _products[index] = updatedProduct;

      notifyListeners();
    }
  }

  Future<void> addToBills(Product product, int quantity) async {
    const taxRate = 0.12449999999999999;
    final double unitPrice = product.unitPrice;
    final double totalPrice = (unitPrice * quantity) * (1 + taxRate);

    final item = {
      'name': product.name,
      'quantity': quantity,
      'unit': product.unit,
      'unitPrice': unitPrice,
      'totalPrice': totalPrice,
    };

    await DatabaseHelper.instance.insertBillItem(item);
    await fetchBillItems(); // Refresh bill items
  }

// Updated addToBill function with null safety
  Future<void> addToBillss(Product product, int quantity) async {
    const taxRate = 0.12449999999999999;

    // Ensure unitPrice is not null
    if (product.unitPrice == 0.0) {
      throw Exception('Product unit price cannot be zero');
    }

    final double totalPrice = (product.unitPrice * quantity) * (1 + taxRate);

    final item = {
      'name': product.name,
      'quantity': quantity,
      'unit': product.unit,
      'unitPrice': product.unitPrice,
      'totalPrice': totalPrice,
    };

    await DatabaseHelper.instance.insertBillItem(item);
    await fetchBillItems();
  }

  Future<void> addToBill(Product product, int quantity) async {
    const taxRate = 0.12449999999999999;

    // Debug: Print the product details
    print('Adding product: ${product.toString()}');

    if (product.unitPrice == 0.0) {
      throw Exception('Product unit price cannot be zero');
    }

    final double totalPrice = (product.unitPrice * quantity) * (1 + taxRate);

    final item = {
      'name': product.name,
      'quantity': quantity,
      'unit': product.unit,
      'unitPrice': product.unitPrice,
      'totalPrice': totalPrice,
    };

    await DatabaseHelper.instance.insertBillItem(item);
    await fetchBillItems();
  }

  // Remove a bill item from SQLite and the list
  Future<void> removeFromBill(int id) async {
    await DatabaseHelper.instance.deleteBillItem(id);
    await fetchBillItems(); // Refresh bill items
  }

  // Clear all bill items (used during checkout)
  Future<void> clearBill() async {
    await DatabaseHelper.instance.clearBillItems();
    _billItems.clear();
    notifyListeners();
  }
}

// Future<void> addProduct(Product product) async {
//   try {
//     final id = await DatabaseHelper.instance.insertProduct(product);
//     // Update the product with the generated ID
//     product = product.copyWith(id: id);
//     _products.add(product);
//     await fetchProducts();
//     notifyListeners();
//   } catch (e) {
//     print('Error adding product: $e');
//     // Handle error appropriately
//   }
// }

// Future<void> deleteProduct(int id) async {
//   try {
//     final success = await DatabaseHelper.instance.deleteProduct(id);
//     if (success) {
//       _products.removeWhere((product) => product.id == id);
//       notifyListeners();
//     }
//   } catch (e) {
//     print('Error deleting product: $e');
//     // Handle error appropriately
//   }
// }
