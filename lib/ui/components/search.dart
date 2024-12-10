import 'package:flutter/material.dart';
import 'package:flutter_application_2/data/shop.dart';
import 'package:flutter_application_2/data/post.dart';
import 'package:flutter_application_2/ui/views/post_detail.dart';
import 'package:flutter_application_2/ui/views/product_detail.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key, required this.type});
  final String type;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> searchResult = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('검색'),
        backgroundColor: Color(0x44009223),
        leading: IconButton(
          icon: Icon(FontAwesomeIcons.chevronLeft),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SizedBox(
        width: 100.w,
        height: 100.h,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                  decoration: InputDecoration(
                    hintText: '검색어를 입력하세요',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    prefixIcon: const Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    _searchController.text = value;
                    if (widget.type == "shop") {
                      searchResult = allProducts
                          .where((element) =>
                              element["name"]!.contains(_searchController.text))
                          .toList();

                      setState(() {});
                    } else {
                      searchResult = posts
                          .where((element) =>
                              element["title"]
                                  .toString()
                                  .contains(_searchController.text) |
                              element["content"]
                                  .toString()
                                  .contains(_searchController.text) |
                              element["author"]
                                  .toString()
                                  .contains(_searchController.text))
                          .toList();

                      setState(() {});
                    }
                  }),
              const SizedBox(height: 16),
              Expanded(
                child: Center(
                  child: searchResult.length == 0
                      ? Text('검색된 결과가 없습니다')
                      : ListView.builder(
                          itemCount: searchResult.length,
                          itemBuilder: (context, index) {
                            final product =
                                searchResult[index]; // 필터링된 상품을 가져옵니다.
                            return SingleChildScrollView(
                              child: SizedBox(
                                width: 100.w,
                                height: widget.type == "shop" ? 25.h : 50.h,
                                child: Card(
                                  margin: const EdgeInsets.all(8),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(0),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => widget.type ==
                                                  "shop"
                                              ? ProductDetailPage(
                                                  product: product)
                                              : PostDetailPage(post: product),
                                        ),
                                      );
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          product['image'],
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                        Text(product[widget.type == "shop"
                                            ? "name"
                                            : "title"]!),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              product[widget.type == "shop"
                                                  ? "price"
                                                  : "content"]!,
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
