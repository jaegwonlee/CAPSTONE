//마이프로필 수정 페이지
import 'package:flutter/material.dart';

class ProfileEdit extends StatelessWidget {
  ProfileEdit({super.key, required this.title, required this.content});
  final String title;
  final String content;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // 뒤로가기
          },
        ),
        title: Text('MY 계정관리'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  SizedBox(
                    height: screenWidth * 0.25,
                    width: screenWidth * 0.25,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      child: Text(
                        '사진 수정',
                        style: TextStyle(color: Colors.blue),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.05),
                ],
              ),
            ),
            Divider(),
            _buildSectionTitle('계정 보안'),
            _buildAccountInfoItem(
                context, '아이디', 'asdfghj@pcu.ac.kr', '아이디 변경'),
            _buildAccountInfoItem(context, '전화번호', '010-0000-0000', '전화번호 변경'),
            _buildAccountInfoItem(context, '비밀번호 변경', '', '비밀번호 변경'),
            _buildAccountInfoItem(context, '이메일 변경', '', '이메일 변경'),
            Divider(),
            _buildSectionTitle('이용 안내'),
            _buildInfoItem('문의하기'),
            _buildInfoItem('공지사항'),
            _buildInfoItem('서비스 이용약관'),
            _buildInfoItem('개인정보 처리방침'),
            _buildInfoItem('청소년 보호정책'),
            _buildInfoItem('오픈소스 라이선스'),
            Divider(),
            _buildSectionTitle('기타'),
            _buildInfoItem('정보 동의 설정'),
            _buildInfoItem('회원 탈퇴'),
            _buildInfoItem('로그아웃', onTap: () => _logout(context)),
          ],
        ),
      ),
    );
  }

  // 섹션 제목
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  // 계정 정보 항목 (아이디, 전화번호 등)
  Widget _buildAccountInfoItem(
      BuildContext context, String title, String subtitle, String action) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      subtitle: subtitle.isNotEmpty ? Text(subtitle) : null,
      trailing: Icon(Icons.chevron_right),
      onTap: () {
        // 다이얼로그를 띄워서 값 수정할 수 있게 함
        _showEditDialog(context, title, subtitle, action);
      },
    );
  }

  // 일반 정보 항목 (문의하기 등)
  Widget _buildInfoItem(String title, {VoidCallback? onTap}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  // 다이얼로그 표시하여 항목을 수정
  void _showEditDialog(
      BuildContext context, String field, String currentValue, String action) {
    TextEditingController controller =
        TextEditingController(text: currentValue);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$action'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(labelText: field),
            keyboardType: field == '전화번호' || field == '비밀번호 변경'
                ? TextInputType.number
                : TextInputType.text,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () {
                // 사용자 입력을 처리하여 실제 값을 업데이트 할 수 있도록 함
                Navigator.of(context).pop();
                // 여기서 실제로 아이디, 전화번호, 비밀번호, 이메일을 업데이트 할 수 있음
                print('$field: ${controller.text}');
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }

  // 로그아웃 처리
  void _logout(BuildContext context) {
    // 로그아웃 로직을 여기에 추가 (예: 토큰 삭제, 로그인 페이지로 이동 등)
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('로그아웃'),
          content: Text('정말 로그아웃 하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () {
                // 실제 로그아웃 처리를 이곳에 구현
                // 예: 로그아웃 후 로그인 페이지로 이동
                Navigator.of(context).pop();
                print('로그아웃 완료');
                Navigator.pushReplacementNamed(
                    context, '/login'); // 이거 추가해서 로그아웃 가능
              },
              child: const Text('로그아웃'),
            ),
          ],
        );
      },
    );
  }
}
