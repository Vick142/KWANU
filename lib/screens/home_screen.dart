import 'package:flutter/material.dart';

class KwanuHomeScreen extends StatefulWidget {
  const KwanuHomeScreen({super.key});

  @override
  State<KwanuHomeScreen> createState() => _KwanuHomeScreenState();
}

class _KwanuHomeScreenState extends State<KwanuHomeScreen> {
  // Toggle for form visibility
  bool _showSignUpForm = false;
  bool _showLoginForm = false;

  // Separate form keys for signup and login
  final _signUpFormKey = GlobalKey<FormState>();
  final _loginFormKey = GlobalKey<FormState>();

  // Form controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Login controllers
  final _loginIdentifierController = TextEditingController(); // email or phone
  final _loginPasswordController = TextEditingController();

  // Password visibility toggles
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoginPasswordVisible = false;

  // Color palette
  static const Color overlayColor = Color(0xB22C1A0F);
  static const Color accentOrange = Color(0xFFE67E22);
  static const Color primaryText = Color(0xFFFFF5E6);
  static const Color secondaryText = Color(0xCCFFF5E6);

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _loginIdentifierController.dispose();
    _loginPasswordController.dispose();
    super.dispose();
  }

  // Submit handlers: validate then navigate to houses list
  void _submitSignUpForm() {
    if (_signUpFormKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account created!')),
      );
      Navigator.pushReplacementNamed(context, '/houses');
    }
  }

  void _submitLoginForm() {
    if (_loginFormKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logging in...')),
      );
      Navigator.pushReplacementNamed(context, '/houses');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bottomInset = MediaQuery.of(context).padding.bottom;
    final viewInsetsBottom = MediaQuery.of(context).viewInsets.bottom;

    // Responsive sizes
    final titleFontSize = size.width * 0.12;
    final taglineFontSize = size.width * 0.045;
    final buttonFontSize = size.width * 0.045;
    final loginFontSize = size.width * 0.035;

    final buttonWidth = (size.width * 0.8).clamp(240.0, 360.0);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/background/background.jpg',
            fit: BoxFit.cover,
          ),
          Container(color: overlayColor),

          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: EdgeInsets.only(
                    left: 24,
                    right: 24,
                    top: 32,
                    bottom: 16 + viewInsetsBottom,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight - 48,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/logo/logo.png',
                              height: 90,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(height: 28),
                            Text(
                              'Kwanu',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: titleFontSize,
                                fontWeight: FontWeight.w800,
                                color: primaryText,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Stay Where Your Heart\nFeels Home.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: taglineFontSize,
                                fontWeight: FontWeight.w300,
                                color: secondaryText,
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 32),

                            // Centre: either signup form or login form or nothing
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 180),
                              transitionBuilder: (child, animation) =>
                                  FadeTransition(opacity: animation, child: child),
                              child: _showSignUpForm
                                  ? _buildSignUpFormContainer()
                                  : _showLoginForm
                                      ? _buildLoginFormContainer()
                                      : const SizedBox.shrink(),
                            ),
                          ],
                        ),

                        SafeArea(
                          top: false,
                          minimum: EdgeInsets.only(
                            bottom: bottomInset > 0 ? 16 : 24,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (!_showSignUpForm && !_showLoginForm) ...[
                                SizedBox(
                                  width: buttonWidth,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        _showSignUpForm = true;
                                        _showLoginForm = false;
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: accentOrange,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 16,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      elevation: 8,
                                      shadowColor:
                                          Colors.black.withValues(alpha: 0.3),
                                      textStyle: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: buttonFontSize,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    child: const Text('Get Started'),
                                  ),
                                ),
                                const SizedBox(height: 12),

                                // Landing bottom text: go to login form
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _showLoginForm = true;
                                      _showSignUpForm = false;
                                    });
                                  },
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: loginFontSize,
                                        color: secondaryText,
                                      ),
                                      children: [
                                        const TextSpan(
                                            text:
                                                'Already have an account? '),
                                        TextSpan(
                                          text: 'Log in',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: accentOrange,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ]
                              else if (_showSignUpForm && !_showLoginForm) ...[
                                // When on signup form, offer switch to login
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _showLoginForm = true;
                                      _showSignUpForm = false;
                                    });
                                  },
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: loginFontSize,
                                        color: secondaryText,
                                      ),
                                      children: [
                                        const TextSpan(
                                            text:
                                                'Already have an account? '),
                                        TextSpan(
                                          text: 'Log in',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: accentOrange,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ]
                              else if (_showLoginForm && !_showSignUpForm) ...[
                                // When on login form, offer switch back to signup
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _showSignUpForm = true;
                                      _showLoginForm = false;
                                    });
                                  },
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: loginFontSize,
                                        color: secondaryText,
                                      ),
                                      children: [
                                        const TextSpan(
                                            text:
                                                "Don't have an account? "),
                                        TextSpan(
                                          text: 'Sign up',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: accentOrange,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],

                              if (_showSignUpForm || _showLoginForm) ...[
                                const SizedBox(height: 8),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _showSignUpForm = false;
                                      _showLoginForm = false;
                                    });
                                  },
                                  child: Text(
                                    'Back',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: loginFontSize,
                                      color: secondaryText,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Glassmorphism signup form container
  Widget _buildSignUpFormContainer() {
    return Container(
      key: const ValueKey('signup_form'),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _signUpFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField(
                controller: _nameController,
                label: 'Full Name',
                // Clean Material user icon
                icon: Icons.person_rounded,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your name' : null,
              ),
              const SizedBox(height: 12),
              _buildTextField(
                controller: _emailController,
                label: 'Email Address',
                // Clean Material mail icon
                icon: Icons.alternate_email,
                validator: (value) {
                  if (value!.isEmpty) return 'Email is required';
                  final emailRegExp = RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  );
                  if (!emailRegExp.hasMatch(value)) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              _buildTextField(
                controller: _phoneController,
                label: 'Phone Number',
                // Clean Material phone icon
                icon: Icons.phone_iphone,
                keyboardType: TextInputType.phone,
                validator: (value) =>
                    value!.isEmpty ? 'Phone number is required' : null,
              ),
              const SizedBox(height: 12),
              _buildTextField(
                controller: _passwordController,
                label: 'Password',
                // Clean Material lock icon
                icon: Icons.lock_rounded,
                obscureText: !_isPasswordVisible,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.white70,
                  ),
                  onPressed: () => setState(
                      () => _isPasswordVisible = !_isPasswordVisible),
                ),
                validator: (value) {
                  final password = value ?? '';

                  if (password.isEmpty) {
                    return 'Password is required';
                  }

                  final List<String> errors = [];

                  if (password.length < 8) {
                    errors.add('• At least 8 characters');
                  }
                  if (!password.contains(RegExp(r'[A-Z]'))) {
                    errors.add('• At least one uppercase letter (A–Z)');
                  }
                  if (!password.contains(RegExp(r'[a-z]'))) {
                    errors.add('• At least one lowercase letter (a–z)');
                  }
                  if (!password.contains(RegExp(r'[0-9]'))) {
                    errors.add('• At least one number (0–9)');
                  }
                  if (!password
                      .contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'))) {
                    errors.add('• At least one special character (!@#\$%…)');
                  }

                  if (errors.isEmpty) {
                    return null;
                  }

                  return 'Password must include:\n${errors.join('\n')}';
                },
              ),
              const SizedBox(height: 12),
              _buildTextField(
                controller: _confirmPasswordController,
                label: 'Confirm Password',
                // Clean Material lock icon
                icon: Icons.lock_rounded,
                obscureText: !_isConfirmPasswordVisible,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isConfirmPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.white70,
                  ),
                  onPressed: () => setState(() =>
                      _isConfirmPasswordVisible =
                          !_isConfirmPasswordVisible),
                ),
                validator: (value) {
                  if (value!.isEmpty) return 'Please confirm password';
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitSignUpForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentOrange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Glassmorphism login form container (email/phone + password)
  Widget _buildLoginFormContainer() {
    return Container(
      key: const ValueKey('login_form'),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _loginFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField(
                controller: _loginIdentifierController,
                label: 'Email or Phone Number',
                // Clean Material user icon for identifier
                icon: Icons.person_rounded,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your email or phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              _buildTextField(
                controller: _loginPasswordController,
                label: 'Password',
                // Clean Material lock icon
                icon: Icons.lock_rounded,
                obscureText: !_isLoginPasswordVisible,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isLoginPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.white70,
                  ),
                  onPressed: () => setState(
                      () => _isLoginPasswordVisible = !_isLoginPasswordVisible),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitLoginForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentOrange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                child: const Text('Log In'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        prefixIcon: Icon(icon, color: Colors.white70),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFFE67E22),
            width: 1.5,
          ),
        ),
        errorStyle: const TextStyle(color: Colors.orangeAccent),
      ),
      validator: validator,
    );
  }
}
