import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voting/views/authentication/controllers/login_controller.dart';
import 'package:voting/widgets/custom_textfield_with_title.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  static const String routeName = "/login";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const Text(
                "Sign in to Continue",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextfieldWithTitle(
                hintText: "Email",
                controller: controller.emailController,
                title: "Email",
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Required";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextfieldWithTitle(
                hintText: "Password",
                isObscureText: true,
                controller: controller.passwordController,
                title: "Password",
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Required";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                  height: 45,
                  width: 250,
                  child: Obx(
                    () => controller.isLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                backgroundColor: Colors.black,
                                elevation: 2),
                            onPressed: () {
                              controller.userLogin();
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                  )),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Forgot Password?",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Create your Account?",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
