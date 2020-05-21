import 'package:test/test.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';

import 'package:pip_clients_roles/pip_clients_roles.dart';

final ROLES = ['Role 1', 'Role 2', 'Role 3'];

class RolesClientFixtureV1 {
  IRolesClientV1 _client;

  RolesClientFixtureV1(IRolesClientV1 client) {
    expect(client, isNotNull);
    _client = client;
  }

  void testGetAndSetRoles() async {
    // Set party roles
    var roles = await _client.setRoles(null, '1', ROLES);

    expect(roles, isNotNull);
    expect(roles.length, 3);

    // Read and check party roles
    roles = await _client.getRolesById(null, '1');

    expect(roles, isNotNull);
    expect(roles.length, 3);

    var page = await _client.getRolesByFilter(
        null, FilterParams.fromTuples(['roles', ROLES]), PagingParams());

    expect(page, isNotNull);
    expect(page.data.length, 1);
  }

  void testGrantAndRevokeRoles() async {
    // Grant roles first time
    var roles = await _client.grantRoles(null, '2', ['Role1']);

    expect(roles, isNotNull);
    expect(roles.length, 1);
    expect(roles, ['Role1']);

    // Grant roles second time
    roles = await _client.grantRoles(null, '2', ['Role1', 'Role2', 'Role3']);

    expect(roles, isNotNull);
    expect(roles.length, 3);
    expect(roles, ['Role1', 'Role2', 'Role3']);

    // Revoke roles first time
    roles = await _client.revokeRoles(null, '2', ['Role1']);

    expect(roles, isNotNull);
    expect(roles.length, 2);
    expect(roles, ['Role2', 'Role3']);

    // Get roles
    roles = await _client.getRolesById(null, '2');

    expect(roles, isNotNull);
    expect(roles.length, 2);
    expect(roles, ['Role2', 'Role3']);

    // Revoke roles second time
    roles = await _client.revokeRoles(null, '2', ['Role1', 'Role2']);

    expect(roles, isNotNull);
    expect(roles.length, 1);
    expect(roles, ['Role3']);
  }

  void testAuthorize() async {
    // Grant roles
    var roles = await _client.grantRoles(null, '3', ['Role_1', 'Role_2']);

    expect(roles, isNotNull);
    expect(roles.length, 2);

    // Authorize positively
    var result = await _client.authorize(null, '3', ['Role_1']);

    expect(result, isNotNull);
    expect(result, isTrue);

    // Authorize negatively
    result = await _client.authorize(null, '3', ['Role_2', 'Role_3']);

    expect(result, isNotNull);
    expect(result, isFalse);
  }
}
