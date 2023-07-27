import 'package:equatable/equatable.dart';
import 'package:family_guard/core/utils/app_constants.dart';

class Paging extends Equatable {
  final int pageNumber;
  final int pageSize;

  const Paging(
      {this.pageNumber = 1, this.pageSize = AppConstants.defaultPageSize});

  @override
  List<Object?> get props => [pageNumber, pageSize];
}
