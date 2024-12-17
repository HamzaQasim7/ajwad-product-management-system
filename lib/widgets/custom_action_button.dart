import 'package:flutter/material.dart';

enum CustomButtonType { primary, secondary, danger }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final CustomButtonType type;
  final bool isLoading;
  final double? width;
  final double height;
  final IconData? icon;
  final bool disabled;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = CustomButtonType.primary,
    this.isLoading = false,
    this.width,
    this.height = 54,
    this.icon,
    this.disabled = false,
  });

  Color _getButtonColor() {
    if (disabled) return Colors.grey;

    switch (type) {
      case CustomButtonType.primary:
        return Colors.green;
      case CustomButtonType.secondary:
        return Colors.blue;
      case CustomButtonType.danger:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: disabled ? null : (isLoading ? null : onPressed),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          backgroundColor: _getButtonColor(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 2,
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, color: Colors.white),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

// Example usage:
class ExampleScreen extends StatelessWidget {
  const ExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Regular button
        CustomButton(
          text: 'Add Product',
          onPressed: () {
            // Add product logic
          },
        ),

        const SizedBox(height: 16),

        // Button with icon
        CustomButton(
          text: 'Add to Cart',
          icon: Icons.shopping_cart,
          type: CustomButtonType.secondary,
          onPressed: () {
            // Add to cart logic
          },
        ),

        const SizedBox(height: 16),

        // Loading button
        CustomButton(
          text: 'Saving...',
          isLoading: true,
          onPressed: () {},
        ),

        const SizedBox(height: 16),

        // Danger button
        CustomButton(
          text: 'Delete',
          type: CustomButtonType.danger,
          onPressed: () {
            // Delete logic
          },
        ),

        const SizedBox(height: 16),

        // Disabled button
        CustomButton(
          text: 'Disabled',
          disabled: true,
          onPressed: () {},
        ),
      ],
    );
  }
}
