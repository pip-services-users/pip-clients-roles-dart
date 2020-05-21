import 'dart:async';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_services3_rpc/pip_services3_rpc.dart';
import './UserRolesV1.dart';
import './IRolesClientV1.dart';

class RolesDirectClientV1 extends DirectClient<dynamic>
    implements IRolesClientV1 {
  RolesDirectClientV1() : super() {
    dependencyResolver.put('controller',
        Descriptor('pip-services-roles', 'controller', '*', '*', '1.0'));
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
    var timing = instrument(correlationId, 'roles.get_roles_by_filter');
    var page = await controller.getRolesByFilter(correlationId, filter, paging);
    timing.endTiming();
    return page;
  }

  /// Gets an user roles by user unique id.
  ///
  /// - [correlationId]     (optional) transaction id to trace execution through call chain.
  /// - [userId]                an user id.
  /// Return         Future that receives user roles or error.
  @override
  Future<List<String>> getRolesById(String correlationId, String userId) async {
    var timing = instrument(correlationId, 'roles.get_roles_by_id');
    var roles = await controller.getRolesById(correlationId, userId);
    timing.endTiming();
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
    var timing = instrument(correlationId, 'roles.set_roles');
    var result = await controller.setRoles(correlationId, userId, roles);
    timing.endTiming();
    return result;
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
    var timing = instrument(correlationId, 'roles.grant_roles');
    var result = await controller.grantRoles(correlationId, userId, roles);
    timing.endTiming();
    return result;
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
    var timing = instrument(correlationId, 'roles.revoke_roles');
    var result = await controller.revokeRoles(correlationId, userId, roles);
    timing.endTiming();
    return result;
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
    var timing = instrument(correlationId, 'roles.authorize');
    var authorized = await controller.authorize(correlationId, userId, roles);
    timing.endTiming();
    return authorized;
  }
}
