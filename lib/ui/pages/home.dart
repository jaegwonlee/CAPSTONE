import 'package:flutter_application_2/ui/views/product_detail.dart';
import 'package:flutter_application_2/ui/views/post_detail.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_application_2/data/home.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  final String token;

  const HomePage({Key? key, required this.token}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentBestIndex = 0;
  int _currentProductIndex = 0;
  Timer? _productTimer;
  Timer? _bestTimer;

  final PageController _bestPageController = PageController();
  final PageController _productPageController = PageController();

  @override
  void initState() {
    super.initState();

    // BEST 게시글 AutoPlay
    _bestTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        _currentBestIndex = (_currentBestIndex + 1) % bestPosts.length;
      });

      _bestPageController.animateToPage(
        _currentBestIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });

    // 추천 상품 AutoPlay
    _productTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        _currentProductIndex =
            (_currentProductIndex + 1) % recommendedProducts.length;
      });

      _productPageController.animateToPage(
        _currentProductIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _productTimer?.cancel();
    _bestTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Image.asset(
          'assets/images/logo.png',
          height: 8.h,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // 알림 버튼 로직
            },
          ),
        ],
      ),
      body: _buildHomePage(),
    );
  }

  Widget _buildHomePage() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'BEST 게시글',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 30.h,
            child: PageView.builder(
              padEnds: false,
              controller: _bestPageController, // PageController 연결
              itemCount: bestPosts.length,
              onPageChanged: (value) => {
                _currentBestIndex = (_currentBestIndex + 1) % bestPosts.length
              },
              itemBuilder: (context, index) {
                final post = bestPosts[index];
                final formattedDate =
                    DateFormat('yyyy-MM-dd').format(post['createdAt']);

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostDetailPage(post: post),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12.0),
                      image: DecorationImage(
                        image: AssetImage(post['image']),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: Adaptive.w(100),
                        height: 10.5.h,
                        padding: const EdgeInsets.all(8.0),
                        color: Colors.black.withOpacity(0.5),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${post['title']}',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                            Text(
                              '작성자: ${post['author']}',
                              style: const TextStyle(color: Colors.white70),
                            ),
                            Text(
                              '$formattedDate',
                              style: const TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              '추천 상품',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 30.h,
            child: PageView.builder(
              padEnds: false,
              controller: _productPageController,
              itemCount: recommendedProducts.length,
              onPageChanged: (value) => {
                _currentProductIndex =
                    (_currentProductIndex + 1) % recommendedProducts.length
              },
              itemBuilder: (context, index) {
                final product = recommendedProducts[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailPage(product: product),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12.0),
                      image: DecorationImage(
                        image: AssetImage(product['image']),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: Adaptive.w(100),
                        height: 10.h,
                        padding: const EdgeInsets.all(8.0),
                        color: Colors.black.withOpacity(0.5),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product['name'],
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                            Text(
                              '${product['price']}',
                              style: const TextStyle(
                                  color: Colors.white70, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
