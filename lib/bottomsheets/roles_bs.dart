import 'package:flutter/material.dart';
import 'package:senat_unit_bv/theme.dart';

class RolesBs {
  static void show(BuildContext context) {
    showModalBottomSheet<void>(
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
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Roluri',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),
              for (int i = 0; i < 10; i++) ...[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.person_outline),
                            Text("George Moldovan"),
                          ],
                        ),
                        const Divider(),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                  visualDensity: VisualDensity.compact,
                                  checkColor: Colors.white,
                                  activeColor: AppPalette.primaryColor,
                                  value: true,
                                  onChanged: (bool? value) {
                                    setState(() {});
                                  },
                                ),
                                const Text("Permisiune 1"),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  visualDensity: VisualDensity.compact,
                                  checkColor: Colors.white,
                                  activeColor: AppPalette.primaryColor,
                                  value: false,
                                  onChanged: (bool? value) {
                                    setState(() {});
                                  },
                                ),
                                const Text("Permisiune 1"),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  visualDensity: VisualDensity.compact,
                                  activeColor: AppPalette.primaryColor,
                                  checkColor: Colors.white,
                                  value: true,
                                  onChanged: (bool? value) {
                                    setState(() {});
                                  },
                                ),
                                const Text("Permisiune 1"),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  visualDensity: VisualDensity.compact,
                                  activeColor: AppPalette.primaryColor,
                                  checkColor: Colors.white,
                                  value: true,
                                  onChanged: (bool? value) {
                                    setState(() {});
                                  },
                                ),
                                const Text("Permisiune 1"),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
