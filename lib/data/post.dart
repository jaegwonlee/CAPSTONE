List<Map<String, dynamic>> posts = [
  {
    'id': 1,
    'author': '옆집 뽀삐 재궈니',
    'title': '강아지가 너무 꼬질꼬질해',
    'content': '나 처음으로 강아지 키우는데 엄청 꼬질꼬질해,,먼가 꼬질이 같아서 더귀여운거 같아',
    'profileUrl':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRESQMNAFE8gcZBlZmbJgAf2CEcLvSKpQSvpQ&s',
    'image': 'assets/images/product8.png',
    'likes': 1,
    'comments': [],
    'createdAt': DateTime.now().subtract(const Duration(hours: 2)),
    'isLiked': false, // 좋아요 상태 추가
    'isScraped': false, // 스크랩 상태 추가
  },
  {
    'id': 2,
    'author': '우리집 떵개 후니',
    'title': '우리집 강아지 키 180임ㅋㅋ',
    'content': '우리집 강아지 대형견이라서 위로 점프하면 나랑 키가 거의 비슷함 ㄷㄷ',
    'profileUrl':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRESQMNAFE8gcZBlZmbJgAf2CEcLvSKpQSvpQ&s',
    'image': 'assets/images/product8.png',
    'likes': 306,
    'comments': [],
    'createdAt': DateTime.now().subtract(const Duration(hours: 2)),
    'isLiked': false, // 좋아요 상태 추가
    'isScraped': false, // 스크랩 상태 추가
  },
  {
    'id': 3,
    'author': '젼이는 냐옹냐옹',
    'title': '우리집 고얌미 네모네모야',
    'content': '우리집 고얌미 네모네모빔 맞았엌ㅋㅋㅋ',
    'profileUrl':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRESQMNAFE8gcZBlZmbJgAf2CEcLvSKpQSvpQ&s',
    'image': 'assets/images/product8.png',
    'likes': 250,
    'comments': [],
    'createdAt': DateTime.now().subtract(const Duration(hours: 2)),
    'isLiked': false, // 좋아요 상태 추가
    'isScraped': false, // 스크랩 상태 추가
  },
  {
    'id': 4,
    'author': '우주 최강 햄스터',
    'title': '1년 째 키우는 햄찌 아리미',
    'content': '겁나 기여움 우주에서 제일 기여워 ',
    'profileUrl':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRESQMNAFE8gcZBlZmbJgAf2CEcLvSKpQSvpQ&s',
    'image': 'assets/images/product8.png',
    'likes': 998,
    'comments': [
      {'author': '유저2', 'content': '악 너무 커여어 ㅜㅜㅜ'},
      {'author': '옆집뽀삐 재궈니', 'content': '울집 강쥐는 왜,, 정말 귀엽네요 ㅜㅜ'},
    ],
    'createdAt': DateTime.now().subtract(const Duration(hours: 2)),
    'isLiked': false, // 좋아요 상태 추가
    'isScraped': false, // 스크랩 상태 추가
  },
];
