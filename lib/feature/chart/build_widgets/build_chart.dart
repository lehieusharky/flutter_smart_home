import 'package:animation/model/realtime_value/realtime_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

SfCartesianChart buildChart({required List<RealtimeModel> listItems}) {
  return SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      // Chart title
      title: ChartTitle(text: 'Temperature and humidity'),
      // Enable legend
      legend: Legend(isVisible: true, position: LegendPosition.bottom),
      // Enable tooltip
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <ChartSeries<RealtimeModel, String>>[
        LineSeries<RealtimeModel, String>(
            dataSource: listItems,
            xValueMapper: (RealtimeModel items, _) =>
                _formatTime(items.dateTime),
            yValueMapper: (RealtimeModel items, _) => int.parse(items.humidity),
            name: 'Temperature',
            // Enable data label
            dataLabelSettings: const DataLabelSettings(isVisible: true)),
        LineSeries<RealtimeModel, String>(
            dataSource: listItems,
            xValueMapper: (RealtimeModel items, _) =>
                _formatTime(items.dateTime),
            yValueMapper: (RealtimeModel items, _) => int.parse(items.motor),
            name: 'Humidity',
            // Enable data label
            dataLabelSettings: const DataLabelSettings(isVisible: true))
      ]);
}

String _formatTime(String input) {
  return input.substring(0, 16);
}
