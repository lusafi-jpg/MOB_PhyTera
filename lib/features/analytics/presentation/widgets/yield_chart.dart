import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class YieldChart extends StatefulWidget {
  const YieldChart({super.key});

  @override
  State<YieldChart> createState() => _YieldChartState();
}

class _YieldChartState extends State<YieldChart> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 20,
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (group) => AppColors.surface,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                  '${rod.toY.toInt()}',
                  const TextStyle(color: AppColors.textPrimary),
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (double value, TitleMeta meta) {
                  const style = TextStyle(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  );
                  String text;
                  switch (value.toInt()) {
                    case 0:
                      text = 'Jan';
                      break;
                    case 1:
                      text = 'Feb';
                      break;
                    case 2:
                      text = 'Mar';
                      break;
                    case 3:
                      text = 'Apr';
                      break;
                    case 4:
                      text = 'May';
                      break;
                    case 5:
                      text = 'Jun';
                      break;
                    default:
                      text = '';
                  }
                  return Text(text, style: style);
                },
                reservedSize: 30,
              ),
            ),
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          borderData: FlBorderData(show: false),
          gridData: const FlGridData(show: false),
          barGroups: [
            BarChartGroupData(
              x: 0,
              barRods: [
                BarChartRodData(toY: 8, color: AppColors.primary, width: 16)
              ],
            ),
            BarChartGroupData(
              x: 1,
              barRods: [
                BarChartRodData(toY: 10, color: AppColors.primary, width: 16)
              ],
            ),
            BarChartGroupData(
              x: 2,
              barRods: [
                BarChartRodData(toY: 14, color: AppColors.primary, width: 16)
              ],
            ),
            BarChartGroupData(
              x: 3,
              barRods: [
                BarChartRodData(toY: 15, color: AppColors.primary, width: 16)
              ],
            ),
            BarChartGroupData(
              x: 4,
              barRods: [
                BarChartRodData(toY: 13, color: AppColors.primary, width: 16)
              ],
            ),
            BarChartGroupData(
              x: 5,
              barRods: [
                BarChartRodData(toY: 18, color: AppColors.primary, width: 16)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
