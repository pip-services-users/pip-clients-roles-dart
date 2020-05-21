import 'dart:async';

import 'package:test/test.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_clients_roles/pip_clients_roles.dart';
import './RolesClientFixtureV1.dart';

var httpConfig = ConfigParams.fromTuples([
  'connection.protocol',
  'http',
  'connection.host',
  'localhost',
  'connection.port',
  8080
]);

void main() {
  group('RolesHttpClientV1', () {
    RolesHttpClientV1 client;
    RolesClientFixtureV1 fixture;

    setUp(() async {
      client = RolesHttpClientV1();
      client.configure(httpConfig);
      var references = References.fromTuples([
        Descriptor('pip-services-roles', 'client', 'http', 'default', '1.0'),
        client
      ]);
      client.setReferences(references);
      fixture = RolesClientFixtureV1(client);
      await client.open(null);
    });

    tearDown(() async {
      await client.close(null);
      await Future.delayed(Duration(milliseconds: 2000));
    });

    test('Get and Set Roles', () async {
      await fixture.testGetAndSetRoles();
    });

    test('Grant and Revoke Roles', () async {
      await fixture.testGrantAndRevokeRoles();
    });

    test('Authorize', () async {
      await fixture.testAuthorize();
    });
  });
}
