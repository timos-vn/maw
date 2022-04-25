import 'package:equatable/equatable.dart';

abstract class HistoryReportEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetPrefs extends HistoryReportEvent {
  @override
  String toString() => 'GetPrefs';
}
