import 'package:admin_panel/screens/layouts/headers/controller/header_controller.dart';
import 'package:admin_panel/util/constants/colors.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/helpers/helpers_function.dart';
import 'package:admin_panel/util/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TLoginForm extends StatefulWidget {
  const TLoginForm({super.key});

  @override
  State<TLoginForm> createState() => _TLoginFormState();
}

class _TLoginFormState extends State<TLoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

Future<void> _signIn() async {
  setState(() => _isLoading = true);
  final email = _emailController.text.trim();
  final password = _passwordController.text;

  try {
    // 1. Check if user exists in dashboard_users
    final dashboardUser = await Supabase.instance.client
        .from('dashboard_users')
        .select()
        .eq('email', email)
        .eq('password', password) // Assuming plaintext/hashes match
        .maybeSingle();

    if (dashboardUser == null) {
      Get.snackbar('Login Failed', 'Account not registered in dashboard_users');
      return;
    }

    final bool isSignedIn = dashboardUser['signed_in'] ?? false;

    if (isSignedIn) {
      await _performSupabaseLogin(email, password);
    } else {
      await _performSupabaseSignup(email, password);
    }

    if (Get.isRegistered<HeaderController>()) Get.delete<HeaderController>();
    Get.put(HeaderController());
    Get.offAllNamed(TRoutes.dashboard,);
    final storage = GetStorage();
    storage.write('email', Supabase.instance.client.auth.currentUser!.email.toString());
  } catch (e) {
    Get.snackbar('Error', e.toString(), backgroundColor: Colors.red, colorText: Colors.white);
    print('❌ Error in _signIn: $e');
  } finally {
    if (mounted) setState(() => _isLoading = false);
  }
}

Future<void> _performSupabaseLogin(String email, String password) async {
  try {
    final loginResponse = await Supabase.instance.client.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (loginResponse.user != null) {
      await Supabase.instance.client
          .from('dashboard_users')
          .update({'auth_id': loginResponse.user!.id})
          .eq('email', email);

      print('🟢 Supabase login success');
    } else {
      Get.snackbar('Login Failed', 'Invalid Supabase credentials');
      throw Exception('Login failed');
    }
  } catch (e) {
    rethrow;
  }
}

Future<void> _performSupabaseSignup(String email, String password) async {
  try {
    final signUpResponse = await Supabase.instance.client.auth.signUp(
      email: email,
      password: password,
    );

    if (signUpResponse.user != null) {
      await Supabase.instance.client
          .from('dashboard_users')
          .update({
            'signed_in': true,
            'auth_id': signUpResponse.user!.id,
          })
          .eq('email', email);

      print('🟢 Supabase signup success & signed_in updated');
    } else {
      Get.snackbar('Signup Failed', 'Failed to create Supabase account');
      throw Exception('Signup failed');
    }
  } catch (e) {
    // If already registered, fallback to login
    if (e.toString().contains('user_already_exists')) {
      print('🟡 User already exists, attempting login');
      await _performSupabaseLogin(email, password);
    } else {
      rethrow;
    }
  }
}


  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBetwwenSections),
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              decoration:  InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: 'Email',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(color: dark ? Colors.grey.withOpacity(0.5) : TColors.dark.withOpacity(0.2)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(color: dark ? Colors.white.withOpacity(1) : TColors.dark.withOpacity(1)),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
              validator: (value) => value!.isEmpty ? 'Enter email' : null,
            ),
            const SizedBox(height: TSizes.spaceBetweenInputFields),

            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration:  InputDecoration(
                prefixIcon: Icon(Iconsax.password_check),
                labelText: 'Password',
                 enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(color: dark ? Colors.grey.withOpacity(0.5) : TColors.dark.withOpacity(0.2)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(color: dark ? Colors.white.withOpacity(1) : TColors.dark.withOpacity(1)),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
              validator: (value) => value!.isEmpty ? 'Enter password' : null,
            ),
            const SizedBox(height: TSizes.spaceBetweenInputFields / 2),

            
            const SizedBox(height: TSizes.spaceBetwwenSections),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : () {
                  if (_formKey.currentState!.validate()) {
                    _signIn();
                  }
                },
                child: _isLoading ? CircularProgressIndicator() : const Text('Sign In'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
