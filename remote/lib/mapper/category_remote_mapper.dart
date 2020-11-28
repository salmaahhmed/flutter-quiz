import 'package:clean_architecture_base/clean_architecture_base.dart';
import 'package:data/data.dart';

import '../remote.dart';

class CategoryRemoteMapper
    extends RemoteMapper<TriviaCategoryRemote, TriviaCategoryModel> {
  @override
  TriviaCategoryModel mapFromRemote(TriviaCategoryRemote type) {
    return (type == null)
        ? null
        : TriviaCategoryModel(name: type.name, id: type.id);
  }

  @override
  Future<TriviaCategoryRemote> mapToRemote(TriviaCategoryModel type) async {
    return (type == null) ? null : TriviaCategoryRemote()
      ..name = type.name
      ..id = type.id;
  }
}
