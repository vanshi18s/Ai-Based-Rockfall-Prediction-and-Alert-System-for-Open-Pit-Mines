import 'package:flutter/material.dart';
import '../../widgets/app_Logo.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/loading_spinner.dart';
import '../../widgets/signup_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, this.showSignup = false});

  final bool showSignup;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  bool _isLogin = true;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _isLogin = !widget.showSignup;
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _confirmPasswordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _login() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isLoading = true);

    // Creative mock auth with animation delay
    await Future.delayed(const Duration(seconds: 1));

    final email = _emailController.text.trim();
    final password = _passwordController.text;
    if (email == 'demo@rockfall.com' && password == 'demo123') {
      setState(() => _isLoading = false);
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Invalid credentials. Try demo@rockfall.com / demo123'),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }

  void _demoLogin() {
    Navigator.pushReplacementNamed(context, '/home');
  }

  void _signup() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isLoading = true);

    // Creative mock signup with animation delay
    await Future.delayed(const Duration(seconds: 1));

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (password != confirmPassword) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Passwords do not match'),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }

    // Mock successful signup
    setState(() => _isLoading = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Account created successfully! Please login.'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
    setState(() => _isLogin = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/rockfall_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.6),
              BlendMode.darken,
            ),
          ),
        ),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: Card(
                  elevation: 12,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        colors: [Color.fromARGB(255, 64, 82, 127), Color.fromARGB(255, 68, 87, 106)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Form(
                        key: _formKey,
                        child: AnimatedCrossFade(
                          firstChild: _buildLoginForm(context),
                          secondChild: _buildSignupForm(context),
                          crossFadeState: _isLogin ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                          duration: const Duration(milliseconds: 500),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Hero(
          tag: "appLogo",
          child: const AppLogo(size: 100),
        ),
        const SizedBox(height: 20),
        Text(
          'Welcome Back',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[800],
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Sign in to continue',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.blueGrey[600],
              ),
        ),
        const SizedBox(height: 32),
        CustomTextField(
          label: 'Email',
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          validator: (v) {
            if (v == null || v.trim().isEmpty) return 'Enter email';
            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v.trim())) return 'Enter valid email';
            return null;
          },
          hintText: 'demo@rockfall.com',
        ),
        const SizedBox(height: 20),
        CustomTextField(
          label: 'Password',
          controller: _passwordController,
          obscureText: true,
          validator: (v) => (v == null || v.length < 4) ? 'Password too short' : null,
          hintText: 'demo123',
        ),
        const SizedBox(height: 32),
        _isLoading
            ? const LoadingSpinner()
            : Column(
                children: [
                  CustomButton(text: 'Login', onPressed: _login),
                  const SizedBox(height: 16),
                  CustomButton(text: 'Demo Login', onPressed: _demoLogin, isPrimary: false),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => const SignupDialog(),
                      );
                    },
                    child: const Text('Don\'t have an account? Sign Up'),
                  ),
                ],
              ),
        const SizedBox(height: 20),
        TextButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Forgot Password? Feature coming soon!')),
            );
          },
          child: const Text('Forgot Password?'),
        ),
      ],
    );
  }

  Widget _buildSignupForm(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Hero(
          tag: "appLogo",
          child: const AppLogo(size: 100),
        ),
        const SizedBox(height: 20),
        Text(
          'Create Account',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[800],
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Sign up to get started',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.blueGrey[600],
              ),
        ),
        const SizedBox(height: 32),
        CustomTextField(
          label: 'Name',
          controller: _nameController,
          validator: (v) {
            if (v == null || v.trim().isEmpty) return 'Enter name';
            return null;
          },
          hintText: 'John Doe',
        ),
        const SizedBox(height: 20),
        CustomTextField(
          label: 'Email',
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          validator: (v) {
            if (v == null || v.trim().isEmpty) return 'Enter email';
            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v.trim())) return 'Enter valid email';
            return null;
          },
          hintText: 'john@example.com',
        ),
        const SizedBox(height: 20),
        CustomTextField(
          label: 'Password',
          controller: _passwordController,
          obscureText: true,
          validator: (v) => (v == null || v.length < 4) ? 'Password too short' : null,
          hintText: 'password',
        ),
        const SizedBox(height: 20),
        CustomTextField(
          label: 'Confirm Password',
          controller: _confirmPasswordController,
          obscureText: true,
          validator: (v) {
            if (v == null || v.isEmpty) return 'Confirm password';
            if (v != _passwordController.text) return 'Passwords do not match';
            return null;
          },
          hintText: 'password',
        ),
        const SizedBox(height: 32),
        _isLoading
            ? const LoadingSpinner()
            : Column(
                children: [
                  CustomButton(text: 'Sign Up', onPressed: _signup),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = true;
                      });
                    },
                    child: const Text('Already have an account? Login'),
                  ),
                ],
              ),
      ],
    );
  }
}
