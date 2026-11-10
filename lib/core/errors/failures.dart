import 'package:equatable/equatable.dart';

import 'exceptions.dart';

abstract class Failure extends Equatable {
  final String message;
  final int? statusCode;

  const Failure({required this.message, this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];

  factory Failure.fromException(Object error, [String? fallbackMessage]) {
    if (error is Failure) {
      return error;
    } else if (error is NetworkException) {
      return NetworkFailure(
        message:
            error.message.isNotEmpty &&
                error.message != 'No internet connection'
            ? error.message
            : 'لا يوجد اتصال بالإنترنت. يرجى التحقق من الشبكة وإعادة المحاولة.',
      );
    } else if (error is ServerException) {
      return ServerFailure(
        message: error.message.isNotEmpty
            ? error.message
            : (fallbackMessage ?? 'حدث خطأ في الخادم. يرجى المحاولة لاحقاً.'),
        statusCode: error.statusCode,
      );
    } else if (error is CacheException) {
      return CacheFailure(
        message: error.message.isNotEmpty
            ? error.message
            : (fallbackMessage ?? 'فشل في استرجاع البيانات المحفوظة.'),
      );
    }
    return ServerFailure(
      message: fallbackMessage ?? 'حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى.',
    );
  }
}

class ServerFailure extends Failure {
  const ServerFailure({
    super.message = 'حدث خطأ في الخادم. يرجى المحاولة لاحقاً.',
    super.statusCode,
  });
}

class CacheFailure extends Failure {
  const CacheFailure({super.message = 'فشل في استرجاع البيانات المحفوظة.'});
}

class NetworkFailure extends Failure {
  const NetworkFailure({
    super.message =
        'لا يوجد اتصال بالإنترنت. يرجى التحقق من الشبكة وإعادة المحاولة.',
  });
}

class ValidationFailure extends Failure {
  const ValidationFailure({super.message = 'البيانات المدخلة غير صحيحة.'});
}
