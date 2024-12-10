import 'package:flutter/material.dart';

class FindIdPage extends StatefulWidget {
  const FindIdPage({super.key});

  @override
  _FindIdPageState createState() => _FindIdPageState();
}

class _FindIdPageState extends State<FindIdPage> {
  final TextEditingController _emailController = TextEditingController();

  Future<void> _mockSendEmailVerification(String email) async {
    await Future.delayed(const Duration(seconds: 2)); // 서버 통신 대기 시간 모방

    // 간단한 이메일 검증
    if (email == "test@example.com") {
      _showSnackBar('이메일로 아이디가 전송되었습니다. (모의 동작)', Colors.green);
    } else {
      _showSnackBar('등록된 이메일이 아닙니다. (모의 동작)', Colors.red);
    }
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('아이디 찾기')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '등록된 이메일을 입력하세요. 이메일로 아이디가 전송됩니다.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: '이메일을 입력하세요',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String email = _emailController.text.trim();
                if (email.isNotEmpty) {
                  _mockSendEmailVerification(email); // 모의 이메일 인증 요청
                } else {
                  _showSnackBar('이메일을 입력하세요.', Colors.orange);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('이메일로 아이디 찾기', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
