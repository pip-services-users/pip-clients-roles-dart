import 'package:pip_services3_components/pip_services3_components.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';

import '../version1/RolesNullClientV1.dart';
import '../version1/RolesDirectClientV1.dart';
import '../version1/RolesHttpClientV1.dart';

class RolesClientFactory extends Factory {
  static final NullClientDescriptor =
      Descriptor('pip-services-roles', 'client', 'null', '*', '1.0');
  static final DirectClientDescriptor =
      Descriptor('pip-services-roles', 'client', 'direct', '*', '1.0');
  static final HttpClientDescriptor =
      Descriptor('pip-services-roles', 'client', 'http', '*', '1.0');

  RolesClientFactory() : super() {
    registerAsType(RolesClientFactory.NullClientDescriptor, RolesNullClientV1);
    registerAsType(
        RolesClientFactory.DirectClientDescriptor, RolesDirectClientV1);
    registerAsType(RolesClientFactory.HttpClientDescriptor, RolesHttpClientV1);
  }
}
