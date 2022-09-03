import 'package:flutter/material.dart';
import 'package:senat_unit_bv/theme.dart';

class AddTopicBs {
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
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();

    _contentController = TextEditingController();
  }

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
                      'Creeaza topic',
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _contentController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppPalette.primaryColor),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: AppPalette.primaryColor),
                          ),
                          labelText: 'Continut',
                        ),
                        maxLines: 4,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _handleOnCreate,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Creeaza'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _handleOnCreate() {
    //TODO add validations
    final data = {
      "content": _contentController.text,
    };

    Navigator.of(context).pop(data);
  }
}
