import 'package:pip_clients_roles/pip_clients_roles.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';

Future<void> main(List<String> argument) async {
  try {
    var correlationId = '123';
    var config = ConfigParams.fromTuples([
      'connection.type',
      'http',
      'connection.host',
      'localhost',
      'connection.port',
      8080
    ]);
    var client = RolesHttpClientV1();
    client.configure(config);
    await client.open(correlationId);
    // Grant roles first time
    await client.grantRoles(correlationId, '1', ['admin']);
    // Grant roles second time
    await client.grantRoles(correlationId, '1', ['admin', 'test', 'user']);

    var roles = await client.getRolesById(correlationId, '1');

    if (roles.length == 3) {
      print('Get roles length: ' +
          roles.length.toString() +
          '! Everything works well!');
    } else {
      print('Get roles length: ' +
          roles.length.toString() +
          ' is not equal! Something was wrong!');
    }

    // Authorize role
    var authorized = await client.authorize(null, '1', ['admin']);
    if (authorized) {
      print('Role admin is autorized! Everything works well!');
    } else {
      print('Role admin is not autorized! Something was wrong!');
    }
    await client.close(correlationId);
  } catch (ex) {
    print(ex);
  }
}
