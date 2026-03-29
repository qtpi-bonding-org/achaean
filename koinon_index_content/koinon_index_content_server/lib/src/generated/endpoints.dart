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
import '../endpoints/koinon_content_endpoint.dart' as _i2;
import 'package:koinon_index_core_server/koinon_index_core_server.dart' as _i3;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'koinonContent': _i2.KoinonContentEndpoint()
        ..initialize(
          server,
          'koinonContent',
          'koinon_index_content',
        ),
    };
    connectors['koinonContent'] = _i1.EndpointConnector(
      name: 'koinonContent',
      endpoint: endpoints['koinonContent']!,
      methodConnectors: {
        'getAgora': _i1.MethodConnector(
          name: 'getAgora',
          params: {
            'polisRepoUrl': _i1.ParameterDescription(
              name: 'polisRepoUrl',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['koinonContent'] as _i2.KoinonContentEndpoint)
                      .getAgora(
                        session,
                        params['polisRepoUrl'],
                        limit: params['limit'],
                        offset: params['offset'],
                      ),
        ),
        'getPersonalFeed': _i1.MethodConnector(
          name: 'getPersonalFeed',
          params: {
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['koinonContent'] as _i2.KoinonContentEndpoint)
                      .getPersonalFeed(
                        session,
                        limit: params['limit'],
                        offset: params['offset'],
                      ),
        ),
        'getThread': _i1.MethodConnector(
          name: 'getThread',
          params: {
            'rootPostUrl': _i1.ParameterDescription(
              name: 'rootPostUrl',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['koinonContent'] as _i2.KoinonContentEndpoint)
                      .getThread(
                        session,
                        params['rootPostUrl'],
                      ),
        ),
        'getFlagsForPolis': _i1.MethodConnector(
          name: 'getFlagsForPolis',
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
              ) async =>
                  (endpoints['koinonContent'] as _i2.KoinonContentEndpoint)
                      .getFlagsForPolis(
                        session,
                        params['polisRepoUrl'],
                      ),
        ),
        'getFlaggedPostsForVouchers': _i1.MethodConnector(
          name: 'getFlaggedPostsForVouchers',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['koinonContent'] as _i2.KoinonContentEndpoint)
                      .getFlaggedPostsForVouchers(session),
        ),
      },
    );
    modules['koinon_index_core'] = _i3.Endpoints()..initializeEndpoints(server);
  }
}
