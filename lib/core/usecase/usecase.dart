// to follow the clean architecture principle(I think so)
// ignore_for_file: one_member_abstracts

import 'package:olofooto/core/utils/typedefs.dart';

abstract interface class UsecasesWithParams<T, Params> {
  ResultFuture<T> call(Params params);
}

abstract interface class UsecasesWithoutParams<T> {
  ResultFuture<T> call();
}
