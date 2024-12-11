import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/views/profile_edit.dart';
import 'package:flutter_application_2/data/pets.dart';
import 'login.dart'; // 로그인 페이지
import '../views/post_storage.dart'; // 게시글 보관함 페이지
import '../views/customer.dart'; // 고객센터 페이지
import 'post.dart'; // 게시글 페이지
import '../views/profile_edit.dart';

class Profile extends StatefulWidget {
  final String? token;

  const Profile({Key? key, this.token}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool showDetail = false; // 상세 보기 여부
  Map<String, dynamic>? selectedPet; // 선택된 반려동물 정보

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0x44009223),
        title: Text(
          showDetail ? '상세보기' : '마이페이지',
          style: const TextStyle(color: Colors.black),
        ),
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            if (showDetail) {
              setState(() {
                showDetail = false;
              });
            } else {
              Navigator.pop(context);
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (route) => false,
              );
            },
            child: const Text('로그아웃', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
      body: showDetail ? _buildDetailView() : _buildProfileView(),
    );
  }

  Widget _buildProfileView() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // 사용자 정보 섹션
        _buildUserInfo(),
        const SizedBox(height: 20),
        // 버튼 섹션
        _buildButtons(),
        const SizedBox(height: 20),
        const Text(
          'WE PET',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
        ),
        const SizedBox(height: 10),
        // 반려동물 목록
        ...pets.map(_buildPetTile).toList(),
      ],
    );
  }

  Widget _buildUserInfo() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage('assets/profile_image.png'),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('나섬이 반려인 WELCOME!',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileEdit(
                      title: '',
                      content: '',
                    ),
                  ),
                );
              },
              child: Text(
                '나섬이   MY 계정관리',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _ProfileButton(
          icon: Icons.bookmark,
          label: '게시글 보관함',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PostStoragePage(),
              ),
            );
          },
        ),
        _ProfileButton(
          icon: Icons.headset_mic,
          label: '고객센터',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CustomerServicePage(),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildPetTile(Map<String, dynamic> pet) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPet = pet;
          showDetail = true;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 이미지를 컨테이너 크기 설정
            Container(
              width: double.infinity,
              height: 180, // 고정된 높이 설정
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(pet['imageUrl']),
                  fit: BoxFit.cover, // 이미지가 잘리지 않게
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(pet['profileImagePath']),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pet['title'],
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      pet['author'],
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              pet['content'],
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14, color: Colors.black),
            ),
            const SizedBox(height: 10),
            Text(
              '작성일: ${_formatDate(pet['createdAt'])}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.favorite, size: 20, color: Colors.red),
                const SizedBox(width: 8),
                Text('${pet['likes']} Likes'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '날짜 없음'; // 날짜가 없으면 '날짜 없음'으로 표시
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour}:${date.minute.toString().padLeft(2, '0')}";
  }

  Widget _buildDetailView() {
    if (selectedPet == null)
      return const SizedBox.shrink(); // 선택된 반려동물이 없으면 빈 공간 반환

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          // 프로필, 제목, 사용자 정보
          Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(selectedPet!['profileImagePath']),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    selectedPet!['title'],
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    selectedPet!['author'],
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () async {
                  final updatedData = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Post(
                        title: selectedPet!['title'],
                        content: selectedPet!['content'],
                      ),
                    ),
                  );
                  if (updatedData != null) {
                    setState(() {
                      selectedPet!['title'] = updatedData['title'];
                      selectedPet!['content'] = updatedData['content'];
                    });
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  bool? shouldDelete = await _showDeleteDialog();
                  if (shouldDelete == true) {
                    setState(() {
                      pets.removeWhere(
                          (pet) => pet['id'] == selectedPet!['id']);
                      showDetail = false;
                      selectedPet = null;
                    });
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 16),

          // 글 내용
          Text(
            selectedPet!['content'],
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),

          // 이미지
          if (selectedPet!['imageUrl'] != null &&
              selectedPet!['imageUrl'].isNotEmpty)
            Container(
              width: double.infinity,
              height: 200, // 고정된 높이로 설정
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(selectedPet!['imageUrl']),
                  fit: BoxFit.cover, // 이미지가 잘리지 않게
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),

          const SizedBox(height: 16),

          // 좋아요 및 스크랩 버튼
          Row(
            children: [
              IconButton(
                icon: Icon(
                  selectedPet!['isLiked']
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Colors.red,
                ),
                onPressed: () {
                  setState(() {
                    selectedPet!['isLiked'] = !selectedPet!['isLiked'];
                    selectedPet!['likes'] += selectedPet!['isLiked'] ? 1 : -1;
                  });
                },
              ),
              Text('${selectedPet!['likes']} Likes'),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }

  Future<bool?> _showDeleteDialog() async {
    return await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('삭제 확인'),
          content: const Text('이 반려동물 정보를 삭제하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false), // 취소
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true), // 삭제
              child: const Text('삭제'),
            ),
          ],
        );
      },
    );
  }
}

class _ProfileButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ProfileButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, size: 40, color: Colors.green),
          const SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }
}
