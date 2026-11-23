
import 'package:clean_app/core/error/exceptions.dart';
import 'package:clean_app/core/error/failures.dart';

abstract class BaseRepository {
  Failure handleError(Object error) {
    return switch(error) {
      ServerExceptions(:final message) => ServerFailure(message),
      NetworkExceptions(:final message) => NetworkFailure(message),
      _ => ServerFailure('An unexpected error occurred.')
    };
  }
}