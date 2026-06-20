import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';
import '../utils/auth_utils.dart';
import '../components/tasty_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Create Account')),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(24.0),
            children: [
              const Text('Name', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              TastyTextField(
                hint: 'Full Name',
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                onSaved: (val) => _name = val!,
              ),
              const SizedBox(height: 16),
              TastyTextField(
                hint: 'Email',
                keyboardType: TextInputType.emailAddress,
                validator: (val) => val == null || !val.contains('@') ? 'Invalid email' : null,
                onSaved: (val) => _email = val!,
              ),
              const SizedBox(height: 16),
              TastyTextField(
                hint: 'Password',
                obscureText: true,
                validator: (val) => val == null || val.length < 4 ? 'Too short' : null,
                onSaved: (val) => _password = val!,
              ),
              const SizedBox(height: 32),
              SizedBox(
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      context.read<UserProvider>().addUser(
                        User(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          name: _name,
                          email: _email,
                          password: AuthUtils.hashPassword(_password),
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Account created! Awaiting admin approval.')));
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Register', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
