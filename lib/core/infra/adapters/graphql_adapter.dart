import 'package:graphql/client.dart';

abstract class IGraphQlAdapter {
  Future<Map> runQuery(String document) {}
  Future<Map> runMutation(String document) {}
}

class GraphQlAdapter implements IGraphQlAdapter {
  GraphQLClient _client;

  static final GraphQlAdapter _instance = GraphQlAdapter.internal();
  factory GraphQlAdapter() => _instance;
  GraphQlAdapter.internal();

  GraphQLClient get client {
    if (_client != null) {
      return _client;
    } else {
      return connect();
    }
  }

  set client(GraphQLClient gqlClient) {
    _client = gqlClient;
  }

  connect() {
    final httpLink = HttpLink(
      "https://staging-nu-needful-things.nubank.com.br/query",
    );
    final authLink = AuthLink(
      getToken: () =>
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhd2Vzb21lY3VzdG9tZXJAZ21haWwuY29tIn0.cGT2KqtmT8KNIJhyww3T8fAzUsCD5_vxuHl5WbXtp8c',
    );
    Link link = authLink.concat(httpLink);
    _client =  GraphQLClient(
      link: link,
      cache: GraphQLCache()
    );
    return _client;
  }

  @override
  Future<Map> runQuery(String document) async {
    if (this.client == null || document == null) {
      return null;
    }
    final QueryResult result = await client.query(QueryOptions(document: gql(document)));

    if (result.hasException) {
      throw result.exception;
    }

    return result.data;
  }

  @override
  Future<Map> runMutation(String document) async {
    if (this.client == null || document == null) {
      return null;
    }
    final QueryResult result = await client.mutate(MutationOptions(document: gql(document)));

    if (result.hasException) {
      throw result.exception;
    }

    return result.data;
  }
}
