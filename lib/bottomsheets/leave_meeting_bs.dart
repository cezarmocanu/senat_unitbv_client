import 'package:flutter/material.dart';
import 'package:senat_unit_bv/components/chip_button_full.dart';
import 'package:senat_unit_bv/components/chip_button_outlined.dart';

class LeaveMeetingBs {
  static Future show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (_) => _Bs(),
    );
  }
}

class _Bs extends StatefulWidget {
  @override
  State<_Bs> createState() => _BsState();
}

class _BsState extends State<_Bs> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - MediaQueryData.fromWindow(WidgetsBinding.instance.window).padding.top,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.warning_amber_rounded),
                  Flexible(
                    child: Text(
                      'Esti sigur ca vrei sa parasesti meetingul?',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                  )
                ],
              ),
            ),
            const Expanded(child: SizedBox(height: 0)),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ChipButtonFull(
                        label: "Ramai in meeting",
                        iconData: Icons.arrow_back,
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ChipButtonOutlined(
                        label: "Paraseste meeting",
                        iconData: Icons.cancel,
                        onTap: () {
                          Navigator.of(context).pop(true);
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
