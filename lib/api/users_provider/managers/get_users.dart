import 'package:placeholder_app/api/base/base_provider.dart';
import 'package:placeholder_app/api/base/provider_response.dart';
import 'package:placeholder_app/api/users_provider/requests/get_users.dart';
import 'package:placeholder_app/data/user/parser.dart';
import 'package:placeholder_app/data/user/user.dart';
import 'package:placeholder_app/screens/users_screen/bloc/users_screen_bloc.dart';

class GetUsersNetManager extends CacheableNetManager implements GetUsersRepo {
  @override
  Future<ProviderResponse<List<User>>> getUsers() async {
    final request = GetUsersRequest();
    final response = await fetch(request);
    if(response.isFail()) {
      return response.unType();
    }
    final users = (response.content as List).map((json) => UserParser.parse(Map<String, dynamic>.from(json)));

    return response.assignContent(users.toList());
  }
}