import 'package:flutter/material.dart';

class DropdownSelector extends StatefulWidget {
  final String initialValue;
  final List<String> items;
  final Function(String)? onChanged;
  final double? borderRadius, verticalPadding, strokeWidth;
  final bool? isExpanded;

  const DropdownSelector({
    super.key,
    required this.initialValue,
    required this.items,
    this.onChanged,
    this.borderRadius,
    this.isExpanded,
    this.verticalPadding,
    this.strokeWidth,
  });

  @override
  State<DropdownSelector> createState() => _DropdownSelectorState();
}

class _DropdownSelectorState extends State<DropdownSelector> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue =
        widget.items.contains(widget.initialValue) ? widget.initialValue : null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border:
            Border.all(color: Colors.black54, width: widget.strokeWidth ?? 0.4),
      ),
      child: DropdownButton<dynamic>(
        focusColor: Colors.white,
        padding: EdgeInsets.symmetric(
            horizontal: 2, vertical: widget.verticalPadding ?? 5),
        underline: const SizedBox.shrink(),
        isDense: true,
        value: _selectedValue,
        onChanged: (newValue) {
          if (newValue != null) {
            setState(() {
              _selectedValue = newValue;
            });
            widget.onChanged!(newValue);
          }
        },
        hint: Text(
          widget.initialValue,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: const TextStyle(
              fontWeight: FontWeight.w400, fontSize: 12, color: Colors.grey),
        ),
        items: widget.items.map<DropdownMenuItem<dynamic>>(
          (String value) {
            return DropdownMenuItem<dynamic>(
              value: value,
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  value,
                  overflow: TextOverflow.ellipsis,
                  // style: TextStyle(fontSize: 10),
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            );
          },
        ).toList(),
        isExpanded: widget.isExpanded ?? true,
        iconSize: 15,
      ),
    );
  }
}
