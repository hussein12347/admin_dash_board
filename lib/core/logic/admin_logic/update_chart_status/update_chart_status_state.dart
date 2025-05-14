part of 'update_chart_status_cubit.dart';

@immutable
sealed class EditChartStatusState {}

final class UpdateChartStatusInitial extends EditChartStatusState {}


final class UpdateChartStatusLoading extends EditChartStatusState {}
final class UpdateChartStatusSuccess extends EditChartStatusState {}
final class UpdateChartStatusError extends EditChartStatusState {

  String errorMessage;
  UpdateChartStatusError(this.errorMessage);
}
