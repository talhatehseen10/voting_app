import 'package:flutter/material.dart';
import 'package:voting/views/authentication/views/login_screen.dart';
import 'package:voting/widgets/custom_textfield_with_title.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register Candidate"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomTextfieldWithTitle(
                    hintText: "Name", isObscureText: false, title: ''),
                const CustomTextfieldWithTitle(
                    hintText: "Email", isObscureText: false, title: ''),
                const CustomTextfieldWithTitle(
                    hintText: "Mobile No", isObscureText: false, title: ''),
                const CustomTextfieldWithTitle(
                    hintText: "CNIC", isObscureText: false, title: ''),
                const CustomTextfieldWithTitle(
                    hintText: "Password", isObscureText: false, title: ''),
                const CustomTextfieldWithTitle(
                    hintText: "Date of Birth", isObscureText: false, title: ''),
                const CustomTextfieldWithTitle(
                    hintText: "Address", isObscureText: false, title: ''),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 60,
                  width: 250,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        backgroundColor: Colors.black,
                        elevation: 2),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
