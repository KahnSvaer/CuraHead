import 'package:curahead_app/pages/auth/auth_landing.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state_management/auth_provider.dart';
import '../../controllers/navigation_controller.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> registerUser() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    try {
      await authProvider.registerWithEmail(
        _emailController.text,
        _passwordController.text,
        _displayNameController.text,
      );
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Registration successful!')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registration failed: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImage(),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 100), // Space from the top
                Image.asset(
                  'assets/images/SplashScreen.png', // Path to your logo
                  width: 100, // Adjust the width as needed
                  height: 100, // Adjust the height as needed
                ),
                const SizedBox(height: 20), // Space between logo and title
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    margin: const EdgeInsets.symmetric(horizontal: 24.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Sign Up', // Fixed sign-in method
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),

                        // Name Field in a Container
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: TextField(
                            controller: _displayNameController,
                            decoration: const InputDecoration(
                              labelText: 'Name',
                              border: InputBorder.none,
                            ),
                          ),
                        ),

                        // Email Field in a Container
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: TextField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),

                        // Password Field in a Container
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: PasswordField(controller: _passwordController),
                        ),

                        const SizedBox(height: 20),
                        RegisterButton(onPressed: registerUser),
                        const SizedBox(height: 20),
                        const Divider(thickness: 1.5),
                        const OldUserLoginLink(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const BackButtonIcon(),
        ],
      ),
    );
  }
}

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class PasswordField extends StatelessWidget {
  final TextEditingController controller;

  const PasswordField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'Password',
        border: InputBorder.none, // No border inside the container
      ),
      obscureText: true,
    );
  }
}

class RegisterButton extends StatelessWidget {
  final VoidCallback onPressed;

  const RegisterButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const Text('Register'),
    );
  }
}

class OldUserLoginLink extends StatelessWidget {
  const OldUserLoginLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Already have an account?'),
        TextButton(
          onPressed: () {
            NavigationController.pushAndPopUntilRoot(context, AuthLandingPage());
          },
          child: const Text('Login'),
        ),
      ],
    );
  }
}

class BackButtonIcon extends StatelessWidget {
  const BackButtonIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40,
      left: 16,
      child: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
