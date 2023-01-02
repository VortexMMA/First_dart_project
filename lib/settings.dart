import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './widgets.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: const Settings(),
    );
  }
}

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextEditingController txtWork = TextEditingController();
  TextEditingController txtShort = TextEditingController();
  TextEditingController txtLong = TextEditingController();
  static const String WORKTIME = "workTime";
  static const String SHORTBREAK = "shortBreak";
  static const String LONGBREAK = "longBreak";
  int workTime = 0;
  int shortBreak = 0;
  int longBreak = 0;
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    txtWork = TextEditingController();
    txtShort = TextEditingController();
    txtLong = TextEditingController();
    readSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = const TextStyle(fontSize: 24);
    return SizedBox(
      child: GridView.count(
        scrollDirection: Axis.vertical,
        crossAxisCount: 3,
        childAspectRatio: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: <Widget>[
          Text("Work", style: textStyle),
          Text(""),
          Text(""),
          SettingsButton(Color(0xff455A64), "-", -1, WORKTIME, updateSetting),
          TextField(
              style: textStyle,
              controller: txtWork,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number),
          SettingsButton(Color(0xff009688), "+", 1, WORKTIME, updateSetting),
          Text("Short", style: textStyle),
          Text(""),
          Text(""),
          SettingsButton(Color(0xff455A64), "-", -1, SHORTBREAK, updateSetting),
          TextField(
              style: textStyle,
              textAlign: TextAlign.center,
              controller: txtShort,
              keyboardType: TextInputType.number),
          SettingsButton(Color(0xff009688), "+", 1, SHORTBREAK, updateSetting),
          Text(
            "Long",
            style: textStyle,
          ),
          Text(""),
          Text(""),
          SettingsButton(Color(0xff455A64), "-", -1, LONGBREAK, updateSetting),
          TextField(
              style: textStyle,
              textAlign: TextAlign.center,
              controller: txtLong,
              keyboardType: TextInputType.number),
          SettingsButton(Color(0xff009688), "+", 1, LONGBREAK, updateSetting),
        ],
        padding: const EdgeInsets.all(20.0),
      ),
    );
  }

  readSettings() async {
    prefs = SharedPreferences.getInstance();
    int workTime = await prefs.then(
      (SharedPreferences prefs) {
        return prefs.getInt(WORKTIME) ?? 0;
      },
    );
    int shortBreak = await prefs.then(
      (SharedPreferences prefs) {
        return prefs.getInt(SHORTBREAK) ?? 0;
      },
    );
    int longBreak = await prefs.then(
      (SharedPreferences prefs) {
        return prefs.getInt(LONGBREAK) ?? 0;
      },
    );

    setState(
      () {
        txtWork.text = workTime.toString();
        txtShort.text = shortBreak.toString();
        txtLong.text = longBreak.toString();
      },
    );
  }

  void updateSetting(String key, int value) async {
    switch (key) {
      case WORKTIME:
        {
          int workTime = await prefs.then(
            (SharedPreferences prefs) {
              return prefs.getInt(WORKTIME) ?? 0;
            },
          );
          workTime += value;
          if (workTime >= 1 && workTime <= 180) {
            await prefs.then(
              (SharedPreferences prefs) {
                return prefs.setInt(WORKTIME, workTime);
              },
            );
            setState(
              () {
                txtWork.text = workTime.toString();
              },
            );
          }
        }
        break;
      case SHORTBREAK:
        {
          int short = await prefs.then(
            (SharedPreferences prefs) {
              return prefs.getInt(SHORTBREAK) ?? 0;
            },
          );

          short += value;
          if (short >= 1 && short <= 120) {
            await prefs.then(
              (SharedPreferences prefs) {
                return prefs.setInt(SHORTBREAK, short);
              },
            );

            setState(
              () {
                txtShort.text = short.toString();
              },
            );
          }
        }
        break;
      case LONGBREAK:
        {
          int long = await prefs.then(
            (SharedPreferences prefs) {
              return prefs.getInt(LONGBREAK) ?? 0;
            },
          );

          long += value;
          if (long >= 1 && long <= 180) {
            await prefs.then(
              (SharedPreferences prefs) {
                return prefs.setInt(LONGBREAK, long);
              },
            );

            setState(
              () {
                txtLong.text = long.toString();
              },
            );
          }
        }
        break;
    }
  }
}
