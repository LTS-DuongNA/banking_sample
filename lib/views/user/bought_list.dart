import 'package:flutter/material.dart';

import 'bought_detail.dart';

class ListBought extends StatefulWidget {
  const ListBought({super.key});

  @override
  ListBoughtState createState() => ListBoughtState();
}

class ListBoughtState extends State<ListBought> {
  bool isSelectionMode = false;
  final int listLength = 30;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Danh sách bảo hiểm đã mua',
          ),
        ),
        body: ListView.builder(
            itemCount: listLength,
            itemBuilder: (_, int index) {
              return ListTile(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                    builder: (_) {
                      return BoughtDetail();
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
                  'item $index',
                ),
              );
            }));
  }
}
