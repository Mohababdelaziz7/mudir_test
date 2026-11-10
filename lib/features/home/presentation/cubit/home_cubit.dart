import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/usecases/get_home_data_usecase.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetHomeDataUseCase getHomeDataUseCase;
  int _homeRequestId = 0;

  HomeCubit({required this.getHomeDataUseCase}) : super(const HomeState());

  Future<void> loadHomeData() async {
    if (state.status == HomeStatus.loading) return;

    final currentRequestId = ++_homeRequestId;
    emit(state.copyWith(status: HomeStatus.loading));

    try {
      final bundle = await getHomeDataUseCase();
      if (isClosed || currentRequestId != _homeRequestId) return;

      emit(
        state.copyWith(
          status: HomeStatus.success,
          banners: bundle.banners,
          services: bundle.services,
          locations: bundle.locations,
          failure: null,
          errorMessage: null,
        ),
      );
    } on Failure catch (failure) {
      if (isClosed || currentRequestId != _homeRequestId) return;
      emit(
        state.copyWith(
          status: HomeStatus.failure,
          failure: failure,
          errorMessage: failure.message,
        ),
      );
    } catch (e) {
      if (isClosed || currentRequestId != _homeRequestId) return;
      final failure = Failure.fromException(
        e,
        'فشل في تحميل بيانات الصفحة الرئيسية. يرجى المحاولة مرة أخرى.',
      );
      emit(
        state.copyWith(
          status: HomeStatus.failure,
          failure: failure,
          errorMessage: failure.message,
        ),
      );
    }
  }

  Future<void> refreshHomeData() async {
    final currentRequestId = ++_homeRequestId;
    try {
      final bundle = await getHomeDataUseCase();
      if (isClosed || currentRequestId != _homeRequestId) return;

      emit(
        state.copyWith(
          status: HomeStatus.success,
          banners: bundle.banners,
          services: bundle.services,
          locations: bundle.locations,
          failure: null,
          errorMessage: null,
        ),
      );
    } on Failure catch (failure) {
      if (isClosed || currentRequestId != _homeRequestId) return;
      emit(
        state.copyWith(
          status: HomeStatus.failure,
          failure: failure,
          errorMessage: failure.message,
        ),
      );
    } catch (e) {
      if (isClosed || currentRequestId != _homeRequestId) return;
      final failure = Failure.fromException(e, 'فشل في تحديث البيانات.');
      emit(
        state.copyWith(
          status: HomeStatus.failure,
          failure: failure,
          errorMessage: failure.message,
        ),
      );
    }
  }
}
