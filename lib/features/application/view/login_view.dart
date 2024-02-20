import 'package:firebaseauthclean/features/application/bloc/authbloc/auth_bloc.dart';
import 'package:firebaseauthclean/features/application/services/colors.dart';
import 'package:firebaseauthclean/features/application/widgets/customtextformfiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class LoginPageWrapper extends StatelessWidget {
  const LoginPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authblocc = BlocProvider.of<AuthBloc>(context);
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthenticatedError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Invalid Email")));
        }
      },
      builder: (context, state) {
        return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
          if (state is AuthLoading) {
            return Center(
              child: Scaffold(
                body: Container(
                  child: Center(
                    child: Lottie.asset(
                        'assets/json/circular_prograss_indicator.json'),
                  ),
                ),
              ),
            );
          }

          if (state is Authenticated) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/home', (route) => false);
            });
          }

          return Scaffold(
              body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            height: double.infinity,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Login with Email",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                    controller: _emailController, hintText: "Enter Email"),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                    obscureText: true,
                    controller: _passwordController,
                    hintText: "Enter Password"),
                const SizedBox(
                  height: 20,
                ),
                InkResponse(
                  onTap: () {
                    authblocc.add(LoginEvent(
                        password: _passwordController.text.trim(),
                        email: _emailController.text.trim()));
                  },
                  child: Container(
                    height: 52,
                    width: 250,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColor.btnColor),
                    child: Center(
                      child: Text(
                        "Login",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "New here?",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        child: Text(
                          "Register",
                          style: Theme.of(context).textTheme.bodySmall,
                        ))
                  ],
                )
              ],
            ),
          ));
        });
      },
    );
  }
}
