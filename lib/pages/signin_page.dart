// import 'package:adopt_app/main.dart';
import 'package:adopt_app/models/user.dart';
import 'package:adopt_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
// import 'package:adopt_app/services/pets.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class SigninPage extends StatelessWidget {
  SigninPage({Key? key}) : super(key: key);
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign in"),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text("Sign In"),
            TextField(
              decoration: const InputDecoration(hintText: 'Username'),
              controller: usernameController,
            ),
            TextField(
              decoration: const InputDecoration(hintText: 'Password'),
              controller: passwordController,
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () async {
                // var name = "Khaled";
                // define shared
                //     SharedPreferences prefs = await SharedPreferences.getInstance();

                // // writet his value to sp
                //        prefs.setString('Khaled', khaled);
                // // read the same value
                //       context.read<AuthProvider>
                // // print
                //       print(khaled)

                // return;
                var result =
                    await Provider.of<AuthProvider>(context, listen: false)
                        .signin(
                            user: User(
                                username: usernameController.text,
                                password: passwordController.text));
                // context.pop();
                if (result) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("You are Signin")));
                  context.push('/');
                }
              },
              child: const Text("Sign In"),
            )
          ],
        ),
      ),
    );
  }
}
