// 반려동물 정보
final List<Map<String, dynamic>> pets = [
  {
    'id': 1,
    'author': '나의 반려견',
    'title': '우리 강아지 귀여운거 봐봐',
    'content': '윙크 하는 강아지 어떤데?',
    'profileImagePath':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRESQMNAFE8gcZBlZmbJgAf2CEcLvSKpQSvpQ&s',
    'imageUrl': 'https://blog.malcang.com/wp-content/uploads/2024/03/1-1.png',
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
    'title': '우리 고양이 귀여운거 봐봐',
    'content': '이게 바로 고양이 키우는 맛이지',
    'profileImagePath':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRESQMNAFE8gcZBlZmbJgAf2CEcLvSKpQSvpQ&s',
    'imageUrl':
        'https://www.palnews.co.kr/news/photo/201801/92969_25283_5321.jpg',
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
