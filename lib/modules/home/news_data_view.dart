///before pagination
// import 'package:flutter/material.dart';
// import 'package:news_app/models/category_data_model.dart';
//
// import '../../core/config/theme/app_colors.dart';
// import '../../models/article_data.dart';
// import '../../models/source_data_model.dart';
// import '../../network_handler/network_handler.dart';
// import 'article_card_widget.dart';
//
// class NewsDataView extends StatefulWidget {
//   final CategoryDataModel categoryDataModel;
//   final String? searchQuery;
//
//   const NewsDataView({
//     super.key,
//     required this.categoryDataModel,
//     this.searchQuery,
//   });
//   @override
//   State<NewsDataView> createState() => _NewsDataViewState();
// }
//
// class _NewsDataViewState extends State<NewsDataView> {
//   int _selectedIndex = 0;
//
//   Future<List<ArticleData>>? _searchFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     if (widget.searchQuery != null && widget.searchQuery!.isNotEmpty) {
//       _searchFuture = NetworkHandler.searchArticles(widget.searchQuery!);
//     }
//   }
//
//   @override
//   void didUpdateWidget(covariant NewsDataView oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (oldWidget.searchQuery != widget.searchQuery) {
//       if (widget.searchQuery != null && widget.searchQuery!.isNotEmpty) {
//         _searchFuture = NetworkHandler.searchArticles(widget.searchQuery!);
//       } else {
//         _searchFuture = null;
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final isSearching =
//         widget.searchQuery != null && widget.searchQuery!.isNotEmpty;
//
//     //search mode
//     if (isSearching) {
//       return FutureBuilder<List<ArticleData>>(
//         future: _searchFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             return const Center(child: Text("Something went wrong"));
//           }
//           if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text("No results found"));
//           }
//
//           final articlesList = snapshot.data!;
//
//           return ListView.builder(
//             itemCount: articlesList.length,
//             itemBuilder: (context, index) {
//               return ArticleCardWidget(article: articlesList[index]);
//             },
//           );
//         },
//       );
//     }
//
//     // NORMAL MODE
//     return FutureBuilder<List<SourceData>>(
//       future: NetworkHandler.getAllSources(widget.categoryDataModel.id),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (snapshot.hasError) {
//           return const Center(child: Text("Something went wrong"));
//         }
//         if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return const Center(child: Text("No sources found"));
//         }
//
//         final sourcesList = snapshot.data!;
//
//         return Column(
//           children: [
//             DefaultTabController(
//               length: sourcesList.length,
//               child: TabBar(
//                 onTap: (index) {
//                   setState(() {
//                     _selectedIndex = index;
//                   });
//                 },
//                 padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//                 isScrollable: true,
//                 dividerColor: Colors.transparent,
//                 labelColor: AppColors.black,
//                 tabAlignment: TabAlignment.start,
//                 indicatorColor: AppColors.black,
//                 indicatorSize: TabBarIndicatorSize.tab,
//                 tabs: List.generate(sourcesList.length, (index) {
//                   final isSelected = _selectedIndex == index;
//                   return Text(
//                     sourcesList[index].name,
//                     style: TextStyle(
//                       fontSize: isSelected ? 16 : 14,
//                       fontWeight: isSelected
//                           ? FontWeight.w700
//                           : FontWeight.w500,
//                       color: AppColors.black,
//                     ),
//                   );
//                 }),
//               ),
//             ),
//             Expanded(
//               child: FutureBuilder<List<ArticleData>>(
//                 future: NetworkHandler.getAllArticles(
//                   sourcesList[_selectedIndex].id,
//                 ),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   }
//                   if (snapshot.hasError) {
//                     return const Center(child: Text("Something went wrong"));
//                   }
//                   if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                     return const Center(child: Text("No articles found"));
//                   }
//
//                   final articlesList = snapshot.data!;
//
//                   return ListView.builder(
//                     itemCount: articlesList.length,
//                     itemBuilder: (context, index) {
//                       return ArticleCardWidget(article: articlesList[index]);
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

///pagination
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:news_app/models/category_data_model.dart';

import '../../core/config/theme/app_colors.dart';
import '../../models/article_data.dart';
import '../../models/source_data_model.dart';
import '../../network_handler/network_handler.dart';
import 'article_card_widget.dart';

class NewsDataView extends StatefulWidget {
  final CategoryDataModel categoryDataModel;
  final String? searchQuery;

  const NewsDataView({
    super.key,
    required this.categoryDataModel,
    this.searchQuery,
  });

  @override
  State<NewsDataView> createState() => _NewsDataViewState();
}

class _NewsDataViewState extends State<NewsDataView>
    with TickerProviderStateMixin {
  TabController? _tabController;
  List<SourceData> _sources = [];
  int _selectedIndex = 0;

  late PagingController<int, ArticleData> _pagingController;

  @override
  void initState() {
    super.initState();
    _pagingController = _buildPagingController();
    _loadSources();
  }

  PagingController<int, ArticleData> _buildPagingController() {
    return PagingController<int, ArticleData>(
      getNextPageKey: (state) =>
          state.lastPageIsEmpty ? null : state.nextIntPageKey,
      fetchPage: (pageKey) async {
        final query = widget.searchQuery;
        if (query != null && query.isNotEmpty) {
          return NetworkHandler.searchArticles(query, page: pageKey);
        } else if (_sources.isNotEmpty) {
          return NetworkHandler.getAllArticles(
            _sources[_selectedIndex].id,
            page: pageKey,
          );
        }
        return [];
      },
    );
  }

  void _resetController() {
    _pagingController.dispose();
    _pagingController = _buildPagingController();
    setState(() {});
  }

  @override
  void didUpdateWidget(covariant NewsDataView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.searchQuery != widget.searchQuery) {
      _resetController();
    }
  }

  Future<void> _loadSources() async {
    try {
      final sources = await NetworkHandler.getAllSources(
        widget.categoryDataModel.id,
      );
      _tabController?.dispose();
      _tabController = TabController(length: sources.length, vsync: this)
        ..addListener(() {
          if (!_tabController!.indexIsChanging) {
            _selectedIndex = _tabController!.index;
            _resetController();
          }
        });
      setState(() => _sources = sources);
      _resetController();
    } catch (e) {
      // sources failed to load
    }
  }

  Widget _buildPagedList() {
    return PagingListener(
      controller: _pagingController,
      builder: (context, state, fetchNextPage) =>
          PagedListView<int, ArticleData>(
            state: state,
            fetchNextPage: fetchNextPage,
            builderDelegate: PagedChildBuilderDelegate<ArticleData>(
              itemBuilder: (context, article, index) =>
                  ArticleCardWidget(article: article),
              firstPageErrorIndicatorBuilder: (_) =>
                  const Center(child: Text("Something went wrong")),
              noItemsFoundIndicatorBuilder: (_) =>
                  const Center(child: Text("No articles found")),
              firstPageProgressIndicatorBuilder: (_) =>
                  const Center(child: CircularProgressIndicator()),
              newPageProgressIndicatorBuilder: (_) => const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isSearching =
        widget.searchQuery != null && widget.searchQuery!.isNotEmpty;

    if (isSearching) return _buildPagedList();

    if (_sources.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        TabBar(
          controller: _tabController,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          isScrollable: true,
          dividerColor: Colors.transparent,
          labelColor: AppColors.black,
          tabAlignment: TabAlignment.start,
          indicatorColor: AppColors.black,
          indicatorSize: TabBarIndicatorSize.tab,
          labelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          tabs: _sources.map((s) => Tab(text: s.name)).toList(),
        ),
        Expanded(child: _buildPagedList()),
      ],
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    _tabController?.dispose();
    super.dispose();
  }
}
