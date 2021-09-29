import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:plural_selectable/plural_selectable.dart';
import 'models/branch_model.dart';
import 'models/sub_branch_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Plural Selectable example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void onSelection(int branch, int sub, bool checked) {
    branches[branch].subBranches![sub].isSelected = checked;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Selectable(
              onSelection: onSelection,
              mainAxisSpacing: 0.0,
              maxCrossAxisExtent: 180.0,
              crossAxisSpacing: 0.0,
              branchChild: (context, index) {
                return ClipPolygon(
                  boxShadows: [
                    PolygonBoxShadow(color: Colors.black, elevation: 10.0),
                  ],
                  sides: 6,
                  borderRadius: 10.0,
                  child: Container(
                    color: Colors.white,
                    child: CachedNetworkImage(
                      imageUrl: branches[index].name!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
              titleActiveStyle: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
              titleStyle: const TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
              branchCount: branches.length,
              subBranches: SubBranchActionBuilderDelegate(
                builder: (context, branchIndex, subIndex) => Subs(
                  leading: Container(
                    height: 40.0,
                    width: 40.0,
                    child: CachedNetworkImage(
                      imageUrl:
                          branches[branchIndex].subBranches![subIndex].text!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  ),
                  title: 'Test',
                ),
                selected: (index) => List.generate(
                  branches[index].subBranches!.length,
                  (subIndex) =>
                      branches[index].subBranches![subIndex].isSelected!,
                ),
              ),
              title: (index) => 'Test $index',
            ),
          ),
        ],
      ),
    );
  }

  var branches = [
    BranchModel(
      name: 'https://cdn-icons-png.flaticon.com/512/3359/3359548.png',
      subBranches: [
        SubBranchModel(
            isSelected: true,
            text: 'https://cdn-icons-png.flaticon.com/512/4471/4471180.png'),
        SubBranchModel(
            isSelected: false,
            text: 'https://cdn-icons-png.flaticon.com/512/5167/5167364.png'),
        SubBranchModel(
            isSelected: false,
            text: 'https://cdn-icons-png.flaticon.com/512/5167/5167308.png'),
      ],
    ),
    BranchModel(
      name: 'https://cdn-icons-png.flaticon.com/512/2950/2950658.png',
      subBranches: [
        SubBranchModel(
            isSelected: false,
            text: 'https://cdn-icons-png.flaticon.com/512/1974/1974756.png'),
        SubBranchModel(
            isSelected: true,
            text:
                'https://cdn.dsmcdn.com//ty112/product/media/images/20210507/14/86656868/172072000/1/1_org_zoom.jpg'),
        SubBranchModel(
            isSelected: false,
            text: 'https://cdn-icons-png.flaticon.com/512/5020/5020383.png'),
        SubBranchModel(
            isSelected: false,
            text: 'https://cdn-icons-png.flaticon.com/512/5151/5151403.png'),
        SubBranchModel(
            isSelected: false,
            text: 'https://cdn-icons-png.flaticon.com/512/836/836847.png'),
      ],
    ),
    BranchModel(
      name: 'https://cdn-icons-png.flaticon.com/512/4264/4264857.png',
      subBranches: [
        SubBranchModel(
            isSelected: false,
            text:
                'https://dbdzm869oupei.cloudfront.net/img/sticker/preview/4944.png'),
        SubBranchModel(
            isSelected: false,
            text: 'https://cdn-icons-png.flaticon.com/512/5046/5046975.png'),
        SubBranchModel(
            isSelected: false,
            text: 'https://cdn-icons-png.flaticon.com/512/5151/5151407.png'),
      ],
    ),
    BranchModel(
      name: 'https://cdn-icons-png.flaticon.com/512/647/647740.png',
      subBranches: [
        SubBranchModel(
            isSelected: false,
            text: 'https://cdn-icons-png.flaticon.com/512/4442/4442758.png'),
        SubBranchModel(
            isSelected: false,
            text: 'https://cdn-icons-png.flaticon.com/512/4683/4683605.png'),
        SubBranchModel(
            isSelected: true,
            text: 'https://cdn-icons-png.flaticon.com/512/4683/4683591.png'),
      ],
    ),
  ];
}
