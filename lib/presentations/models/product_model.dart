// class Product {
//   final String id;
//   final String name;
//   final int quantity;
//   final String unit;
//   final double unitPrice;
//   final double total;
//
//   Product({
//     required this.id,
//     required this.name,
//     required this.quantity,
//     required this.unit,
//     required this.unitPrice,
//     required this.total,
//   });
//   double totalPrice() {
//     return quantity * unitPrice;
//   }
// }

// class Product {
//   final int? id;
//   final String name;
//   final double price;
//   final String unit;
//
//   Product(
//       {this.id, required this.name, required this.price, required this.unit});
//
//   Map<String, dynamic> toMap() {
//     return {'id': id, 'name': name, 'price': price, 'unit': unit};
//   }
//
//   factory Product.fromMap(Map<String, dynamic> map) {
//     return Product(
//       id: map['id'],
//       name: map['name'],
//       price: map['price'],
//       unit: map['unit'],
//     );
//   }
// }

// class Product {
//   final int? id;
//   final String name;
//   final int quantity;
//   final String unit;
//   final double unitPrice;
//
//   Product({
//     this.id,
//     required this.name,
//     this.quantity = 1, // Default value
//     required this.unit,
//     required this.unitPrice,
//   });
//
//   // Calculate total price
//   double get total => quantity * unitPrice;
//
//   // Create a copy of Product with new values
//   Product copyWith({
//     int? id,
//     String? name,
//     int? quantity,
//     String? unit,
//     double? unitPrice,
//   }) {
//     return Product(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       quantity: quantity ?? this.quantity,
//       unit: unit ?? this.unit,
//       unitPrice: unitPrice ?? this.unitPrice,
//     );
//   }
//
//   // Convert Product to Map for database operations
//   Map<String, dynamic> toMap() {
//     return {
//       if (id != null) 'id': id,
//       'name': name,
//       'quantity': quantity,
//       'unit': unit,
//       'unitPrice': unitPrice,
//     };
//   }
//
//   // Create Product from Map (database results)
//   factory Product.fromMap(Map<String, dynamic> map) {
//     return Product(
//       id: map['id'],
//       name: map['name'],
//       quantity: map['quantity'] ?? 1,
//       unit: map['unit'],
//       unitPrice: map['unitPrice'],
//     );
//   }
//
//   @override
//   String toString() {
//     return 'Product{id: $id, name: $name, quantity: $quantity, unit: $unit, unitPrice: $unitPrice, total: $total}';
//   }
// }

class Product {
  final int? id;
  final String name;
  final int quantity;
  final String unit;
  final double unitPrice;

  Product({
    this.id,
    required this.name,
    this.quantity = 1,
    required this.unit,
    required this.unitPrice,
  });

  double get total => quantity * unitPrice;

  Product copyWith({
    int? id,
    String? name,
    int? quantity,
    String? unit,
    double? unitPrice,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      unitPrice: unitPrice ?? this.unitPrice,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'name': name,
      // 'quantity': quantity,
      'unit': unit,
      'unitPrice': unitPrice,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    // Add null checking and default values
    return Product(
      id: map['id'],
      name: map['name'] as String,
      // quantity: (map['quantity'] as num?)?.toInt() ?? 1,
      unit: map['unit'] as String,
      unitPrice: (map['unitPrice'] as num?)?.toDouble() ??
          0.0, // Provide default value
    );
  }

  @override
  String toString() {
    return 'Product{id: $id, name: $name, quantity: $quantity, unit: $unit, unitPrice: $unitPrice, total: $total}';
  }
}
