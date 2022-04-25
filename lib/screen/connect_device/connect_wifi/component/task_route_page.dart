import 'dart:async';
import 'package:esptouch_smartconfig/esptouch_smartconfig.dart';
import 'package:flutter/material.dart';
import 'package:maw/themes/colors.dart';

class TaskRoute extends StatefulWidget {
  const TaskRoute(
      this.ssid, this.bssid, this.password, this.deviceCount, this.isBroadcast, {Key? key}) : super(key: key);
  final String ssid;
  final String bssid;
  final String password;
  final String deviceCount;
  final bool isBroadcast;
  @override
  State<StatefulWidget> createState() {
    return TaskRouteState();
  }
}

class TaskRouteState extends State<TaskRoute> {
  late Stream<ESPTouchResult>? _stream;

  @override
  void initState() {
    _stream = EsptouchSmartconfig.run(
        ssid: widget.ssid,
        bssid: widget.bssid,
        password: widget.password,
        deviceCount: widget.deviceCount,
        isBroad: widget.isBroadcast);
    _stream?.listen((event) {
      // ignore: unnecessary_null_comparison
      if(event.ip != null){
        Navigator.pop(context,['Connected']);
      }
    });
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  Widget waitingState(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.red),
          ),
          SizedBox(height: 16),
          Text(
            'Đang kết nối tới thiết bị....',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget error(BuildContext context, String s) {
    return Center(
      child: Text(
        s,
        style: const TextStyle(color: Colors.red),
      ),
    );
  }

  Widget noneState(BuildContext context) {
    return const Center(
        child: Text(
      'Kết nối thất bại. Vui lòng thử lại',
      style: TextStyle(fontSize: 18),
    ));
  }

  Widget resultList(BuildContext context, ConnectionState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _results.length,
            itemBuilder: (_, index) {
              final result = _results.toList(growable: false)[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        const Text('BSSID: '),
                        Text(result.bssid),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        const Text('IP: '),
                        Text(result.ip),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
        if (state == ConnectionState.active)
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.red),
          ),
      ],
    );
  }

  final Set<ESPTouchResult> _results = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back,color: Colors.white,),
            onPressed: () {
              Navigator.of(context).pop(_results);
            }),
        backgroundColor: mainColor,
        title: Text(
          'Connect to wifi'.toUpperCase(),style:const TextStyle(color: Colors.white),
        ),
      ),
      body: StreamBuilder<ESPTouchResult>(
        stream: _stream,
        builder: (context, AsyncSnapshot<ESPTouchResult> snapshot) {
          if (snapshot.hasError) {
            return error(context, 'Có lỗi xảy ra. Vui lòng thử lại');
          }
          switch (snapshot.connectionState) {
            case ConnectionState.active:
              _results.add(snapshot.data!);
              return resultList(context, ConnectionState.active);
            case ConnectionState.none:
              return noneState(context);
            case ConnectionState.done:
              if (snapshot.hasData) {
                _results.add(snapshot.data!);
                return resultList(context, ConnectionState.done);
              } else {
                return noneState(context);
              }
            case ConnectionState.waiting:
              return waitingState(context);
          }
        },
      ),
    );
  }
}
