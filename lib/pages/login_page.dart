import 'package:authentication/components/button.dart';
import 'package:authentication/components/square_tile.dart';
import 'package:authentication/components/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controller
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  // sign user method
  void signUserIn() async{
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
      },
    );

    // try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
      );
      // pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      Navigator.pop(context);
      // wrong email
      if (e.code == 'user-not-found') {
        // show error to user
        wrongEmailMessage();
      }
        // wrong password
      else if (e.code == 'wrong-password') {
        // show error to user
        wrongPasswordMessage();
      }
    }
  }

  // wrong email message popup
  void wrongEmailMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
        title: Text("Incorrect Email"),
      );
    },
    );
  }

  // wrong password message popup
  void wrongPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text("Incorrect Password"),);
      },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body:  SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50,),
              // logo
              const Icon(
                Icons.lock,
                size: 100,
              ),

              const SizedBox(height: 50,),

              // welcome back, we have missed you
              Text("Welcome back you\'ve been missed!",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),

              ),

              const SizedBox(height: 25,),

              // email text-field
               MyTextField(
                 controller: emailController,
                 hintText: "Email",
                 obscureText: false,
               ),

              const SizedBox(height: 10,),

              // password text-field
               MyTextField(
                 controller: passwordController,
                 hintText: "Password",
                 obscureText: true,
               ),

              const SizedBox(height: 10,),

              // forgot password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10,),

              // signing button
              MyButton(
                onTap: signUserIn,
              ),

              const SizedBox(height: 50,),

              // or continue with
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        "Or continue with",
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    ),

                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50,),

              // google + apple signing button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // google logo
                  SquareTile(imagePath: 'lib/images/gg.png'),

                  const SizedBox(width: 25,),
                  // apple logo
                  SquareTile(imagePath: 'lib/images/ap.png'),
                ],
              ),

              const SizedBox(height: 50,),

              // not a member register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Not a member?",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                    ),
                  ),
                   const SizedBox(width: 5,),
                  const Text(
                    "Register now",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
