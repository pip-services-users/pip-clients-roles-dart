# <img src="https://github.com/pip-services/pip-services/raw/master/design/Logo.png" alt="Pip.Services Logo" style="max-width:30%"> <br> Roles Microservice Client SDK for Dart

This is a Dart client SDK for [pip-services-roles](https://github.com/pip-services-users/pip-services-roles-dart) microservice.

## Download

Right now the only way to get the microservice is to check it out directly from github repository
```bash
git clone git@github.com:pip-services-users/pip-clients-roles-dart.git
```

Pip.Service team is working to implement packaging and make stable releases available for your 
as zip downloadable archieves.

## Contract

Logical contract of the microservice is presented below. For physical implementation (HTTP/REST),
please, refer to documentation of the specific protocol.

```dart
class UserRolesV1 implements IStringIdentifiable {
  String id;
  List<String> roles;
  DateTime update_time;
}

abstract class IRolesV1 {
  Future<DataPage<UserRolesV1>> getRolesByFilter(
      String correlationId, FilterParams filter, PagingParams paging);

  Future<List<String>> getRolesById(String correlationId, String userId);

  Future<List<String>> setRoles(String correlationId, String userId, List<String> roles);

  Future<List<String>> grantRoles(String correlationId, String userId, List<String> roles);

  Future<List<String>> revokeRoles(String correlationId, String userId, List<String> roles);

  Future<bool> authorize(String correlationId, String userId, List<String> roles);
}
```

## Use

The easiest way to work with the microservice is to use client SDK. 

Define client configuration parameters that match the configuration of the microservice's external API
```dart
// Client configuration
var httpConfig = ConfigParams.fromTuples(
	"connection.protocol", "http",
	"connection.host", "localhost",
	"connection.port", 8080
);
```

Instantiate the client and open connection to the microservice
```dart
// Create the client instance
var client = RolesHttpClientV1(config);

// Configure the client
client.configure(httpConfig);

// Connect to the microservice
try{
  await client.open(null)
}catch() {
  // Error handling...
}       
// Work with the microservice
// ...
```

Now the client is ready to perform operations
```dart
final ROLES = ['Role 1', 'Role 2', 'Role 3'];

    // Set the roles
    try {
      var role = await client.setRoles('123', '1', ROLES);
      // Do something with the returned roles...
    } catch(err) {
      // Error handling...     
    }
```

```dart
// Get the roles by id
try {
var role = await client.getRolesById(
    null,
    '1');
    // Do something with roles...

    } catch(err) { // Error handling}
```

```dart
// Grant user a role
try {
var role = await client.grantRoles(
    null,
    '1',
    ['admin']);
    // Do something with roles...

    } catch(err) { // Error handling}

// Authorize user
try {
var role = await client.authorize(
    null,
    '1',
    ['admin']);
    // Do something with bool value(authorized or not authorized) ...

    } catch(err) { // Error handling}    
```

## Acknowledgements

This microservice was created and currently maintained by
- **Sergey Seroukhov**
- **Nuzhnykh Egor**.