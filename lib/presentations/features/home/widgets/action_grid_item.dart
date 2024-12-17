import 'package:flutter/material.dart';

class ActionGrid extends StatelessWidget {
  final Function() onAddProducts;
  final Function() onCalculateBill;
  final Function() onViewProducts;
  final Function() onEditInvoice;

  const ActionGrid({
    super.key,
    required this.onAddProducts,
    required this.onCalculateBill,
    required this.onViewProducts,
    required this.onEditInvoice,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      padding: const EdgeInsets.all(16),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: [
        _buildActionCard(
          icon: 'assets/icons/cart.png',
          title: 'Add Products',
          onTap: onAddProducts,
        ),
        _buildActionCard(
          icon: 'assets/icons/calculate-bill.png',
          title: 'Calculate Bill',
          onTap: onCalculateBill,
        ),
        _buildActionCard(
          icon: 'assets/icons/products.png',
          title: 'View Products',
          onTap: onViewProducts,
        ),
        _buildActionCard(
          icon: 'assets/icons/bill.png',
          title: 'Edit Invoice',
          onTap: onEditInvoice,
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required String icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 2),
                blurRadius: 0.2,
                spreadRadius: 0.2,
                color: Colors.grey.shade300,
              )
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              width: 50,
              height: 50,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
