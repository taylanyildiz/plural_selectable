import 'package:flutter/material.dart';
import 'package:plural_selectable/plural_selectable.dart';
import '/models/select_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final selected = <int>[1];

final List<Map> map = [
  {
    "id": 1,
    "name": "test title 1",
    "list": [
      {
        "id": 1,
        "value": "test-1",
      },
      {
        "id": 2,
        "value": "test-2",
      },
      {
        "id": 3,
        "value": "test-3",
      }
    ],
  },
  {
    "id": 2,
    "name": "test title 2",
    "list": [
      {
        "id": 4,
        "value": "test-1",
      },
      {
        "id": 5,
        "value": "test-2",
      },
      {
        "id": 6,
        "value": "test-3",
      }
    ],
  },
  {
    "id": 3,
    "name": "test title 3",
    "list": [
      {
        "id": 7,
        "value": "test-1",
      },
      {
        "id": 8,
        "value": "test-2",
      },
      {
        "id": 9,
        "value": "test-3",
      }
    ],
  },
];

List<SelectModel> modelList = [
  SelectModel(id: 0, name: "test 1 select", list: [
    InnerSelectModel(id: 0, value: "test 1 inner"),
    InnerSelectModel(id: 1, value: "test 2 inner"),
    InnerSelectModel(id: 2, value: "test 3 inner"),
  ]),
  SelectModel(id: 1, name: "test 2 select", list: [
    InnerSelectModel(id: 3, value: "test 3 inner"),
    InnerSelectModel(id: 4, value: "test 4 inner"),
    InnerSelectModel(id: 5, value: "test 5 inner"),
  ]),
  SelectModel(id: 2, name: "test  select", list: [
    InnerSelectModel(id: 6, value: "test 6 inner"),
    InnerSelectModel(id: 7, value: "test 7 inner"),
    InnerSelectModel(id: 8, value: "test 8 inner"),
    InnerSelectModel(id: 9, value: "test 9 inner"),
    InnerSelectModel(id: 10, value: "test 10 inner"),
    InnerSelectModel(id: 11, value: "test 11 inner"),
    InnerSelectModel(id: 12, value: "test 12 inner"),
    InnerSelectModel(id: 13, value: "test 13 inner"),
    InnerSelectModel(id: 14, value: "test 14 inner"),
    InnerSelectModel(id: 15, value: "test 15 inner"),
  ]),
];

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Selectable<SelectModel>(
                parentList: modelList,
                childList: (model) => model.list,
                builder: (context, model, isSlected) {
                  return SelectableParent(
                    decoration: BoxDecoration(
                      color: isSlected ? Colors.green[400] : Colors.red,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 4.0,
                          left: 3.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Plural Selectable",
                                style: TextStyle(
                                  color:
                                      isSlected ? Colors.white : Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Plural Selectable",
                                style: TextStyle(
                                  color:
                                      isSlected ? Colors.white : Colors.black45,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                closeButton: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.black38,
                  ),
                  child: const Text(
                    "Close",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                childBuilder: (context, inner, index, isSelected) {
                  debugPrint("Check $isSelected");
                  return SelectableChild(
                    selected: isSelected,
                    leading: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                      child: const Icon(Icons.menu),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${inner[index].value}",
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${inner[index]}",
                          style: TextStyle(
                            color: isSelected ? Colors.white54 : Colors.black26,
                            fontSize: 13.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    suffixIcon: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(4.0),
                      child: const Icon(
                        Icons.done,
                        color: Colors.green,
                      ),
                    ),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 30.0,
                      vertical: 5.0,
                    ),
                  );
                },
                onSelect: (selectedId, isSelect) {
                  debugPrint("Seçili olan id : $selectedId değeri : $isSelect");
                },
                selectedList: selected,
              ),
            )
          ],
        ),
      ),
    );
  }
}
