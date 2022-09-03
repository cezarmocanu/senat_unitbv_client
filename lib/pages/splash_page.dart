import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senat_unit_bv/store/user_slice.dart';

class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      bool isAuth = await Provider.of<UserSlice>(context, listen: false).checkAuth();
      if (!mounted) return;

      if (isAuth) {
        Navigator.of(context).pushNamedAndRemoveUntil("/main", (_) => false);
        return;
      }

      Navigator.of(context).pushNamedAndRemoveUntil("/login", (_) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Senat UNITBV",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
            const Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
