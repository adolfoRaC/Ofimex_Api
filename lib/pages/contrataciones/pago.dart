import 'package:flutter/material.dart';
import 'package:ofimex/theme/theme.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reseñas"),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  "4.8",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                Row(
                  children: [
                    const Text("5"),
                    LinearProgressIndicator(
                      value: 0.5,
                      minHeight: 25,
                      backgroundColor: Colors.grey,
                      valueColor: AlwaysStoppedAnimation(
                        AppTheme().theme().primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(7),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
