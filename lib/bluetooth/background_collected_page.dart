import 'package:flutter/material.dart';
import 'package:plant_care_system/main.dart';
import 'background_collecting_task.dart';
import 'helpers/line_chart.dart';
import 'helpers/paint_style.dart';

class BackgroundCollectedPage extends StatelessWidget {
  const BackgroundCollectedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BackgroundCollectingTask task =
        BackgroundCollectingTask.of(context, rebuildOnChange: true);

    // Arguments shift is needed for timestamps as miliseconds in double could loose precision.
    final int argumentsShift =
        task.samples.first.timestamp.millisecondsSinceEpoch;

    const Duration showDuration =
        Duration(hours: 1); // @TODO . show duration should be configurable
    final Iterable<DataSample> lastSamples = task.getLastOf(showDuration);

    final Iterable<double> arguments = lastSamples.map((sample) {
      return (sample.timestamp.millisecondsSinceEpoch - argumentsShift)
          .toDouble();
    });

    // Step for argument labels
    const Duration argumentsStep =
        Duration(minutes: 1); // @TODO . step duration should be configurable

    // Find first timestamp floored to step before
    final DateTime beginningArguments = lastSamples.first.timestamp;
    DateTime beginningArgumentsStep = DateTime(beginningArguments.year,
        beginningArguments.month, beginningArguments.day);
    while (beginningArgumentsStep.isBefore(beginningArguments)) {
      beginningArgumentsStep = beginningArgumentsStep.add(argumentsStep);
    }
    beginningArgumentsStep = beginningArgumentsStep.subtract(argumentsStep);
    final DateTime endingArguments = lastSamples.last.timestamp;

    // Generate list of timestamps of labels
    final Iterable<DateTime> argumentsLabelsTimestamps = () sync* {
      DateTime timestamp = beginningArgumentsStep;
      yield timestamp;
      while (timestamp.isBefore(endingArguments)) {
        timestamp = timestamp.add(argumentsStep);
        yield timestamp;
      }
    }();

    // Map strings for labels
    final Iterable<LabelEntry> argumentsLabels =
        argumentsLabelsTimestamps.map((timestamp) {
      return LabelEntry(
          (timestamp.millisecondsSinceEpoch - argumentsShift).toDouble(),
          ((timestamp.hour <= 9 ? '0' : '') +
              timestamp.hour.toString() +
              ':' +
              (timestamp.minute <= 9 ? '0' : '') +
              timestamp.minute.toString()));
    });

    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      // ignore: prefer_const_literals_to_create_immutables
                      colors: <Color>[
                Color.fromARGB(255, 18, 64, 38),
                Color.fromARGB(255, 18, 60, 12)
              ]))),
          title: const Text('Collected data',
              style: TextStyle(
                color: Color.fromARGB(255, 199, 217, 137),
                fontWeight: FontWeight.bold,
              )),
          iconTheme:
              const IconThemeData(color: Color.fromARGB(255, 199, 217, 137)),
          actions: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: (task.inProgress
                      ? FittedBox(
                          child: Container(
                              margin: const EdgeInsets.all(16.0),
                              child: const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white))))
                      : Container(/* Dummy */)),
                ),
                Expanded(
                  child: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyApp()),
                        );
                      }),
                ),
              ],
            )
            // Progress circle
          ],
        ),
        body: ListView(
          children: <Widget>[
            const Divider(),
            const ListTile(
              leading: Icon(Icons.brightness_7),
              title: Text('Temperature'),
              subtitle: Text('In Celsius'),
            ),
            LineChart(
              constraints: const BoxConstraints.expand(height: 350),
              arguments: arguments,
              argumentsLabels: argumentsLabels,
              values: [
                lastSamples.map((sample) => sample.temperature),
              ],
              verticalLinesStyle: const PaintStyle(color: Colors.grey),
              additionalMinimalHorizontalLabelsInterval: 0,
              additionalMinimalVerticalLablesInterval: 0,
              seriesPointsStyles: const [
                PaintStyle(
                    style: PaintingStyle.stroke,
                    strokeWidth: 1.7 * 3,
                    color: Colors.indigo,
                    strokeCap: StrokeCap.round),
              ],
              seriesLinesStyles: const [
                PaintStyle(
                    style: PaintingStyle.stroke,
                    strokeWidth: 1.7,
                    color: Colors.redAccent),
              ],
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.filter_vintage),
              title: Text('Soil Moisture'),
            ),
            LineChart(
              constraints: const BoxConstraints.expand(height: 200),
              arguments: arguments,
              argumentsLabels: argumentsLabels,
              values: [
                lastSamples.map((sample) => sample.moisture),
              ],
              verticalLinesStyle: const PaintStyle(color: Colors.grey),
              additionalMinimalHorizontalLabelsInterval: 0,
              additionalMinimalVerticalLablesInterval: 0,
              seriesPointsStyles: const [
                null,
              ],
              seriesLinesStyles: const [
                PaintStyle(
                    style: PaintingStyle.stroke,
                    strokeWidth: 1.7,
                    color: Colors.greenAccent),
              ],
            ),
          ],
        ));
  }
}
