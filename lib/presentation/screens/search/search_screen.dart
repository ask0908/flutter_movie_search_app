import 'package:flutter/material.dart';
import 'package:flutter_movie_search_app/presentation/screens/home/widget/movie_home_title_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {

  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MovieHomeTitleText(title: "Search"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 검색 입력창
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: '영화 제목을 입력하세요',
                prefixIcon: Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      _searchController.clear();
                    });
                  },
                )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                setState(() {});
                debugPrint("검색어: $value");
                // TODO: 검색 로직 구현
              },
            ),
            SizedBox(height: 16),

            // 검색 결과 또는 안내 메시지
            Expanded(
              child: Center(
                child: Text(
                  _searchController.text.isEmpty
                      ? "영화를 검색해보세요"
                      : "검색 결과를 표시할 예정입니다",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}