import 'package:equatable/equatable.dart';

abstract class MainEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class NavigateBottomNavigation extends MainEvent {
  final int position;

  NavigateBottomNavigation(this.position);

  @override
  String toString() => 'NavigateBottomNavigation: $position';
}

class NavigateProfile extends MainEvent {

  @override
  String toString() => 'NavigateProfile';
}

class GetVersionApp extends MainEvent {

  @override
  String toString() => 'GetVersionApp';
}

class UpdateVersionApp extends MainEvent {

  @override
  String toString() => 'UpdateVersionApp';
}

class GetCountNotificationUnRead extends MainEvent{
  final bool isRefresh;

  GetCountNotificationUnRead({this.isRefresh = false});
  @override
  String toString() {
    return 'GetCountNotificationUnRead{isRefresh: $isRefresh}';
  }
}


class ImmediateLogOut extends MainEvent {
  ImmediateLogOut();

  @override
  String toString() => 'ImmediateLogOut';
}

class GetDataEvent extends MainEvent {

  @override
  String toString() {
    return 'GetDataEvent{}';
  }
}

class GetLocationEvent extends MainEvent {

  @override
  String toString() => 'UpdateStatusDriverEvent {}';
}

class GetCountProduct extends MainEvent{

  final int count ;

  GetCountProduct(this.count);

  @override
  String toString() {
    return 'GetCountProduct{count: $count}';
  }
}

class GetPermissionEvent extends MainEvent {

  @override
  String toString() {
    return 'GetPermissionEvent{}';
  }
}

class GetListPromotionsEffectiveEvent extends MainEvent{
  final bool isRefresh;
  final bool isLoadMore;

  GetListPromotionsEffectiveEvent({this.isRefresh = false, this.isLoadMore = false});
  @override
  String toString() {
    return 'GetListPromotionsEffectiveEvent{isRefresh: $isRefresh, isLoadMore: $isLoadMore}';
  }
}

class LogoutMainEvent extends MainEvent {

  @override
  String toString() {
    return 'LogoutMainEvent{}';
  }
}

class RefreshMain extends MainEvent{
  @override
  String toString() {
    return 'RefreshMain{}';
  }
}

class NavigateToPay extends MainEvent{
  @override
  String toString() {
    // TODO: implement toString
    return 'NavigateToPay{}';
  }
}

class NavigateToNotification extends MainEvent{
  @override
  String toString() {
    // TODO: implement toString
    return 'NavigateToNotification{}';
  }
}

class GetCountApprovalEvent extends MainEvent {
  @override
  String toString() => 'GetCountApprovalEvent {}';
}

class SetEvent extends MainEvent {
  final String unitName;
  final String storeName;
  final String userName;
  final List<String> listInfoUnitsID;
  final List<String> listInfoUnitsName;
  final String currentCompanyID;
  final String currentCompanyName;

  SetEvent(this.unitName,this.storeName,this.userName,this.listInfoUnitsID,this.listInfoUnitsName,this.currentCompanyID,this.currentCompanyName);
  @override
  String toString() => 'SetEvent {}';
}

class GetCountNotiSMS extends MainEvent{
  final bool isRefresh;

  GetCountNotiSMS({this.isRefresh = false});
  @override
  String toString() {
    return 'GetCountNotiSMS{isRefresh: $isRefresh}';
  }
}

class GetPrefs extends MainEvent {
  @override
  String toString() => 'GetPrefs';
}
