import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.black45),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'ngetest mad'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String status = "mati";

  Future onLamp() async {
    final url = Uri.parse("http://192.168.1.12/test?test=nyala");
    final ress = await http.get(url);
    if (ress.statusCode == 200) {
      return setState(() {
        status = "nyala";
      });
    }
  }

  Future offLamp() async {
    final url = Uri.parse("http://192.168.1.12/test?test=mati");
    final ress = await http.get(url);
    if (ress.statusCode == 200) {
      return setState(() {
        status = "mati";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Center(
            child: Text(
          widget.title,
          style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.lightBlue,
              letterSpacing: 0.9,
              wordSpacing: 3),
        )),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.black,
                    padding: const EdgeInsets.all(10),
                    elevation: 5,
                  ),
                  onPressed: (status == "mati") ? onLamp : offLamp,
                  child: Icon(
                    (status == "nyala")
                        ? Icons.lightbulb
                        : Icons.lightbulb_outline,
                    size: 80,
                    color: Colors.amber,
                  )),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Text(
                "Lampune $status mad",
                style: const TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
