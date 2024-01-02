import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/export_entities.dart';
import '../../../../domain/usecases/movie/movie_usecases.dart';

part 'get_movie_credits_state.dart';

class GetMovieCreditsCubit extends Cubit<GetMovieCreditsState> {
  GetMovieCreditsCubit(this._movieUsecases) : super(const GetMovieCreditsInitial());

  Future<void> getMovieCredits({required int movieId}) async {
    emit(const GetMovieCreditsLoading());

    final result = await _movieUsecases.getMovieCredits(movieId: movieId);

    result.fold(
      (failure) => emit(const GetMovieCreditsError()),
      (movieCreditEntity) => emit(GetMovieCreditsLoaded(movieCreditEntity)),
    );
  }

  final MovieUsecases _movieUsecases;
}