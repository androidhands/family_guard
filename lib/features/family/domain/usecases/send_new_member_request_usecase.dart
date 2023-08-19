import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/core/network/api_endpoint.dart';
import 'package:family_guard/core/usecases/usecases.dart';
import 'package:family_guard/features/family/domain/repositories/base_family_connections_repository.dart';

class SendNewMemberRequestUsecase
    extends BaseUseCases<String, AddNewMemberParams> {
  final BaseFamilyConnectionsRepository baseFamilyConnectionsRepository;

  SendNewMemberRequestUsecase({required this.baseFamilyConnectionsRepository});

  @override
  Future<Either<Failure,String>> call(AddNewMemberParams params) {
    return baseFamilyConnectionsRepository.addNewFamilyConnections(params);
  }
}

class AddNewMemberParams extends Equatable {
  final String mobile;
  final String sender;
  final String member;

  const AddNewMemberParams(
      {required this.mobile, required this.sender, required this.member});

  @override
  List<Object?> get props => [mobile, sender, member];

  Map<String, dynamic> toMap() {
    return {
      'mobile': mobile,
      'sender': sender,
      'member': member,
      'api_password': ApiEndPoint.apiPassword
    };
  }
}
