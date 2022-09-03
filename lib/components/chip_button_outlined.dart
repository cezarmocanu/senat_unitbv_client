import 'package:flutter/material.dart';
import 'package:senat_unit_bv/theme.dart';

class ChipButtonOutlined extends StatefulWidget {
  final String label;
  final IconData? iconData;
  final Function() onTap;
  Color? color;
  bool? dense;

  ChipButtonOutlined({
    super.key,
    required this.label,
    required this.iconData,
    required this.onTap,
    this.color,
    this.dense,
  });

  @override
  State<ChipButtonOutlined> createState() => _ChipButtonOutlinedState();
}

class _ChipButtonOutlinedState extends State<ChipButtonOutlined> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: widget.color ?? AppPalette.primaryColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: AppPalette.primaryContrastColor,
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
                  style: Theme.of(context).textTheme.caption!.copyWith(color: AppPalette.primaryColor),
                ),
                const SizedBox(width: 4),
                if (widget.iconData != null)
                  Icon(
                    widget.iconData,
                    color: AppPalette.primaryColor,
                    size: Theme.of(context).textTheme.caption!.fontSize,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
