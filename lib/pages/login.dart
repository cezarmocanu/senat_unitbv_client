import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senat_unit_bv/store/user_slice.dart';
import 'package:senat_unit_bv/theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController emailC;
  late TextEditingController passwordC;
  late bool isLoading;
  late bool hasError;

  @override
  void initState() {
    super.initState();
    emailC = TextEditingController();
    passwordC = TextEditingController();
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Vot Senat UnitBV",
                      style: Theme.of(context).textTheme.headline6,
                    ),
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
                      ],
                    ),
                  ),
                ),
                if (hasError) ...[
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 32,
                    child: Text(
                      "Emailul sau parola sunt incorecte",
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
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () => _handleLogin(),
                        child: const Text("Conectare"),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil("/register", (_) => false),
                        child: const Text("Inregistrare"),
                      ),
                    ],
                  )
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

  void _handleLogin() async {
    setState(() {
      isLoading = true;
      hasError = false;
    });
    bool loggedInWithSuccess = await Provider.of<UserSlice>(context, listen: false).logIn(email: emailC.text, password: passwordC.text);
    setState(() => isLoading = false);
    if (loggedInWithSuccess) {
      if (!mounted) return;

      Navigator.of(context).pushNamedAndRemoveUntil("/main", (_) => false);
      return;
    }

    setState(() => hasError = true);
  }
}
