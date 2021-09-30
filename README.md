# plural_selectable

- A widget that helps you with your plurals selection

<img src="https://user-images.githubusercontent.com/37551474/135257070-b272dc16-effa-4fb1-a66f-242e1cc8df27.gif" width="220">



## Library

```dart
import 'package:plural_selectable/plural_selectable.dart';
```



## Example
### [GitHub](https://github.com/taylanyildiz/plural_selectable)
### [Github Main](https://github.com/taylanyildiz/plural_selectable/blob/master/example/lib/main.dart)

</p>

- ## onSelection Function
</p>

```dart
void onSelection(int branch, int sub, bool checked) {
  branches[branch].subBranches![sub].isSelected = checked;
  setState(() {});
}
```
- ## Selectable Widget
</p>

```dart
  Selectable(
      onSelection: onSelection,
      branchChild: (context, index) {
        return Container(
          margin: const EdgeInsets.all(10.0),
          color: Colors.red,
          child: Center(child: Text(branches[index].name!)),
        );
      },
      branchCount: branches.length,
      subBranches: SubBranchActionBuilderDelegate(
        builder: (context, branchIndex, subIndex) => Subs(
          leading: const Icon(Icons.home),
          title: branches[branchIndex].subBranches![subIndex].text!,
        ),
        selected: (index) => List.generate(
          branches[index].subBranches!.length,
          (subIndex) => branches[index].subBranches![subIndex].isSelected!,
        ),
      ),
      title: (index) => branches[index].name!,
    ),
  ),
```
## Firstly create a model for your selections.
- You can create this model however you want.
- Your model must have only isSelected [bool] veriable. 
- You are free to choose your model method as you like.

</p>

- ## Model List
</p>

```dart
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
```


## What does want Widget.

### OnPress [Function] selection
 - Function(int branch, int sub, bool checked) onSelection

### Branches return model.
 - int branchCount

### Branches title. Botttom of branch child.
 - String Function(int branch) title

### Skeleton of Branches [Widget] child.
 - BranchBuilder branchChild

### [SubBranchActionDelegate] subBranches.
 - SubBranchActionBuilderDelegate subBranches

### A collection of common animation curves.
### [Curves.easeInCirc] FadeTransition.
 - Curve? curve

### Entry create animation duration
 - Duration duration

### [Color] background color. SubBranches selection screen.
 - Color? backgroundColor

### SubBranch page transition animation time
 - Duration transtionDuration

### [Duration] animation reverse duration.
 - Duration? reverseDuration

### Background blur of the SubBranch page.
 - ImageFilter? imageFilter

### The distance between branches is horizontal.
### default value is 5.0
 - double crossAxisSpacing

#### The distance between branches is vertical.
#### default value is 0.0
 - final double mainAxisSpacing

### The ratio of the cross-axis to the main-axis extent of each child.
 - double childAspectRatio

 
 #### The maximum extent of tiles in the cross axis.
 #### This delegate will select a cross-axis extent for the tiles that is as
 #### large as possible subject to the following conditions:
 #### - The extent evenly divides the cross-axis extent of the grid.
 #### - The extent is at most [maxCrossAxisExtent].
 #### For example, if the grid is vertical, the grid is 500.0 pixels wide, and
 #### [maxCrossAxisExtent] is 150.0, this delegate will create a grid with 4
 #### Columns that are 125.0 pixels wide.
 - double maxCrossAxisExtent

### Unselected background color.
 - Color? deactiveColor

### Selected background color.
 -  Color? activeColor

### Selected Title style.
 -  TextStyle? titleActiveStyle

### Unselected title style.
 -  TextStyle? titleDeactiveStyle

### Background box decoration.
 -  BoxDecoration? decoration

### [Widget] backbutton.
 -  Widget? backButton

### [String] title of back button.
 - String? titleBackButton

### [Color] of checked background.
 - Color? checkBackground

### [Color] of checked icon color.
 - Color? checkIconColor

### Color circle background.
 - Color? selectedBackgroundColor

### Icon color circle icon checked.
 - Color? checkedIconColor.
