import 'package:clean_app/core/result/result.dart';

//Base Class
abstract class UseCase<TResult, Params> {
  Future<Result<TResult>> call(Params params);
}

class NoParams {
  const NoParams();
}