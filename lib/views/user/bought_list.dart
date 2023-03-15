import 'dart:async';

import 'package:flutter/material.dart';

import '../../model/listdata_model.dart';
import '../../utils/observable_serivce.dart';
import '../../viewmodels/home_viewmodel.dart';
import 'bought_detail.dart';

class ListBought extends StatefulWidget {
  const ListBought({super.key});

  @override
  ListBoughtState createState() => ListBoughtState();
}

class ListBoughtState extends State<ListBought> {
  bool isSelectionMode = false;
  final int listLength = 30;
  final HomeViewModel _homeViewModel = HomeViewModel();
  final ObservableService _observableService = ObservableService();
  StreamSubscription<List<ListSaveModel>?>? apiLeaveListListener = null;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // _homeViewModel.getListSave();
    });
    super.initState();
  }

  @override
  void dispose() {
    apiLeaveListListener?.cancel();
    super.dispose();
  }

  // void listener() {
  //   apiLeaveListListener ??= _observableService.listSaveStream.asBroadcastStream().listen((data) {
  //     if (data != null) {
  //       _homeViewModel.getListData(data);
  //       if (!mounted) {
  //         return;
  //       }
  //       setState(() {});
  //     } else {}
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Danh sách bảo hiểm đã mua',
          ),
        ),
        body: ListView.builder(
            itemCount: _homeViewModel.listData.length,
            itemBuilder: (_, int index) {
              final item = _homeViewModel.listData.toList()[index];
              return ListTile(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                        builder: (_) {
                          return BoughtDetail(
                            dataDetail: item,
                          );
                        },
                        settings: RouteSettings(
                          name: 'BoughtDetail',
                        ),
                      ))
                      .then((value) => () {
                            print("BoughtDetail closed");
                          });
                },
                title: Text(
                  'item ${index}',
                ),
              );
            }));
  }
}
