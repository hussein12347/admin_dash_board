part of 'get_rate_cubit.dart';

@immutable
sealed class GetCommentsState {}

final class GetCommentsInitial extends GetCommentsState {}



final class AddRepliesLoading extends GetCommentsState {}
final class AddRepliesSuccess extends GetCommentsState {}
final class AddRepliesError extends GetCommentsState {}

final class GetCommentsLoading extends GetCommentsState {}
final class GetCommentsSuccess extends GetCommentsState {
  List<CommentModel>comments;
  GetCommentsSuccess({required this.comments});
}
final class GetCommentsError extends GetCommentsState {}
