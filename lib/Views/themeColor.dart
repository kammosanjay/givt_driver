import 'package:flutter/material.dart';
import 'package:givt_driver_app/Views/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class ThemePage extends StatelessWidget {
   ThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    List<Color> colors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.purple,
      Colors.orange,
      Colors.teal,
    ];

    return Scaffold(
      backgroundColor: themeProvider.primaryColor,
      appBar: AppBar(title: const Text('Change Theme Color')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: colors
              .map(
                (color) => GestureDetector(
                  // onTap: () => themeProvider.changeColor(color),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: themeProvider.primaryColor == color
                            ? Colors.black
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
