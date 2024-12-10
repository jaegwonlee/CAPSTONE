import './post.dart';
import './shop.dart';
import '../utils/random.dart';

final List<Map<String, dynamic>> bestPosts = getRandom(posts, count: 3);

final List<Map<String, dynamic>> recommendedProducts =
    getRandom(allProducts, count: 3);
