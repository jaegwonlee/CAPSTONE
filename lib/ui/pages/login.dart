import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/pages/signup.dart'; // SignUpPage 임포트
import 'package:flutter_application_2/ui/views/id_find.dart'; // FindIdPage 임포트
import 'package:flutter_application_2/ui/views/pw_find.dart'; // FindPasswordPage 임포트
import 'package:flutter_application_2/ui/main_view.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        // 스크롤 가능하도록 추가
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20), // 위쪽 여백 추가
                Image.asset(
                  'assets/images/logo.png',
                  height: 300,
                ),
                const SizedBox(height: 50),
                TextField(
                  controller: _loginController,
                  decoration: InputDecoration(
                    hintText: 'email',
                    filled: true,
                    fillColor: Colors.grey[300],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: 'password',
                    filled: true,
                    fillColor: Colors.grey[300],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    String email = _loginController.text;
                    String password = _passwordController.text;

                    print('Email: $email');
                    print('Password: $password');

                    // 로그인 성공 후 HomePage로 이동
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainView(), // token에 email을 전달
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: const Text(
                    '로그인',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        // 아이디 찾기 페이지로 이동
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const FindIdPage(), // FindIdPage로 이동
                          ),
                        );
                      },
                      child: const Text(
                        '아이디 찾기',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      '/',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(width: 10),
                    TextButton(
                      onPressed: () {
                        // 비밀번호 찾기 페이지로 이동
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const FindPasswordPage(), // FindPasswordPage로 이동
                          ),
                        );
                      },
                      child: const Text(
                        '비밀번호 찾기',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50), // 상단과 구분을 위해 여백 추가
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpPage(),
                      ),
                    );
                  },
                  child: const Text(
                    '회원가입',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
