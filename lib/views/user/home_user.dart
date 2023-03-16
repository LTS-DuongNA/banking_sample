import 'package:bank_application/views/user/bought_list.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:bank_application/api/api_repository.dart';
import 'package:bank_application/utils/expansion_panel_fix.dart';
import 'package:bank_application/views/admin/scan_overview.dart';
import 'package:bank_application/views/admin/scan_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../consts/images/image_path.dart';
import '../../../viewmodels/home_viewmodel.dart';
import '../../consts/colors/colors.dart';
import '../../model/listdata_model.dart';
import '../../service/ocr_service.dart';
import '../../utils/alert.dart';
import '../../utils/exit_app_scope.dart';
import '../../utils/observable_serivce.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';

class HomeViewUser extends StatefulWidget {
  const HomeViewUser({super.key});

  @override
  HomeViewUserState createState() => HomeViewUserState();
}

class HomeViewUserState extends State<HomeViewUser> {
  final ObservableService _observableService = ObservableService();
  final HomeViewModel _homeViewModel = HomeViewModel();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  StreamSubscription<String?>? apiResponseListener;
  final ScrollController _scrollController = ScrollController();
  StreamSubscription<List<ListSaveModel>?>? apiLeaveListListener = null;
  APIRepository aPIRepositoryImpl = APIRepositoryImpl();

  double _scrollPercent = 100.0;
  final List<bool> _expand = [];

  @override
  void initState() {
    _expand.add(false);
    listenToAPIResponse();
    super.initState();

    //set orientation is landscape
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _homeViewModel.getListSave();
      _scrollController.addListener(() {
        _expand[0] = false;
        setState(() {});

        // double currentScroll = _scrollController.position.pixels;
        // if (currentScroll < 80) {
        //   _scrollPercent = 80 - currentScroll;
        // } else {
        //   _scrollPercent = 20;
        // }
        // setState(() {});
      });
    });
  }

  void listenToAPIResponse() {
    apiResponseListener ??= _observableService.showAlertStream.asBroadcastStream().listen((data) {
      setState(() {});
      showDialog(context: context, builder: (context) => ErrorAlert.alert(context, data.toString()));
    });
    apiLeaveListListener ??= _observableService.listSaveStream.asBroadcastStream().listen((data) {
      if (data != null) {
        _homeViewModel.getListData(data);
        print('aaaaa;${_homeViewModel.listData}');
        if (!mounted) {
          return;
        }
        setState(() {});
      } else {}
    });
  }

  @override
  void dispose() {
    apiResponseListener?.cancel();
    apiResponseListener?.cancel();

    super.dispose();
  }

  Widget getExpandedBody() {
    return Container(
      // height: 70,
      color: Colors.blueAccent,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 70,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 8),
            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            decoration: BoxDecoration(
              color: ColorStyle.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 2,
                  offset: Offset(0, 4), // Shadow position
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Nguyễn Anh Dương",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "21710000807060",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 36),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: ColorStyle.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 2,
                  offset: Offset(0, 4), // Shadow position
                ),
              ],
            ),
            child: Text(
              "Số dư: xxx.000.000.000",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(height: 8),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: ColorStyle.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 2,
                  offset: Offset(0, 4), // Shadow position
                ),
              ],
            ),
            child: Text(
              "Điểm thưởng",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(height: 8),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: ColorStyle.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 2,
                  offset: Offset(0, 4), // Shadow position
                ),
              ],
            ),
            child: Text(
              "Thẻ",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(height: 8),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: ColorStyle.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 2,
                  offset: Offset(0, 4), // Shadow position
                ),
              ],
            ),
            child: Text(
              "Tài khoản tiền gửi số",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(height: 8),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: ColorStyle.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 2,
                  offset: Offset(0, 4), // Shadow position
                ),
              ],
            ),
            child: Text(
              "Khoản vay",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: BOHT: Giam size text (Bao hiem y te / Bao hiem o to / ...)
    return ExitAppScope(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: ColorStyle.white,
        body: Column(
          children: [

            SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  getExpandedBody(),
                  otherComponent(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget otherComponent() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16),
          child: Row(
            children: const [
              Text(
                "Bảo hiểm đã mua",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              Text(
                "Tùy chỉnh",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        GridView.count(
          shrinkWrap: true,
          childAspectRatio: (1 / .7),
          primary: false,
          padding: const EdgeInsets.all(10),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 3,
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(
                      builder: (_) {
                        return ListBought();
                      },
                      settings: RouteSettings(
                        name: 'ListBought',
                      ),
                    ))
                    .then((value) => () {
                          print("ListBought closed");
                        });
              },
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Icon(
                        size: 40,
                        Icons.health_and_safety,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Bảo hiểm xe hơi", style: TextStyle(fontSize: 12)),
                      )
                    ],
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      height: 20,
                      width: 35,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Text(
                          "Mới",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(
                      size: 40,
                      Icons.sports_motorsports,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Bảo hiểm mô tô", style: TextStyle(fontSize: 12)),
                    )
                  ],
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    height: 20,
                    width: 35,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text(
                        "Mới",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(
                      size: 40,
                      Icons.car_crash,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Bảo hiểm nhân thọ",
                        style: TextStyle(fontSize: 12),
                      ),
                    )
                  ],
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    height: 20,
                    width: 35,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text(
                        "Mới",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(
                      size: 40,
                      Icons.safety_check,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Bảo hiểm y tế", style: TextStyle(fontSize: 12)),
                    )
                  ],
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    height: 20,
                    width: 35,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text(
                        "Mới",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(
                      size: 40,
                      Icons.dangerous,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Khác", style: TextStyle(fontSize: 12)),
                    )
                  ],
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    height: 20,
                    width: 35,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text(
                        "Mới",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        )
      ],
    );
  }
}
