import 'package:flutter/material.dart';

class FindPasswordPage extends StatefulWidget {
  const FindPasswordPage({super.key});

  @override
  _FindPasswordPageState createState() => _FindPasswordPageState();
}

class _FindPasswordPageState extends State<FindPasswordPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // 비밀번호 재설정 요청을 모의 처리하는 함수
  void _sendPasswordResetRequest(String id, String email) {
    // 모의 비밀번호 재설정 요청 처리
    Future.delayed(const Duration(seconds: 2), () {
      // 테스트용으로 아이디와 이메일이 일치하는지 확인
      if (id == "test_id" && email == "test@example.com") {
        _showSnackbar('이메일로 비밀번호 재설정 링크가 전송되었습니다.');
      } else {
        _showSnackbar('아이디 또는 이메일이 잘못되었습니다.');
      }
    });
  }

  // 스낵바로 메시지 표시하는 함수
  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('비밀번호 찾기')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '아이디와 등록된 이메일을 입력하세요.\n이메일로 비밀번호 재설정 링크가 전송됩니다.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _idController,
              decoration: InputDecoration(
                hintText: '아이디를 입력하세요',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
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
                String id = _idController.text.trim();
                String email = _emailController.text.trim();
                if (id.isNotEmpty && email.isNotEmpty) {
                  _sendPasswordResetRequest(id, email); // 비밀번호 재설정 요청
                } else {
                  _showSnackbar('아이디와 이메일을 모두 입력하세요.');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('비밀번호 재설정 요청', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
