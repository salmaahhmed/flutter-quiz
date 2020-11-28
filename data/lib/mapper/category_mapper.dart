import 'package:clean_architecture_base/clean_architecture_base.dart';
import 'package:domain/domain_index.dart';

import '../data.dart';

class CategoryMapper extends Mapper<TriviaCategoryEntity, TriviaCategoryModel> {
  @override
  TriviaCategoryEntity mapToEntity(TriviaCategoryModel type) {
    return (type == null) ? null : TriviaCategoryEntity()
      ..name = type.name
      ..id = type.id;
  }

  @override
  TriviaCategoryModel mapFromEntity(TriviaCategoryEntity type) {
    return (type == null)
        ? null
        : TriviaCategoryModel(name: type.name, id: type.id);
  }
}
