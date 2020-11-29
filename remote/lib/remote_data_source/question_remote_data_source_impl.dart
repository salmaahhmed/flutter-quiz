import 'dart:convert';

import 'package:data/data.dart';
import 'package:data/model/trivia_cateogry_model.dart';
import 'package:http/http.dart' as http;
import 'package:remote/mapper/question_remote_mapper.dart';
import 'dart:async';
import '../remote.dart';

class QuestionsRemoteDataSourceImpl extends QuestionRemoteDataSource {
  final QuestionMapperRemote _questionMapper;
  QuestionsRemoteDataSourceImpl(this._questionMapper);

  @override
  Future<List<QuestionModel>> getTriviaQuestions(
      TriviaCategoryModel categoryModel) async {
    var list = [];
    final link =
        'https://opentdb.com/api.php?amount=10&category=${categoryModel.id}&type=multiple';
    var res = await http
        .get(Uri.encodeFull(link), headers: {"Accept": "application/json"});
    print(res.body);
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data["results"] as List;
      list = rest
          .map<QuestionModel>((json) =>
              _questionMapper.mapFromRemote(QuestionRemote.fromJson(json)))
          .toList();
    }
    print("Category List Size: ${list.length}");
    return list;
  }
}
