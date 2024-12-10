import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostStoragePage extends StatefulWidget {
  const PostStoragePage({Key? key}) : super(key: key);

  @override
  _PostStoragePageState createState() => _PostStoragePageState();
}

class _PostStoragePageState extends State<PostStoragePage> {
  final List<Map<String, dynamic>> _storedPosts = [
    {
      'id': 1,
      'author': '나의 반려견',
      'title': '우리 강아지 귀여운거 봐봐',
      'content': '나 처음으로 강아지 키우는데 너무 귀엽지 않아?',
      'profileUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRESQMNAFE8gcZBlZmbJgAf2CEcLvSKpQSvpQ&s',
      'imageUrl':
          'https://image.dongascience.com/Photo/2020/03/5bddba7b6574b95d37b6079c199d7101.jpg',
      'likes': 45,
      'comments': [
        {'author': '유저1', 'content': '너무 귀여워요!'},
        {'author': '유저2', 'content': '정말 귀엽네요 ㅎㅎ'},
      ],
      'createdAt': DateTime.now().subtract(const Duration(hours: 2)),
      'isLiked': false,
      'isScraped': true,
    },
    // 추가 게시글
  ];

  void _navigateToPostDetail(Map<String, dynamic> post) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PostDetailPage(
          post: post,
          onPostUpdate: (updatedPost) {
            setState(() {
              final index =
                  _storedPosts.indexWhere((p) => p['id'] == updatedPost['id']);
              if (index != -1) {
                _storedPosts[index] = updatedPost;
              }
            });
          },
        ),
      ),
    );
  }

  Future<void> _confirmScrapRemoval(int index) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('스크랩 취소'),
        content: const Text('스크랩을 취소하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Yes'),
          ),
        ],
      ),
    );

    if (result == true) {
      setState(() {
        _storedPosts.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('게시글 보관함'),
      ),
      body: _storedPosts.isEmpty
          ? const Center(
              child: Text('보관된 게시글이 없습니다.'),
            )
          : ListView.builder(
              itemCount: _storedPosts.length,
              itemBuilder: (context, index) {
                final post = _storedPosts[index];
                return GestureDetector(
                  onTap: () => _navigateToPostDetail(post),
                  child: Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Container(
                      height: 70,
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(post['profileUrl']),
                            radius: 25,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  post['title'],
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  post['content'],
                                  style: const TextStyle(fontSize: 12),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Image.network(
                              post['imageUrl'],
                              width: 55,
                              height: 55,
                              fit: BoxFit.cover,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              post['isScraped']
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                            ),
                            onPressed: () => _confirmScrapRemoval(index),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class PostDetailPage extends StatefulWidget {
  final Map<String, dynamic> post;
  final Function(Map<String, dynamic>) onPostUpdate;

  const PostDetailPage(
      {Key? key, required this.post, required this.onPostUpdate})
      : super(key: key);

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
        'author': '나섬이', // 현재 사용자 이름 또는 ID를 여기 설정
        'content': content,
      });
    });

    _commentController.clear();
    widget.onPostUpdate(post);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('게시글 상세'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(post['profileUrl']),
                  radius: 25,
                ),
                const SizedBox(width: 12),
                Text(
                  post['author'],
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Image.network(
              post['imageUrl'],
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(
              post['title'],
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(post['content']),
            const SizedBox(height: 16),
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
                    widget.onPostUpdate(post);
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
                    widget.onPostUpdate(post);
                  },
                ),
              ],
            ),
            const Divider(),
            const Text(
              '댓글',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: post['comments'].length,
                itemBuilder: (context, index) {
                  final comment = post['comments'][index];
                  return ListTile(
                    title: Text(comment['author']),
                    subtitle: Text(comment['content']),
                  );
                },
              ),
            ),
            const Divider(),
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
