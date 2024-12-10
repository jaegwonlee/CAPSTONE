import 'package:flutter/material.dart';

class PostDetailPage extends StatefulWidget {
  final Map<String, dynamic> post;

  const PostDetailPage({Key? key, required this.post}) : super(key: key);

  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  late Map<String, dynamic> post;
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    post = Map<String, dynamic>.from(widget.post);
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _addComment(String content) {
    if (content.trim().isEmpty) return;

    setState(() {
      post['comments'].add({
        'author': '나섬이', // 현재 사용자 이름 또는 ID를 설정
        'content': content,
      });
    });

    _commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('게시글 상세'),
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 작성자 정보
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(post['profileUrl']),
                  radius: 20,
                ),
                const SizedBox(width: 10),
                Text(
                  post['author'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // 제목
            Text(
              post['title'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // 내용
            Text(
              post['content'],
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            // 이미지 (글 아래에 표시)
            if (post['imageUrl'] != null && post['imageUrl'].isNotEmpty)
              Image.network(post['imageUrl']),

            const SizedBox(height: 20),

            // 좋아요 및 스크랩 버튼
            Row(
              children: [
                IconButton(
                  icon: Icon(
                      post['isLiked'] ? Icons.favorite : Icons.favorite_border),
                  color: Colors.red,
                  onPressed: () {
                    setState(() {
                      post['isLiked'] = !post['isLiked'];
                      post['likes'] += post['isLiked'] ? 1 : -1;
                    });
                  },
                ),
                Text('${post['likes']} likes'),
                const SizedBox(width: 16),
                IconButton(
                  icon: Icon(post['isScraped']
                      ? Icons.bookmark
                      : Icons.bookmark_border),
                  onPressed: () {
                    setState(() {
                      post['isScraped'] = !post['isScraped'];
                    });
                  },
                ),
              ],
            ),

            const Divider(),
            const Text(
              '댓글',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            // 댓글 리스트
            Expanded(
              child: ListView.builder(
                itemCount: post['comments'].length,
                itemBuilder: (context, index) {
                  final comment = post['comments'][index];
                  return ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(post['profileUrl']),
                      radius: 18,
                    ),
                    title: Text(
                      comment['author'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(comment['content']),
                  );
                },
              ),
            ),

            const Divider(),

            // 댓글 입력 TextField
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: const InputDecoration(
                      hintText: '댓글을 입력하세요...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    _addComment(_commentController.text);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
