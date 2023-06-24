import 'package:flutter/material.dart';
import 'package:senat_unit_bv/theme.dart';

class InviteBs {
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
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
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
                      'Trimite invitatie',
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
                        controller: _emailController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppPalette.primaryColor),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: AppPalette.primaryColor),
                          ),
                          labelText: 'Email',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Trimite invitatie'),
                  ],
                ),
                onPressed: _handleOnInvite,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _handleOnInvite() {
    Navigator.of(context).pop(_emailController.text);
  }
}
