// 반려동물 정보
final List<Map<String, dynamic>> pets = [
  {
    'id': 1,
    'author': '나의 반려견',
    'title': '우리 강아지 귀여운거 봐봐',
    'content': '나 처음으로 강아지 키우는데 너무 귀엽지 않아?',
    'profileImagePath': 'https://via.placeholder.com/50',
    'imageUrl': 'https://via.placeholder.com/500',
    'likes': 45,
    'comments': [
      {'author': '유저1', 'content': '너무 귀여워요!'},
      {'author': '유저2', 'content': '정말 귀엽네요 ㅎㅎ'},
    ],
    'createdAt': DateTime.now().subtract(const Duration(hours: 2)),
    'isLiked': false,
    'isScraped': false,
  },
  {
    'id': 2,
    'author': '나의 반려견',
    'title': '우리 강아지 귀여운거 봐봐',
    'content': '나 처음으로 강아지 키우는데 너무 귀엽지 않아?',
    'profileImagePath': 'https://via.placeholder.com/50',
    'imageUrl': 'https://via.placeholder.com/500',
    'likes': 45,
    'comments': [
      {'author': '유저1', 'content': '너무 귀여워요!'},
      {'author': '유저2', 'content': '정말 귀엽네요 ㅎㅎ'},
    ],
    'createdAt': DateTime.now().subtract(const Duration(hours: 3)),
    'isLiked': false,
    'isScraped': false,
  },
];
