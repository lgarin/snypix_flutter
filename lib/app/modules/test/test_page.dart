import 'package:flutter/material.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  TestPageState createState() => TestPageState();
}

class TestPageState extends State<TestPage> {
  static const delay = Duration(seconds: 2);

  int _itemCount = 0;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void onRefresh() async {
    await Future.delayed(delay);
    setState(() {
      _itemCount = 20;
    });
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    await Future.delayed(delay);
    setState(() {
      _itemCount += 20;
    });
    refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SmartRefresher(
        header: const WaterDropMaterialHeader(),
        controller: refreshController,
        enablePullDown: true,
        enablePullUp: true,
        onRefresh: onRefresh,
        onLoading: onLoading,
        footer: CustomFooter(
          builder: _buildFooter,
        ),
        child: _buildContent(),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Pull to Refresh'),
    );
  }

  Widget _buildContent() {
    return _buildList(_itemCount);
  }

  ListView _buildList(int itemCount) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text('Item $index'),
        );
      },
    );
  }

  Widget _buildFooter(BuildContext context, LoadStatus? mode) {
    Widget body;
    if (mode == LoadStatus.idle) {
      body = const Text("pull up to load more");
    } else if (mode == LoadStatus.loading) {
      body = const CircularProgressIndicator();
    } else if (mode == LoadStatus.failed) {
      body = const Text("Load Failed! Click retry!");
    } else if (mode == LoadStatus.canLoading) {
      body = const Text("release to load more");
    } else {
      body = const Text("No more Data");
    }
    return SizedBox(
      height: 55.0,
      child: Center(child: body),
    );
  }
}
