import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

const urlPrefix = "http://192.168.4.1";

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Robot Ayak Kontrol Paneli';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
          textTheme: const TextTheme(
              bodyText2: TextStyle(color: Colors.white),
              subtitle1: TextStyle(color: Colors.white)),
          elevatedButtonTheme: const ElevatedButtonThemeData(
              style: ButtonStyle(
                  foregroundColor: MaterialStatePropertyAll(Colors.black),
                  backgroundColor: MaterialStatePropertyAll(Colors.amber))),
          checkboxTheme: const CheckboxThemeData(
              checkColor: MaterialStatePropertyAll(Colors.black),
              fillColor: MaterialStatePropertyAll(Colors.amber)),
          sliderTheme: const SliderThemeData(
              thumbColor: Colors.amber,
              activeTrackColor: Colors.orange,
              inactiveTrackColor: Colors.black),
          appBarTheme: const AppBarTheme(
              color: Colors.orange,
              foregroundColor: Colors.white,
              centerTitle: true,
              iconTheme: IconThemeData(color: Colors.white))),
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 39, 39, 39),
        appBar: AppBar(title: const Text(_title)),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  _MyStatefulWidgetState() {
    makeGetRequest();
  }

  List<double> angles = List.from([0.0, 0.0, 0.0], growable: false);
  List<int> pins = List.from([0, 0, 0], growable: false);
  List<bool> activeServos = List.from([true, true, true], growable: false);

  Future<void> makeGetRequest() async {
    try {
      final url = Uri.parse('$urlPrefix/getdefault');
      Response response = await get(url);
      Map<String, dynamic> map = await jsonDecode(response.body);
      angles = List.from([
        map["angle0"].toDouble(),
        map["angle1"].toDouble(),
        map["angle2"].toDouble()
      ], growable: false);
      activeServos = List.from([
        map["servo0"] == 0 ? false : true,
        map["servo1"] == 0 ? false : true,
        map["servo2"] == 0 ? false : true
      ], growable: false);
      pins =
          List.from([map["pin0"], map["pin1"], map["pin2"]], growable: false);
      setState(() {});
    } catch (e) {}
  }

  Future<void> makePostRequest() async {
    final url = Uri.parse(
        '$urlPrefix/start?angle0=${angles[0]}&angle1=${angles[1]}'
        '&angle2=${angles[2]}&servo0=${activeServos[0] ? 1 : 0}&servo1=${activeServos[1] ? 1 : 0}&servo2=${activeServos[2] ? 1 : 0}'
        '&pin0=${pins[0]}&pin1=${pins[1]}&pin2=${pins[2]}');
    post(url);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      verticalDirection: VerticalDirection.down,
      children: [
        Expanded(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          textDirection: TextDirection.ltr,
          children: [
            const Text("Servo 0 ->\t"),
            const Text("Açı"),
            Slider(
              value: angles[0],
              max: 360,
              divisions: 360,
              label: angles[0].round().toString(),
              onChanged: (double value) {
                setState(() {
                  angles[0] = value;
                });
              },
            ),
            const Text("Pin"),
            DropdownButton(
              borderRadius: BorderRadius.circular(10),
              dropdownColor: Colors.black,
              value: pins[0],
              items: const <DropdownMenuItem<int>>[
                DropdownMenuItem(
                  value: 0,
                  child: Text("0"),
                ),
                DropdownMenuItem(
                  value: 1,
                  child: Text("1"),
                ),
                DropdownMenuItem(
                  value: 2,
                  child: Text("2"),
                ),
                DropdownMenuItem(
                  value: 3,
                  child: Text("3"),
                ),
                DropdownMenuItem(
                  value: 4,
                  child: Text("4"),
                ),
                DropdownMenuItem(
                  value: 5,
                  child: Text("5"),
                ),
                DropdownMenuItem(
                  value: 9,
                  child: Text("9"),
                ),
                DropdownMenuItem(
                  value: 10,
                  child: Text("10"),
                ),
                DropdownMenuItem(
                  value: 12,
                  child: Text("12"),
                ),
                DropdownMenuItem(
                  value: 13,
                  child: Text("13"),
                ),
                DropdownMenuItem(
                  value: 14,
                  child: Text("14"),
                ),
                DropdownMenuItem(
                  value: 15,
                  child: Text("15"),
                ),
                DropdownMenuItem(
                  value: 16,
                  child: Text("16"),
                )
              ],
              onChanged: (value) {
                setState(() {
                  pins[0] = value!;
                });
              },
            ),
            Checkbox(
              value: activeServos[0],
              onChanged: (value) {
                setState(() {
                  activeServos[0] = value!;
                });
              },
            )
          ],
        )),
        Expanded(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          textDirection: TextDirection.ltr,
          children: [
            const Text("Servo 1 ->\t"),
            const Text("Açı"),
            Slider(
              value: angles[1],
              max: 360,
              divisions: 360,
              label: angles[1].round().toString(),
              onChanged: (double value) {
                setState(() {
                  angles[1] = value;
                });
              },
            ),
            const Text("Pin"),
            DropdownButton(
              borderRadius: BorderRadius.circular(10),
              dropdownColor: Colors.black,
              value: pins[1],
              items: const <DropdownMenuItem<int>>[
                DropdownMenuItem(
                  value: 0,
                  child: Text("0"),
                ),
                DropdownMenuItem(
                  value: 1,
                  child: Text("1"),
                ),
                DropdownMenuItem(
                  value: 2,
                  child: Text("2"),
                ),
                DropdownMenuItem(
                  value: 3,
                  child: Text("3"),
                ),
                DropdownMenuItem(
                  value: 4,
                  child: Text("4"),
                ),
                DropdownMenuItem(
                  value: 5,
                  child: Text("5"),
                ),
                DropdownMenuItem(
                  value: 9,
                  child: Text("9"),
                ),
                DropdownMenuItem(
                  value: 10,
                  child: Text("10"),
                ),
                DropdownMenuItem(
                  value: 12,
                  child: Text("12"),
                ),
                DropdownMenuItem(
                  value: 13,
                  child: Text("13"),
                ),
                DropdownMenuItem(
                  value: 14,
                  child: Text("14"),
                ),
                DropdownMenuItem(
                  value: 15,
                  child: Text("15"),
                ),
                DropdownMenuItem(
                  value: 16,
                  child: Text("16"),
                )
              ],
              onChanged: (value) {
                setState(() {
                  pins[1] = value!;
                });
              },
            ),
            Checkbox(
              value: activeServos[1],
              onChanged: (value) {
                setState(() {
                  activeServos[1] = value!;
                });
              },
            )
          ],
        )),
        Expanded(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          textDirection: TextDirection.ltr,
          children: [
            const Text("Servo 2 ->\t"),
            const Text("Açı"),
            Slider(
              value: angles[2],
              max: 360,
              divisions: 360,
              label: angles[2].round().toString(),
              onChanged: (double value) {
                setState(() {
                  angles[2] = value;
                });
              },
            ),
            const Text("Pin"),
            DropdownButton(
              borderRadius: BorderRadius.circular(10),
              dropdownColor: Colors.black,
              value: pins[2],
              items: const <DropdownMenuItem<int>>[
                DropdownMenuItem(
                  value: 0,
                  child: Text("0"),
                ),
                DropdownMenuItem(
                  value: 1,
                  child: Text("1"),
                ),
                DropdownMenuItem(
                  value: 2,
                  child: Text("2"),
                ),
                DropdownMenuItem(
                  value: 3,
                  child: Text("3"),
                ),
                DropdownMenuItem(
                  value: 4,
                  child: Text("4"),
                ),
                DropdownMenuItem(
                  value: 5,
                  child: Text("5"),
                ),
                DropdownMenuItem(
                  value: 9,
                  child: Text("9"),
                ),
                DropdownMenuItem(
                  value: 10,
                  child: Text("10"),
                ),
                DropdownMenuItem(
                  value: 12,
                  child: Text("12"),
                ),
                DropdownMenuItem(
                  value: 13,
                  child: Text("13"),
                ),
                DropdownMenuItem(
                  value: 14,
                  child: Text("14"),
                ),
                DropdownMenuItem(
                  value: 15,
                  child: Text("15"),
                ),
                DropdownMenuItem(
                  value: 16,
                  child: Text("16"),
                )
              ],
              onChanged: (value) {
                setState(() {
                  pins[2] = value!;
                });
              },
            ),
            Checkbox(
              value: activeServos[2],
              onChanged: (value) {
                setState(() {
                  activeServos[2] = value!;
                });
              },
            )
          ],
        )),
        ElevatedButton(
          child: const Text("Başlat"),
          onPressed: () {
            makePostRequest();
          },
        )
      ],
    ));
  }
}
