import 'package:my_recipe_book/views/register_screen.dart';

import 'package:flutter/material.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
	const LoginScreen({Key? key}) : super(key: key);

	@override
	State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
	final TextEditingController _usernameController = TextEditingController();
	final TextEditingController _passwordController = TextEditingController();
	final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
	bool _isLoading = false;
	String? _errorMessage;
	bool get _canSubmit =>
			_usernameController.text.isNotEmpty && _passwordController.text.isNotEmpty;
	@override
	void initState() {
		super.initState();
		_usernameController.addListener(_onFieldsChanged);
		_passwordController.addListener(_onFieldsChanged);
	}

	void _onFieldsChanged() {
		setState(() {});
	}

	void _login() async {
		setState(() {
			_errorMessage = null;
		});
		if (_formKey.currentState?.validate() ?? false) {
			setState(() {
				_isLoading = true;
			});
			await Future.delayed(const Duration(milliseconds: 500)); // Mock delay
			setState(() {
				_isLoading = false;
			});
			if (!mounted) return;
			Navigator.of(context).pushReplacement(
				MaterialPageRoute(builder: (context) => const HomeScreen()),
			);
		}
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: const Text('Login')),
			body: Center(
				child: SingleChildScrollView(
					padding: const EdgeInsets.all(24.0),
					child: Form(
						key: _formKey,
						child: Column(
							mainAxisSize: MainAxisSize.min,
							children: [
								// Logo
								Padding(
									padding: const EdgeInsets.only(bottom: 32.0),
									child: Text(
										'MyRecipeBook',
										style: TextStyle(
											fontSize: 32,
											fontWeight: FontWeight.bold,
											color: Theme.of(context).colorScheme.primary,
											letterSpacing: 1.5,
										),
									),
								),
								// ...existing form fields and button...
								TextFormField(
									controller: _usernameController,
									decoration: const InputDecoration(labelText: 'Username'),
									validator: (value) =>
											(value == null || value.isEmpty) ? 'Enter username' : null,
								),
								const SizedBox(height: 16),
								TextFormField(
									controller: _passwordController,
									decoration: const InputDecoration(labelText: 'Password'),
									obscureText: true,
									validator: (value) =>
											(value == null || value.isEmpty) ? 'Enter password' : null,
								),
								const SizedBox(height: 24),
								if (_errorMessage != null)
									Padding(
										padding: const EdgeInsets.only(bottom: 12),
										child: Text(
											_errorMessage!,
											style: const TextStyle(color: Colors.red),
										),
									),
								SizedBox(
									width: double.infinity,
									child: ElevatedButton(
										onPressed: (_isLoading || !_canSubmit) ? null : _login,
										style: ElevatedButton.styleFrom(
											backgroundColor: _canSubmit
													? Colors.blue
													: Theme.of(context).disabledColor,
										),
										child: _isLoading
												? const SizedBox(
														width: 20,
														height: 20,
														child: CircularProgressIndicator(strokeWidth: 2),
													)
												: const Text('Login'),
									),
								),
								const SizedBox(height: 16),
								TextButton(
									onPressed: () {
										Navigator.of(context).push(
											MaterialPageRoute(builder: (context) => const RegisterScreen()),
										);
									},
									child: const Text(
										"Don't have an account? Register here",
										style: TextStyle(fontSize: 16),
									),
								),
							],
						),
					),
				),
			),
		);
	}

	@override
	void dispose() {
		_usernameController.removeListener(_onFieldsChanged);
		_passwordController.removeListener(_onFieldsChanged);
		_usernameController.dispose();
		_passwordController.dispose();
		super.dispose();
	}
}
