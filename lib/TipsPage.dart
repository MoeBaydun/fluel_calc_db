import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TipsPage extends StatefulWidget {
  @override
  _TipsPageState createState() => _TipsPageState();
}

class _TipsPageState extends State<TipsPage> {
  List<String> tips = [];

  @override
  void initState() {
    super.initState();
    fetchTips();
  }

  Future<void> fetchTips() async {
    final response = await http.get(Uri.parse('http://fuelcalc.atwebpages.com/tips.php')); //url

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        tips = data.map((tip) => tip['tip'] as String).toList();
      });
    } else {
      throw Exception('Failed to load tips');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F4F6),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: tips.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: tips.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 8),
              color: Color(0xFF54567A),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  tips[index],
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}