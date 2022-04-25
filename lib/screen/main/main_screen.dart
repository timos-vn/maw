import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:maw/screen/home/home_bloc.dart';
import 'package:maw/screen/home/home_screen.dart';
import 'package:maw/screen/individual/individual_bloc.dart';
import 'package:maw/screen/individual/individual_screen.dart';
import 'package:maw/screen/map/map_bloc.dart';
import 'package:maw/screen/map/map_screen.dart';
import 'package:maw/screen/point/point_bloc.dart';
import 'package:maw/screen/point/point_screen.dart';
import 'package:maw/screen/shop/shop_bloc.dart';
import 'package:maw/screen/shop/shop_screen.dart';
import 'package:maw/themes/colors.dart';
import 'package:maw/utils/const.dart';
import 'package:maw/utils/utils.dart';
import 'package:maw/widgets/confirm_update_version.dart';
import 'package:maw/widgets/pending_action.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'main_bloc.dart';
import 'main_event.dart';
import 'main_state.dart';

class MainScreen extends StatefulWidget {

  final String? userName;
  final String? currentAddress;
  final int? rewardPoints;

  const MainScreen({Key? key,this.userName,this.currentAddress,this.rewardPoints}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainScreenState();
}


class _MainScreenState extends State<MainScreen> {
  late MainBloc _mainBloc;
  late HomeBloc _homeBloc;
  late ShopBloc _shopBloc;
  late MapBloc _mapBloc;
  late PointBloc _pointBloc;
  late IndividualBloc _individualBloc;

  PersistentTabController? _controller;

  int _lastIndexToShop = 0;
  int _currentIndex = 0;


  GlobalKey<NavigatorState>? _currentTabKey;
  late List<BottomNavigationBarItem> listBottomItems;
  final GlobalKey<NavigatorState> firstTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> secondTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> thirdTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> fourthTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> fifthTabNavKey = GlobalKey<NavigatorState>();

  void showUpdate(){
    showDialog(
        context: context,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: const ConfirmUpdateVersionPage(
              title: 'Đã có phiên bản mới',
              content: 'Cập nhật ứng dụng của bạn để có trải nghiệm tốt nhất',
              type: 0,
            ),
          );
        });
  }

  @override
  void initState() {
    _mainBloc = MainBloc();
    _homeBloc = HomeBloc();
    _shopBloc = ShopBloc();
    _mapBloc = MapBloc(context);
    _individualBloc = IndividualBloc();
    _pointBloc = PointBloc();
    _controller = PersistentTabController(initialIndex: 2);
    _currentTabKey = firstTabNavKey;
    _mainBloc.add(GetPrefs());
    // _mainBloc.add(GetVersionApp());
    // _mainBloc.add(GetListPromotionsEffectiveEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
          bool isSuccess = await _currentTabKey!.currentState!.maybePop();
          if (!isSuccess && _currentIndex != Const.HOME) {
            _lastIndexToShop = Const.HOME;
            _currentIndex = _lastIndexToShop;
            _currentTabKey = firstTabNavKey;
          }
          if (!isSuccess) _exitApp(context);
          return false;
      },
      child: Scaffold(
        body: MultiBlocProvider(
            providers: [
              BlocProvider<MainBloc>(
                create: (context) {
                  // ignore: unnecessary_null_comparison, prefer_conditional_assignment
                  if (_mainBloc == null) _mainBloc = MainBloc();
                  return _mainBloc;
                },
              ),
              BlocProvider<HomeBloc>(
                create: (context) {
                  // ignore: unnecessary_null_comparison, prefer_conditional_assignment
                  if (_homeBloc == null) _homeBloc = HomeBloc();
                  return _homeBloc;
                },
              ),
              BlocProvider<ShopBloc>(
                create: (context) {
                  // ignore: unnecessary_null_comparison, prefer_conditional_assignment
                  if (_shopBloc == null) _shopBloc = ShopBloc();
                  return _shopBloc;
                },
              ),
              BlocProvider<MapBloc>(
                create: (context) {
                  // ignore: unnecessary_null_comparison, prefer_conditional_assignment
                  if (_mapBloc == null) _mapBloc = MapBloc(context);
                  return _mapBloc;
                },
              ),
              BlocProvider<IndividualBloc>(
                create: (context) {
                  // ignore: unnecessary_null_comparison, prefer_conditional_assignment
                  if (_individualBloc == null) _individualBloc = IndividualBloc();
                  return _individualBloc;
                },
              ),
              BlocProvider<PointBloc>(
                create: (context) {
                  // ignore: unnecessary_null_comparison, prefer_conditional_assignment
                  if (_pointBloc == null) _pointBloc = PointBloc();
                  return _pointBloc;
                },
              ),
            ],
            child: BlocListener<MainBloc, MainState>(
              bloc: _mainBloc,
              listener: (context, state) {
                if (state is GetVersionGoLiveSuccess) {
                }else if(state is GetPrefsSuccess){
                  _mainBloc.add(GetLocationEvent());
                }
                else if(state is GetLisPromotionsSuccess){

                }
                if (state is LogoutSuccess) {
                  _lastIndexToShop = Const.HOME;
                  _currentIndex = _lastIndexToShop;
                  _currentTabKey = firstTabNavKey;
                }
                if (state is NavigateToNotificationState) {
                }
              },
              child: BlocBuilder<MainBloc, MainState>(
                bloc: _mainBloc,
                builder: (context, state) {
                  if (state is MainPageState) {
                    _currentIndex = state.position;
                    if (_currentIndex == Const.SHOP) {}
                    else if (_currentIndex == Const.HOME) {}
                    else if (_currentIndex == Const.MAP) {}
                  }
                  if (state is MainProfile) {
                    _currentTabKey = fifthTabNavKey;
                  }
                  _mainBloc.init(context);
                  return Stack(
                    children: [
                      PersistentTabView(
                        context,
                        controller: _controller,
                        screens: _buildScreens(),
                        items: _navBarsItems(),
                        confineInSafeArea: true,

                        handleAndroidBackButtonPress: true,
                        resizeToAvoidBottomInset: true,
                        stateManagement: true,
                        navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
                            ? 0.0
                            : kBottomNavigationBarHeight,
                        hideNavigationBarWhenKeyboardShows: true,
                        margin: const EdgeInsets.all(0.0),
                        popActionScreens: PopActionScreensType.all,
                        bottomScreenMargin: 0.0,
                        onWillPop: (context) async {
                          await showDialog(
                            context: context!,
                            useSafeArea: true,
                            builder: (context) => Container(
                              height: 50.0,
                              width: 50.0,
                              color: Colors.white,
                              child: ElevatedButton(
                                child: const Text("Close"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          );
                          return false;
                        },
                        selectedTabScreenContext: (context) {
                        },
                        hideNavigationBar: false,
                        backgroundColor: Colors.white,
                        decoration: const NavBarDecoration(
                          //border: Border.all(),
                            boxShadow: [
                              BoxShadow(color: Colors.grey, spreadRadius: 0.1),
                            ],
                            //colorBehindNavBar: Colors.indigo,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            )),
                        popAllScreensOnTapOfSelectedTab: true,
                        itemAnimationProperties: const ItemAnimationProperties(
                          duration: Duration(milliseconds: 400),
                          curve: Curves.ease,
                        ),
                        navBarStyle: NavBarStyle.style15, // Choose the nav bar style with this property
                      ),
                      Visibility(
                        visible: state is MainLoading,
                        child: PendingAction(),
                      )
                    ],
                  );
                },
              ),
            )),
      ),
    );
  }

  List<Widget> _buildScreens() {
    return [
      const ShopScreen(),
      const MapScreen(),
      const HomeScreen(),
      const PointScreen(),
      const IndividualScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.storefront),
        title: "Shop",
        activeColorPrimary: Colors.purple,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.purple,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(MdiIcons.map),
        title: "Bản đồ nước",

        activeColorPrimary: Colors.purple,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.purple,
      ),
      PersistentBottomNavBarItem(
        inactiveColorSecondary: mainColor,
        icon: const Icon(Icons.home),
        title: (" "),
        activeColorPrimary: mainColor,
        activeColorSecondary: Colors.white,
        inactiveColorPrimary: Colors.grey,
        // onPressed: (context) {
        //   pushDynamicScreen(context,
        //       screen: SampleModalScreen(), withNavBar: true);
        // }
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.how_to_vote),
        title: ("Tích điểm"),
        activeColorPrimary: Colors.deepOrange,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(MdiIcons.accountCircle),
        title: ("Cá nhân"),
        activeColorPrimary: Colors.deepOrange,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  void _exitApp(BuildContext context) {
    List<Widget> actions = [
      FlatButton(
        onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
        child: Text('No'.tr,
            style:
                 const TextStyle(
              color: Colors.orange,
              fontSize: 14,
            )),
      ),
      FlatButton(
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pop();
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        },
        child: Text(
          'Yes'.tr,
          style:const TextStyle(
            color: Colors.orange,
            fontSize: 14,)
        ),
      )
    ];

    Utils.showDialogTwoButton(
        context: context,
        title: 'Notice'.tr,
        contentWidget: Text(
          'ExitApp'.tr,
          style:const TextStyle(fontSize: 16.0)),
        actions: actions);
  }
}
