// import 'package:flutter/material.dart';
//
// import '../../core/gen/assets.gen.dart';
// import '../../models/category_data_model.dart';
// import 'category_card_widget.dart';
//
// class CategoriesViewWidget extends StatefulWidget {
//   final void Function(CategoryDataModel) onCategorySelected;
//
//   CategoriesViewWidget({super.key, required this.onCategorySelected});
//
//   @override
//   State<CategoriesViewWidget> createState() => _CategoriesViewWidgetState();
// }
//
// class _CategoriesViewWidgetState extends State<CategoriesViewWidget> {
//   final List<CategoryDataModel> categoriesList = [
//     CategoryDataModel(
//       id: 'general',
//       title: 'General',
//       image: Assets.images.generalDark.path,
//       lightImage: Assets.images.general.path,
//     ),
//     CategoryDataModel(
//       id: 'business',
//       title: 'Business',
//       image: Assets.images.busniessDark.path,
//       lightImage: Assets.images.busniess.path,
//     ),
//     CategoryDataModel(
//       id: 'sports',
//       title: 'Sports',
//       image: Assets.images.sportDark.path,
//       lightImage: Assets.images.sport.path,
//     ),
//     CategoryDataModel(
//       id: 'technology',
//       title: 'Technology',
//       image: Assets.images.technologyDark.path,
//       lightImage: Assets.images.technology.path,
//     ),
//     CategoryDataModel(
//       id: 'entertainment',
//       title: 'Entertainment',
//       image: Assets.images.entertainmentDark.path,
//       lightImage: Assets.images.entertainment.path,
//     ),
//     CategoryDataModel(
//       id: 'health',
//       title: 'Health',
//       image: Assets.images.helthDark.path,
//       lightImage: Assets.images.helth.path,
//     ),
//     CategoryDataModel(
//       id: 'science',
//       title: 'Science',
//       image: Assets.images.scienceDark.path,
//       lightImage: Assets.images.science.path,
//     ),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Good Morning\nHere's Some News For You",
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
//             ),
//             ...List.generate(categoriesList.length, (index) {
//               return CategoryCardWidget(
//                 onTap: widget.onCategorySelected,
//                 isLeft: index % 2 == 0,
//                 categoryDataModel: categoriesList[index],
//               );
//             }),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

import '../../core/gen/assets.gen.dart';
import '../../models/category_data_model.dart';
import 'category_card_widget.dart';

class CategoriesViewWidget extends StatelessWidget {
  final void Function(CategoryDataModel) onCategorySelected;

  CategoriesViewWidget({super.key, required this.onCategorySelected});

  final List<CategoryDataModel> categoriesList = [
    CategoryDataModel(
      id: 'general',
      title: 'General',
      image: Assets.images.generalDark.path,
      lightImage: Assets.images.general.path,
    ),
    CategoryDataModel(
      id: 'business',
      title: 'Business',
      image: Assets.images.busniessDark.path,
      lightImage: Assets.images.busniess.path,
    ),
    CategoryDataModel(
      id: 'sports',
      title: 'Sports',
      image: Assets.images.sportDark.path,
      lightImage: Assets.images.sport.path,
    ),
    CategoryDataModel(
      id: 'technology',
      title: 'Technology',
      image: Assets.images.technologyDark.path,
      lightImage: Assets.images.technology.path,
    ),
    CategoryDataModel(
      id: 'entertainment',
      title: 'Entertainment',
      image: Assets.images.entertainmentDark.path,
      lightImage: Assets.images.entertainment.path,
    ),
    CategoryDataModel(
      id: 'health',
      title: 'Health',
      image: Assets.images.helthDark.path,
      lightImage: Assets.images.helth.path,
    ),
    CategoryDataModel(
      id: 'science',
      title: 'Science',
      image: Assets.images.scienceDark.path,
      lightImage: Assets.images.science.path,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          child: Text(
            "Good Morning\nHere's Some News For You",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            itemCount: categoriesList.length,
            itemBuilder: (context, index) {
              final category = categoriesList[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CategoryCardWidget(
                  categoryDataModel: category,
                  isLeft: index % 2 == 0,
                  onTap: onCategorySelected,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
