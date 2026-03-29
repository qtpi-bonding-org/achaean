/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../endpoints/koinon_core_endpoint.dart' as _i2;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'koinonCore': _i2.KoinonCoreEndpoint()
        ..initialize(
          server,
          'koinonCore',
          'koinon_index_core',
        ),
    };
    connectors['koinonCore'] = _i1.EndpointConnector(
      name: 'koinonCore',
      endpoint: endpoints['koinonCore']!,
      methodConnectors: {
        'register': _i1.MethodConnector(
          name: 'register',
          params: {
            'repoUrl': _i1.ParameterDescription(
              name: 'repoUrl',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['koinonCore'] as _i2.KoinonCoreEndpoint).register(
                    session,
                    params['repoUrl'],
                  ),
        ),
        'getUser': _i1.MethodConnector(
          name: 'getUser',
          params: {
            'pubkey': _i1.ParameterDescription(
              name: 'pubkey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['koinonCore'] as _i2.KoinonCoreEndpoint).getUser(
                    session,
                    params['pubkey'],
                  ),
        ),
        'getRelationships': _i1.MethodConnector(
          name: 'getRelationships',
          params: {
            'pubkey': _i1.ParameterDescription(
              name: 'pubkey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['koinonCore'] as _i2.KoinonCoreEndpoint)
                  .getRelationships(
                    session,
                    params['pubkey'],
                  ),
        ),
        'listPoleis': _i1.MethodConnector(
          name: 'listPoleis',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['koinonCore'] as _i2.KoinonCoreEndpoint)
                  .listPoleis(session),
        ),
        'getPolis': _i1.MethodConnector(
          name: 'getPolis',
          params: {
            'repoUrl': _i1.ParameterDescription(
              name: 'repoUrl',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['koinonCore'] as _i2.KoinonCoreEndpoint).getPolis(
                    session,
                    params['repoUrl'],
                  ),
        ),
        'getPolisMembers': _i1.MethodConnector(
          name: 'getPolisMembers',
          params: {
            'polisRepoUrl': _i1.ParameterDescription(
              name: 'polisRepoUrl',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['koinonCore'] as _i2.KoinonCoreEndpoint)
                  .getPolisMembers(
                    session,
                    params['polisRepoUrl'],
                  ),
        ),
      },
    );
  }
}
