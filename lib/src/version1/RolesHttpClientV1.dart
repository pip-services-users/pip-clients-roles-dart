import 'dart:async';
import 'dart:convert';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_services3_rpc/pip_services3_rpc.dart';
import './UserRolesV1.dart';
import './IRolesClientV1.dart';

class RolesHttpClientV1 extends CommandableHttpClient
    implements IRolesClientV1 {
  RolesHttpClientV1([config]) : super('v1/roles') {
    if (config != null) {
      configure(ConfigParams.fromValue(config));
    }
  }

  /// Gets a page of roles retrieved by a given filter.
  ///
  /// - [correlationId]     (optional) transaction id to trace execution through call chain.
  /// - [filter]            (optional) a filter function to filter items
  /// - [paging]            (optional) paging parameters
  /// Return         Future that receives a data page
  /// Throws error.
  @override
  Future<DataPage<UserRolesV1>> getRolesByFilter(
      String correlationId, FilterParams filter, PagingParams paging) async {
    var result = await callCommand(
      'get_roles_by_filter',
      correlationId,
      {'filter': filter, 'paging': paging},
    );
    return DataPage<UserRolesV1>.fromJson(json.decode(result), (item) {
      var role = UserRolesV1();
      role.fromJson(item);
      return role;
    });
  }

  /// Gets an user roles by user unique id.
  ///
  /// - [correlationId]     (optional) transaction id to trace execution through call chain.
  /// - [userId]                an user id.
  /// Return         Future that receives user roles or error.
  @override
  Future<List<String>> getRolesById(String correlationId, String userId) async {
    var result = await callCommand(
        'get_roles_by_id', correlationId, {'user_id': userId});
    if (result == null) return null;
    var roles = List<String>.from(json.decode(result));
    return roles;
  }

  /// Sets a roles.
  ///
  /// - [correlation_id]    (optional) transaction id to trace execution through call chain.
  /// - [userId]                an user id.
  /// - [roles]                a roles to be set.
  /// Return         (optional) Future that receives set roles or error.
  @override
  Future<List<String>> setRoles(
      String correlationId, String userId, List<String> roles) async {
    var result = await callCommand(
        'set_roles', correlationId, {'user_id': userId, 'roles': roles});
    if (result == null) return null;
    var res_roles = List<String>.from(json.decode(result));
    return res_roles;
  }

  /// Grants a roles.
  ///
  /// - [correlation_id]    (optional) transaction id to trace execution through call chain.
  /// - [userId]                an user id.
  /// - [roles]                a roles to be granted.
  /// Return         (optional) Future that receives granted roles or error.
  @override
  Future<List<String>> grantRoles(
      String correlationId, String userId, List<String> roles) async {
    var result = await callCommand(
        'grant_roles', correlationId, {'user_id': userId, 'roles': roles});
    if (result == null) return null;
    var res_roles = List<String>.from(json.decode(result));
    return res_roles;
  }

  /// Revokes a roles.
  ///
  /// - [correlation_id]    (optional) transaction id to trace execution through call chain.
  /// - [userId]                an user id.
  /// - [roles]                a roles to be revoked.
  /// Return         (optional) Future that receives revoked roles or error.
  @override
  Future<List<String>> revokeRoles(
      String correlationId, String userId, List<String> roles) async {
    var result = await callCommand(
        'revoke_roles', correlationId, {'user_id': userId, 'roles': roles});
    if (result == null) return null;
    var res_roles = List<String>.from(json.decode(result));
    return res_roles;
  }

  /// Checks the authorization.
  ///
  /// - [correlation_id]    (optional) transaction id to trace execution through call chain.
  /// - [userId]                an user id.
  /// - [roles]                a roles to be revoked.
  /// Return         (optional) Future that receives bool value of authorization or error.
  @override
  Future<bool> authorize(
      String correlationId, String userId, List<String> roles) async {
    var result = await callCommand(
        'authorize', correlationId, {'user_id': userId, 'roles': roles});
    if (result == null) return null;
    var authorized = json.decode(result);
    return authorized;
  }
}
