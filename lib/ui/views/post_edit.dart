import 'package:flutter/material.dart';

class PostEdit extends StatefulWidget {
  @override
  _PostEditState createState() => _PostEditState();
}

class _PostEditState extends State<PostEdit> {
  // 게시글 목록을 예시로 정의
  List<Map<String, String>> posts = [
    {'title': '첫 번째 게시글', 'content': '이것은 첫 번째 게시글입니다.'},
    {'title': '두 번째 게시글', 'content': '이것은 두 번째 게시글입니다.'},
    {'title': '세 번째 게시글', 'content': '이것은 세 번째 게시글입니다.'},
  ];

  // 게시글 수정
  void _editPost(int index) {
    TextEditingController titleController =
        TextEditingController(text: posts[index]['title']);
    TextEditingController contentController =
        TextEditingController(text: posts[index]['content']);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('게시글 수정'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: '제목'),
              ),
              TextField(
                controller: contentController,
                decoration: InputDecoration(labelText: '내용'),
              ),
            ],
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
                setState(() {
                  posts[index] = {
                    'title': titleController.text,
                    'content': contentController.text,
                  };
                });
                Navigator.of(context).pop();
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }

  // 게시글 삭제
  void _deletePost(int index) {
    setState(() {
      posts.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('내 게시글 관리')),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(posts[index]['title']!),
            subtitle: Text(posts[index]['content']!),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _editPost(index),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _deletePost(index),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
