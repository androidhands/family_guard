import 'package:family_guard/core/utils/app_constants.dart';
import 'package:family_guard/features/general/domain/entities/paging.dart';

class PagingModel extends Paging {
  const PagingModel(
      {int pageNumber = 1, int pageSize = AppConstants.defaultPageSize})
      : super(pageNumber: pageNumber, pageSize: pageSize);

  factory PagingModel.fromMap(Map<String, dynamic> json) => PagingModel(
        pageNumber: json['Paging.pageNumber'],
        pageSize: json['Paging.pageSize'],
      );

  factory PagingModel.fromPaging(Paging? paging) => PagingModel(
        pageNumber: paging?.pageNumber ?? 1,
        pageSize: paging?.pageSize ?? AppConstants.defaultPageSize,
      );

  Map<String, dynamic> toMap() => {
        "Paging.pageNumber": pageNumber,
        "Paging.pageSize": AppConstants.defaultPageSize, //pageSize,
      };
}
