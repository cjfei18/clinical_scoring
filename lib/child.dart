import 'package:flutter/material.dart';

class ChildPughPage extends StatefulWidget {
  ChildPughPage({Key? key}) : super(key: key);

  @override
  State<ChildPughPage> createState() => _ChildPughPageState();
}

class _ChildPughPageState extends State<ChildPughPage> {
  String _selectedHEGrade = '无';
  String _selectedascites = '无';
  final TextEditingController _sbcontroller = TextEditingController();
  final TextEditingController _inrcontroller = TextEditingController();
  final TextEditingController _albcontroller = TextEditingController();
  String _result = ' ';

  @override
  void initState() {
    super.initState();
    _sbcontroller.addListener(() {});
    _inrcontroller.addListener(() {});
    _albcontroller.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Child-Pugh评分"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            _hepaticEncephalopathy(),
            _ascites(),
            _bilirubin(),
            _inr(),
            _albumin(),
            _button(),
            Text(
              "肝功能 " + _result + " 级",
              style: const TextStyle(color: Colors.red, fontSize: 30),
            )
          ],
        ),
      ),
    );
  }

  Widget _button() {
    return ElevatedButton(
      child: const Text("计算"),
      onPressed: () {
        setState(() {
          _result = _childPugh();
        });
      },
    );
  }

  Widget _hepaticEncephalopathy() {
    return Row(children: [
      const Text(
        "肝性脑病：",
        style: TextStyle(fontSize: 25),
      ),
      DropdownButton(
        hint: const Text("请选择肝性脑病（级）"),
        items: const [
          DropdownMenuItem(
            child: Text("无"),
            value: "无",
          ),
          DropdownMenuItem(
            child: Text("1~2"),
            value: "1~2",
          ),
          DropdownMenuItem(
            child: Text("3~4"),
            value: "3~4",
          ),
        ],
        value: _selectedHEGrade,
        onChanged: (value) {
          setState(() {
            _selectedHEGrade = value.toString();
          });
        },
      )
    ]);
  }

  Widget _ascites() {
    return Row(children: [
      const Text(
        "腹水：",
        style: TextStyle(fontSize: 25),
      ),
      DropdownButton(
        hint: const Text("请选择腹水程度"),
        items: const [
          DropdownMenuItem(
            child: Text("无"),
            value: "无",
          ),
          DropdownMenuItem(
            child: Text("轻度"),
            value: "轻度",
          ),
          DropdownMenuItem(
            child: Text("中重度"),
            value: "中重度",
          ),
        ],
        value: _selectedascites,
        onChanged: (value) {
          setState(() {
            _selectedascites = value.toString();
          });
        },
      )
    ]);
  }

  Widget _bilirubin() {
    return Row(children: [
      const Text(
        "总胆红素（μmol/L）:",
        style: TextStyle(fontSize: 25),
      ),
      Expanded(
        child: TextField(
          keyboardType: TextInputType.number,
          maxLength: 6,
          textInputAction: TextInputAction.next,
          controller: _sbcontroller,
          style: const TextStyle(fontSize: 20),
        ),
      )
    ]);
  }

  Widget _inr() {
    return Row(children: [
      const Text(
        "凝血酶原时间（INR）:",
        style: TextStyle(fontSize: 25),
      ),
      Expanded(
        child: TextField(
          keyboardType: TextInputType.number,
          maxLength: 6,
          textInputAction: TextInputAction.next,
          controller: _inrcontroller,
          style: const TextStyle(fontSize: 20),
        ),
      )
    ]);
  }

  Widget _albumin() {
    return Row(children: [
      const Text(
        "白蛋白（g/L）:",
        style: TextStyle(fontSize: 25),
      ),
      Expanded(
        child: TextField(
          keyboardType: TextInputType.number,
          maxLength: 6,
          textInputAction: TextInputAction.done,
          controller: _albcontroller,
          style: const TextStyle(fontSize: 20),
        ),
      )
    ]);
  }

  String _childPugh() {
    int totalScore = 0;
    switch (_selectedHEGrade) {
      case "无":
        {
          totalScore++;
          break;
        }
      case "1~2":
        {
          totalScore += 2;
          break;
        }
      case "3~4":
        {
          totalScore += 3;
          break;
        }
    }
    switch (_selectedascites) {
      case "无":
        {
          totalScore++;
          break;
        }
      case "轻度":
        {
          totalScore += 2;
          break;
        }
      case "中重度":
        {
          totalScore += 3;
          break;
        }
    }
    if (double.parse(_sbcontroller.text) < 34) {
      totalScore++;
    } else {
      if (double.parse(_sbcontroller.text) <= 51.0) {
        totalScore += 2;
      } else {
        totalScore += 3;
      }
    }
    if (double.parse(_albcontroller.text) > 35) {
      totalScore++;
    } else {
      if (double.parse(_albcontroller.text) >= 28) {
        totalScore += 2;
      } else {
        totalScore += 3;
      }
    }
    if (double.parse(_inrcontroller.text) < 1.3) {
      totalScore++;
    } else {
      if (double.parse(_albcontroller.text) <= 1.5) {
        totalScore += 2;
      } else {
        totalScore += 3;
      }
    }
    return totalScore <= 6 ? "A" : (totalScore <= 9 ? "B" : "C");
  }
}
