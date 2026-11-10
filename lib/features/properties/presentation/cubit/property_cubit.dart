import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/app_logger.dart';
import '../../domain/usecases/get_properties_usecase.dart';
import '../../domain/usecases/toggle_like_property_usecase.dart';
import '../../domain/usecases/toggle_starred_property_usecase.dart';
import 'property_state.dart';

class PropertyCubit extends Cubit<PropertyState> {
  final GetPropertiesUseCase getPropertiesUseCase;
  final ToggleLikePropertyUseCase toggleLikePropertyUseCase;
  final ToggleStarredPropertyUseCase toggleStarredPropertyUseCase;

  int _loadRequestId = 0;

  PropertyCubit({
    required this.getPropertiesUseCase,
    required this.toggleLikePropertyUseCase,
    required this.toggleStarredPropertyUseCase,
  }) : super(const PropertyState());

  Future<void> loadProperties() async {
    if (state.status == PropertyStatus.loading) return;

    final currentRequestId = ++_loadRequestId;
    emit(state.copyWith(status: PropertyStatus.loading));

    try {
      final bundle = await getPropertiesUseCase();
      if (isClosed || currentRequestId != _loadRequestId) return;

      final isEmpty =
          bundle.auctions.isEmpty &&
          bundle.featured.isEmpty &&
          bundle.recommended.isEmpty;

      emit(
        state.copyWith(
          status: isEmpty ? PropertyStatus.empty : PropertyStatus.success,
          auctions: bundle.auctions,
          featuredProperties: bundle.featured,
          recommendedProperties: bundle.recommended,
          nearbyProperties: bundle.nearby,
          likedIds: bundle.likedIds,
          starredIds: bundle.starredIds,
          failure: null,
          errorMessage: null,
        ),
      );
    } on Failure catch (failure) {
      if (isClosed || currentRequestId != _loadRequestId) return;
      emit(
        state.copyWith(
          status: PropertyStatus.failure,
          failure: failure,
          errorMessage: failure.message,
        ),
      );
    } catch (e) {
      if (isClosed || currentRequestId != _loadRequestId) return;
      final failure = Failure.fromException(
        e,
        'فشل في تحميل بيانات العقارات. يرجى المحاولة مرة أخرى.',
      );
      emit(
        state.copyWith(
          status: PropertyStatus.failure,
          failure: failure,
          errorMessage: failure.message,
        ),
      );
    }
  }

  void setListingType({required bool isForSale}) {
    if (state.isForSale == isForSale) return;
    emit(state.copyWith(isForSale: isForSale));
  }

  void selectCategory(int index) {
    if (index < 0 || index >= PropertyState.categories.length) return;
    if (state.selectedCategoryIndex == index) return;
    emit(state.copyWith(selectedCategoryIndex: index));
  }

  void updateSearchQuery(String query) {
    final trimmed = query.trim();
    if (state.searchQuery == trimmed) return;
    emit(state.copyWith(searchQuery: trimmed));
  }

  Future<void> toggleLike(String propertyId) async {
    final wasLiked = state.isLiked(propertyId);
    final targetLiked = !wasLiked;

    final updatedLiked = _toggleSetMember(
      state.likedIds,
      propertyId,
      targetLiked,
    );
    emit(state.copyWith(likedIds: updatedLiked));

    try {
      await toggleLikePropertyUseCase(propertyId);
    } catch (e) {
      if (isClosed) return;
      AppLogger.error('Failed to toggle like on property $propertyId', e);
      _rollbackSetMember(
        targetValue: targetLiked,
        propertyId: propertyId,
        getCurrentSet: () => state.likedIds,
        onRollback: (reverted) => emit(state.copyWith(likedIds: reverted)),
      );
    }
  }

  Future<void> toggleStarred(String propertyId) async {
    final wasStarred = state.isStarred(propertyId);
    final targetStarred = !wasStarred;

    final updatedStarred = _toggleSetMember(
      state.starredIds,
      propertyId,
      targetStarred,
    );
    emit(state.copyWith(starredIds: updatedStarred));

    try {
      await toggleStarredPropertyUseCase(propertyId);
    } catch (e) {
      if (isClosed) return;
      AppLogger.error('Failed to toggle starred on property $propertyId', e);
      _rollbackSetMember(
        targetValue: targetStarred,
        propertyId: propertyId,
        getCurrentSet: () => state.starredIds,
        onRollback: (reverted) => emit(state.copyWith(starredIds: reverted)),
      );
    }
  }

  Set<String> _toggleSetMember(
    Set<String> source,
    String id,
    bool shouldInclude,
  ) {
    final copy = Set<String>.from(source);
    if (shouldInclude) {
      copy.add(id);
    } else {
      copy.remove(id);
    }
    return copy;
  }

  void _rollbackSetMember({
    required bool targetValue,
    required String propertyId,
    required Set<String> Function() getCurrentSet,
    required void Function(Set<String>) onRollback,
  }) {
    final current = Set<String>.from(getCurrentSet());
    if (targetValue && current.contains(propertyId)) {
      current.remove(propertyId);
      onRollback(current);
    } else if (!targetValue && !current.contains(propertyId)) {
      current.add(propertyId);
      onRollback(current);
    }
  }
}
