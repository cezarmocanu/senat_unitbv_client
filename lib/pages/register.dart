import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senat_unit_bv/store/user_slice.dart';
import 'package:senat_unit_bv/theme.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController emailC;
  late TextEditingController passwordC;
  late TextEditingController tokenC;
  late bool isLoading;
  late bool hasError;

  @override
  void initState() {
    super.initState();
    emailC = TextEditingController();
    passwordC = TextEditingController();
    tokenC = TextEditingController();
    isLoading = false;
    hasError = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.chevron_left),
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil("/login", (_) => false);
                      },
                    ),
                    Text(
                      "Inregistrare",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
                const SizedBox(height: 64),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: emailC,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppPalette.primaryColor),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: AppPalette.primaryColor),
                            ),
                            labelText: 'E-mail',
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: passwordC,
                          obscureText: true,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppPalette.primaryColor),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: AppPalette.primaryColor),
                            ),
                            labelText: 'Parola',
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: tokenC,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppPalette.primaryColor),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: AppPalette.primaryColor),
                            ),
                            labelText: 'Cod invitatie',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (hasError) ...[
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 32,
                    child: Text(
                      "Inregistrare nereusita, verifica toate campurile",
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.redAccent),
                    ),
                  ),
                  const SizedBox(height: 16),
                ] else ...[
                  const SizedBox(height: 64)
                ],
                if (isLoading) ...[
                  const CircularProgressIndicator(),
                ] else ...[
                  ElevatedButton(
                    onPressed: () => _handleRegister(),
                    child: const Text("Inregistrare"),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailC.dispose();
    passwordC.dispose();
    super.dispose();
  }

  void _handleRegister() async {
    setState(() {
      isLoading = true;
      hasError = false;
    });
    bool isRegisterSuccess = await Provider.of<UserSlice>(context, listen: false).register(
      email: emailC.text,
      password: passwordC.text,
      token: tokenC.text,
    );
    setState(() => isLoading = false);
    if (isRegisterSuccess) {
      if (!mounted) return;

      const snackBar = SnackBar(
        backgroundColor: Colors.green,
        content: Text('Inregistrare cu success'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      Navigator.of(context).pushNamedAndRemoveUntil("/login", (_) => false);
      return;
    }

    setState(() => hasError = true);
  }
}
