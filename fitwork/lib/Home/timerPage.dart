import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
  final _isHours = true;
  final _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    _stopWatchTimer.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Timer',
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<int>(
                stream: _stopWatchTimer.rawTime,
                initialData: _stopWatchTimer.rawTime.value,
                builder: (context, snapshot) {
                  final dynamic value = snapshot.data;
                  final displayTime =
                      StopWatchTimer.getDisplayTime(value, hours: _isHours);
                  return Text(
                    displayTime,
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  );
                }),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
                  },
                  child: Text('Start'),
                ),
                SizedBox(
                  height: 10.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
                  },
                  child: Text('Stop'),
                )
              ],
            ),
            ElevatedButton(
              onPressed: () {
                _stopWatchTimer.onExecute.add(StopWatchExecute.lap);
              },
              child: Text('Lap'),
            ),
            ElevatedButton(
              onPressed: () {
                _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
              },
              child: Text('Reset'),
            ),
            Container(
              height: 120,
              margin: const EdgeInsets.all(8),
              child: StreamBuilder<List<StopWatchRecord>>(
                stream: _stopWatchTimer.records,
                initialData: _stopWatchTimer.records.value,
                builder: (context, snapshot) {
                  final value = snapshot.data;
                  if (value!.isEmpty) {
                    return Container();
                  }
                  Future.delayed(const Duration(milliseconds: 100), () {
                    _scrollController.animateTo(
                      _scrollController.position.maxScrollExtent,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeOut
                    );
                  });
                  return ListView.builder(
                    controller: _scrollController,
                    itemBuilder: (context, index) {
                      final data = value[index];
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text('${index + 1} - ${data.displayTime}'),
                          ),
                          Divider(
                            height: 1.0,
                          )
                        ],
                      );
                    },
                    itemCount: value.length,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
