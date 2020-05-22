import 'dart:async';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_services_roles/pip_services_roles.dart';
import './IRolesClientV1.dart';

class RolesNullClientV1 implements IRolesClientV1 {
  @override
  Future<DataPage<UserRolesV1>> getRolesByFilter(
      String correlationId, FilterParams filter, PagingParams paging) async {
    return DataPage<UserRolesV1>([], 0);
  }

  @override
  Future<List<String>> getRolesById(String correlationId, String userId) async {
    return List<String>(0);
  }

  @override
  Future<List<String>> setRoles(
      String correlationId, String userId, List<String> roles) async {
    return List<String>(0);
  }

  @override
  Future<List<String>> grantRoles(
      String correlationId, String userId, List<String> roles) async {
    return List<String>(0);
  }

  @override
  Future<List<String>> revokeRoles(
      String correlationId, String userId, List<String> roles) async {
    return List<String>(0);
  }

  @override
  Future<bool> authorize(
      String correlationId, String userId, List<String> roles) async {
    return null;
  }
}
