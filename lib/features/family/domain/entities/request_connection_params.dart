import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:family_guard/core/network/api_endpoint.dart';
import 'package:family_guard/features/family/domain/entities/member_entity.dart';

class RequestConnectionParams extends Equatable {
  final MemberEntity memberEntity;
  final String accessToken;

  const RequestConnectionParams(
      {required this.memberEntity, required this.accessToken});

  @override
  List<Object?> get props => [memberEntity, accessToken];

  Map<String, dynamic> toMap() {
    return {
      'member': jsonEncode(memberEntity),
      'api_password': ApiEndPoint.apiPassword
    };
  }
}
