import 'package:flutter/material.dart';


class CustomerServicePage extends StatefulWidget {
  const CustomerServicePage({Key? key}) : super(key: key);

  @override
  _CustomerServicePageState createState() => _CustomerServicePageState();
}

class _CustomerServicePageState extends State<CustomerServicePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  bool _isSubmitting = false;
  bool _isFormVisible = false; // 폼의 표시 여부
  List<Map<String, String>> _submittedRequests = []; // 저장된 문의 목록

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });

      // 문의 내용을 저장
      Map<String, String> request = {
        'name': _nameController.text,
        'email': _emailController.text,
        'message': _messageController.text,
      };

      // 여기서 실제로 API에 데이터를 보내는 코드가 들어갈 수 있음

      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isSubmitting = false;
          _submittedRequests.add(request); // 문의를 저장 리스트에 추가
          _isFormVisible = false; // 폼 닫기
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('문의가 접수되었습니다.')),
        );

        // 폼 초기화
        _nameController.clear();
        _emailController.clear();
        _messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('고객센터 문의'),
        backgroundColor: const Color(0xFF009223),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '문의 내역',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // 문의 내역 리스트 (폼이 숨겨진 상태에서만 보이도록 함)
              if (!_isFormVisible) ...[
                // 문의 내역이 없을 경우 메시지 표시
                if (_submittedRequests.isEmpty) ...[
                  const Center(
                    child: Text(
                      '문의내역이 없습니다.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],

                ListView.builder(
                  shrinkWrap: true,
                  itemCount: _submittedRequests.length,
                  itemBuilder: (context, index) {
                    final request = _submittedRequests[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        title: Text(request['name'] ?? '이름 없음'),
                        subtitle: Text('문의 내용: ${request['message']}'),
                        onTap: () {
                          // 클릭 시 상세 페이지로 이동
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  InquiryDetailPage(request: request),
                            ),
                          );
                        },
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              _submittedRequests.removeAt(index);
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
              ],

              // 문의 작성란 (폼이 보이는 상태에서만 보이도록 함)
              if (_isFormVisible) ...[
                const Text(
                  '새로운 문의 작성',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: '이름',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '이름을 입력해 주세요.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: '이메일',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '이메일을 입력해 주세요.';
                          } else if (!RegExp(
                                  r"^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                            return '유효한 이메일을 입력해 주세요.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _messageController,
                        decoration: const InputDecoration(
                          labelText: '문의 내용',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 6,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '문의 내용을 입력해 주세요.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      _isSubmitting
                          ? const Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                              onPressed: _submitForm,
                              child: const Text('문의하기'),
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                backgroundColor: const Color(0xFF7DD4A6),
                                textStyle: const TextStyle(fontSize: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isFormVisible = !_isFormVisible; // 폼 보이기/숨기기
          });
        },
        child: Icon(_isFormVisible ? Icons.close : Icons.add),
        backgroundColor: const Color(0xFF009223),
      ),
    );
  }
}

class InquiryDetailPage extends StatelessWidget {
  final Map<String, String> request;

  const InquiryDetailPage({Key? key, required this.request}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('문의 상세'),
        backgroundColor: const Color(0xFF009223),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '문의 내용',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              '이름: ${request['name']}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              '이메일: ${request['email']}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              '문의 내용: ',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              request['message'] ?? '문의 내용이 없습니다.',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
