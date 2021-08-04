import 'package:dartz/dartz.dart';
import 'package:numarket/core/domain/entities/user.dart';
import 'package:numarket/core/domain/errors/user_errors.dart';
import 'package:numarket/core/domain/repositories/users_repository_interface.dart';
import 'package:numarket/core/infra/adapters/graphql_adapter.dart';
import 'package:numarket/core/infra/repositories/models/customer_model.dart';

class UsersRepositoryGraphQL implements IUsersRepository {
  final IGraphQlAdapter client;
  UsersRepositoryGraphQL(this.client);

  @override
  Future<Either<SyncUserAccountError, User>> getCurrentUser() async{
    try{
      const document = r'''
      {
         viewer{
          name
          balance
          id
          offers{
            id
            price
            product{
              id
              name
              description
              image
            }
          }
      
        }
      }
    ''';
      Map response = await client.runQuery(document);
      Map customer = response['viewer'];
      var rtn = CustomerModel.fromMap(customer);
      return Right(rtn);
    }catch(e){
      return Left(SyncUserAccountError());
    }
  }
}
