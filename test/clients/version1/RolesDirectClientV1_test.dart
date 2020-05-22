import 'dart:async';
import 'package:test/test.dart';
import 'package:pip_services3_components/pip_services3_components.dart';
import 'package:pip_services_roles/pip_services_roles.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_clients_roles/pip_clients_roles.dart';
import './RolesClientFixtureV1.dart';

void main() {
  group('RolesDirectClientV1', () {
    RolesDirectClientV1 client;
    RolesClientFixtureV1 fixture;
    RolesMemoryPersistence persistence;
    RolesController controller;

    setUp(() async {
      var logger = ConsoleLogger();
      persistence = RolesMemoryPersistence();
      controller = RolesController();
      var references = References.fromTuples([
        Descriptor('pip-services', 'logger', 'console', 'default', '1.0'),
        logger,
        Descriptor('pip-services-roles', 'persistence', 'memory',
            'default', '1.0'),
        persistence,
        Descriptor('pip-services-roles', 'controller', 'default',
            'default', '1.0'),
        controller
      ]);
      controller.setReferences(references);

      client = RolesDirectClientV1();
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
