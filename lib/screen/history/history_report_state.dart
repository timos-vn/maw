import 'package:equatable/equatable.dart';

abstract class HistoryReportState extends Equatable {
  @override
  List<Object> get props => [];
}
class InitialHistoryReportState extends HistoryReportState {

  @override
  String toString() {
    return 'InitialHistoryReportState{}';
  }
}

class GetPrefsSuccess extends HistoryReportState{

  @override
  String toString() {
    return 'GetPrefsSuccess{}';
  }
}

class HistoryReportLoading extends HistoryReportState {

  @override
  String toString() => 'HistoryReportLoading';
}
