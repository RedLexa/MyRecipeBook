import 'package:my_recipe_book/views/register_screen.dart';

import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'package:provider/provider.dart';
import '../services/api_service.dart';
import '../view_models/login_view_model.dart';

class LoginScreen extends StatefulWidget {
	const LoginScreen({Key? key}) : super(key: key);

	@override
	State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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

  Future<void> _login(LoginViewModel viewModel) async {
	if (_formKey.currentState?.validate() ?? false) {
	  final success = await viewModel.login(
		_usernameController.text,
		_passwordController.text,
	  );
	  if (success && mounted) {
		Navigator.of(context).pushReplacement(
		  MaterialPageRoute(builder: (context) => const HomeScreen()),
		);
	  }
	}
  }

	@override
	Widget build(BuildContext context) {
		return ChangeNotifierProvider<LoginViewModel>(
			create: (context) => LoginViewModel(Provider.of<ApiService>(context, listen: false)),
			child: Consumer<LoginViewModel>(
				builder: (context, viewModel, _) {
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
											if (viewModel.errorMessage != null)
												Padding(
													padding: const EdgeInsets.only(bottom: 12),
													child: Text(
														viewModel.errorMessage!,
														style: const TextStyle(color: Colors.red),
													),
												),
											SizedBox(
												width: double.infinity,
												child: ElevatedButton(
													onPressed: (viewModel.isLoading || !_canSubmit)
															? null
															: () => _login(viewModel),
													style: ElevatedButton.styleFrom(
														backgroundColor: _canSubmit
																? Colors.blue
																: Theme.of(context).disabledColor,
													),
													child: viewModel.isLoading
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
				},
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
