import 'package:dartz/dartz.dart';
import 'package:olofooto/core/errors/failure.dart';

/// either [Failure] or [T] type we have given
typedef ResultFuture<T> = Future<Either<Failure, T>>;

/// either [Failure] or [void]
typedef ResultVoid = Future<Either<Failure, void>>;

/// typical [Map<String,dynamic>]
typedef DataMap = Map<String, dynamic>;
