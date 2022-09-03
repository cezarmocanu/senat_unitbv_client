import 'package:flutter/material.dart';
import 'package:senat_unit_bv/theme.dart';

class ChipButtonFull extends StatefulWidget {
  final String label;
  final IconData iconData;
  final Function() onTap;
  bool? dense;

  ChipButtonFull({
    super.key,
    required this.label,
    required this.iconData,
    required this.onTap,
    this.dense,
  });

  @override
  State<ChipButtonFull> createState() => _ChipButtonFullState();
}

class _ChipButtonFullState extends State<ChipButtonFull> {
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(12),
      color: AppPalette.primaryColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: widget.onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: widget.dense == true ? 4 : 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.label,
                style: Theme.of(context).textTheme.caption!.copyWith(color: AppPalette.primaryContrastColor),
              ),
              const SizedBox(width: 4),
              Icon(
                widget.iconData,
                color: AppPalette.primaryContrastColor,
                size: Theme.of(context).textTheme.caption!.fontSize,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
