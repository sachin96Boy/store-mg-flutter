import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:store_mg_fl/common/components/snackbar.dart';

import 'package:store_mg_fl/features/auth/repository/auth_repository.dart';
import 'package:store_mg_fl/features/auth/services/auth_service.dart';
import 'package:store_mg_fl/features/products/views/products_screen.dart';

enum AuthMode { login, register }

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  static const routeName = '/auth';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();

  final scaffoleKey = GlobalKey<ScaffoldState>();

  var _username = '', _email = '', _password = '';

  bool isObscure = true;
  bool isLoading = false;

  var _authMode = AuthMode.register;

  void handleLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  void _redirect() {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        Navigator.of(context).pushReplacementNamed(ProductsScreen.routeName);
      },
    );
  }

  void _submitForm() {
    handleLoading();

    final validate = _formKey.currentState!.validate();

    if (!validate) {
      handleLoading();
      return;
    }

    _formKey.currentState!.save();

    final authService = AuthService(authRepository: AuthRepository());

    try {
      if (_authMode == AuthMode.register) {
        // Register
        authService
            .signUpWithEmailAndPassword(_email, _password, _username)
            .then(
          (value) {
            if (value.status == 'success') {
              CustomSnackBarBuilder.showSuccessSnackBar(
                'Registration Successful',
                context,
              );
              _redirect();
            } else {
              CustomSnackBarBuilder.showErroeSnackBar(
                value.message!,
                context,
              );
            }
          },
        );
      } else {
        // Login
        authService.signInWithEmailAndPassword(_email, _password).then((value) {
          if (value.status == 'success') {
            CustomSnackBarBuilder.showSuccessSnackBar(
              'Login Successful',
              context,
            );
            _redirect();
          } else {
            CustomSnackBarBuilder.showErroeSnackBar(
              value.message!,
              context,
            );
          }
        });
      }
    } catch (e) {
      print(e);
      CustomSnackBarBuilder.showErroeSnackBar(
        e.toString(),
        context,
      );
    } finally {
      _formKey.currentState!.reset();
      handleLoading();
    }

    // Navigator.of(context).pushNamed(OtpScreen.routeName);
  }

  void _switchAuthMode() {
    _formKey.currentState!.reset();
    if (_authMode == AuthMode.register) {
      setState(() {
        _authMode = AuthMode.login;
      });
    } else {
      setState(() {
        _authMode = AuthMode.register;
      });
    }
  }

  void _toggleObscure() {
    setState(() {
      isObscure = !isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoleKey,
      appBar: AppBar(
        title: const Text('Auth Screen'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                spacing: 20.0,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    _authMode == AuthMode.register ? 'Register' : 'Login',
                    style: ShadTheme.of(context).textTheme.h1Large,
                  ),
                  _authMode == AuthMode.register
                      ? TextFormField(
                          onSaved: (newValue) {
                            _username = newValue!;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'UserName',
                            hintText: 'Enter your username',
                            icon: Icon(
                              Icons.face,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : SizedBox(),
                  TextFormField(
                    onSaved: (newValue) {
                      _email = newValue!;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (value.contains('@') == false) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      icon: Icon(
                        Icons.email,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  TextFormField(
                    onSaved: (newValue) {
                      _password = newValue!;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Passwod',
                      hintText: 'Enter your password',
                      icon: Icon(
                        Icons.lock,
                        color: Colors.grey,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: _toggleObscure,
                        child: Icon(
                          isObscure ? Icons.visibility : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    obscureText: isObscure,
                  ),
                  Column(
                    children: [
                      isLoading
                          ? CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(
                                ShadTheme.of(context).colorScheme.secondary,
                              ),
                            )
                          : ElevatedButton(
                              onPressed: _submitForm,
                              style: ElevatedButton.styleFrom(
                                elevation: 8.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                  vertical: 10.0,
                                ),
                                backgroundColor: _authMode == AuthMode.register
                                    ? ShadTheme.of(context)
                                        .colorScheme
                                        .secondary
                                    : ShadTheme.of(context).colorScheme.primary,
                              ),
                              child: Text(
                                _authMode == AuthMode.register
                                    ? 'Register'
                                    : 'Login',
                                style: ShadTheme.of(context).textTheme.h3,
                              ),
                            ),
                      TextButton(
                        onPressed: _switchAuthMode,
                        child: Text(
                          _authMode == AuthMode.register
                              ? 'Already Registeded? Log In'
                              : 'New User? Register',
                          style: ShadTheme.of(context).textTheme.h3.copyWith(
                                color: _authMode == AuthMode.login
                                    ? ShadTheme.of(context)
                                        .colorScheme
                                        .secondary
                                    : ShadTheme.of(context).colorScheme.primary,
                              ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
