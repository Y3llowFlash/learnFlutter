import '../services/auth_service.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {

  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _auth = AuthService();


  bool _isLogin = true;
  bool _loading = false;
  // ignore: unused_field
  String _message = '';

  String? _validateEmail(String? v) {
    if (v == null || v.trim().isEmpty) return 'Email is required';
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v)) return 'Enter a valid email';
    return null;
  }

  String? _validatePassword(String? v) {
    if (v == null || v.length < 6) return 'Min 6 characters';
    return null;
  }

  String _prettyError(Exception e) {
    final txt = e.toString();
    if (txt.contains('user-not-found')) return 'No user found for that email.';
    if (txt.contains('wrong-password')) return 'Wrong password.';
    if (txt.contains('email-already-in-use')) return 'Email already registered.';
    if (txt.contains('invalid-email')) return 'Invalid email address.';
    return txt;
  }

  Future<void> _submit() async{

    if(!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true ; 
      _message = '';
    });
    try{
      if (_isLogin) {
        await _auth.signIn(_email.text, _password.text);
      }else{
         await _auth.signUp(_email.text, _password.text);
      }

      if (!mounted) return;
      
    }on Exception catch(e){
      setState(() {
        _message = _prettyError(e);
      });
    }finally {
      if (mounted) setState(() => _loading = false);
    }

  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:  AppBar(title: Text(_isLogin ? 'Login' : 'Sign Up'),),
      body: Padding(
        
        padding: const EdgeInsets.all(24),
        child: Form(
          key:  _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _email,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.mail),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail,
                ),
                const SizedBox(height: 32,),
                TextFormField(
                  controller: _password,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                  validator: _validatePassword,
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _loading ? null : _submit,
                    child: _loading
                    ? const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: CircularProgressIndicator(),
                    )
                    : Text(_isLogin ? 'Login' : 'Sign up'),
                  ),
                ),
                TextButton(
                  onPressed: _loading
                    ? null
                    : () => setState(() => _isLogin = !_isLogin),  
                  child: Text(
                    _isLogin ? "Create an account" : "I Already have account"
                  ),
                ),

                if(_message.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top:8),
                    child: Text(
                      _message,
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )

              ],
            ),
          ),
        ),

      ),
    );
  }


}