import 'dart:convert';

import 'package:data/model/trivia_cateogry_model.dart';
import 'package:data/source/category/index.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import '../remote.dart';

class CategoriesRemoteDataSourceImpl extends CategoryRemoteDataSource {
  final CategoryRemoteMapper _categoryRemoteMapper;
  CategoriesRemoteDataSourceImpl(this._categoryRemoteMapper);

  @override
  Future<List<TriviaCategoryModel>> getTriviaCategories() async {
    var list = [];
    final link = 'https://opentdb.com/api_category.php';
    var res = await http
        .get(Uri.encodeFull(link), headers: {"Accept": "application/json"});
    print(res.body);
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data["trivia_categories"] as List;
      list = rest
          .map<TriviaCategoryModel>((json) => _categoryRemoteMapper
              .mapFromRemote(TriviaCategoryRemote.fromJson(json)))
          .toList();
    }
    print("Category List Size: ${list.length}");
    return list;
  }
}
