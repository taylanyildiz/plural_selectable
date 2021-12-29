# Plural Selectable
## <img width="220px" src ="https://user-images.githubusercontent.com/37551474/147578614-88d24ee1-406d-4b89-ab9d-d229bbb26fdd.png"/>

* You will now be able to make multiple selections within your model. And you will be able to create a widget of your own by customizing this selection style as you wish.

* First of all, you must have a model and there is a variable requested from you in this model. Let's explain with an example

* For example, you have a Map. There must be a list structure in this model, if you do not have a list, you will encounter an error. It doesn't matter if your list is empty. You have different models in this list. The thing to remember is that the different structures in this list model must be distinguished from each other, and each of them must have an id variable. With this id, it can be easily distinguished whether it is selected or not.
Remember, the ids in each list must be different.

## Install

In the `pubspec.yaml` of your project, add the following dependenciy:
```yaml
dependencies:
  plural_selectable: <latest_version>
```

<img src = "https://user-images.githubusercontent.com/37551474/147637107-0ee5d70a-cc37-46c3-84ad-385833735411.gif" width="220px"> <img src="https://user-images.githubusercontent.com/37551474/135257070-b272dc16-effa-4fb1-a66f-242e1cc8df27.gif" width="220px"> 


## Getting started

###

```json
{
    "name":"--",
    "list":[
        {
            "id":1,
            "name": "---",
            "value": "---",
        }
         {
             "id":2,
            "name": "---",
            "value": "---",
        }
    ],
}
```

```dart
List<SelectModel> modelList = [
  SelectModel(id: 0, name: "test 1 select", list: [
    InnerSelectModel(id: 0, value: "test 1 inner"),
    InnerSelectModel(id: 1, value: "test 2 inner"),
    InnerSelectModel(id: 2, value: "test 3 inner"),
  ]),
  SelectModel(id: 1, name: "test 1 select", list: [
    InnerSelectModel(id: 3, value: "test 3 inner"),
    InnerSelectModel(id: 4, value: "test 4 inner"),
    InnerSelectModel(id: 5, value: "test 5 inner"),
  ]),
];
```

- After adding your model to the widget, you must specify which list is selectable.

```dart
    selectList: map,
    innerList: (model) => model["list"],
    // This model returns your original model and waits for you to display your selectable list.
    // each model returns by traversing your list structure.
```

```dart
 Selectable<Map>(
    selectList: map,
    innerList: (model) => model["list"],
    builder: (context, model) {
    return SelectableHeader(
        title: Text("${model["name"]}"),
    );
    },
    innerBuilder: (context, inner, index) {
    return InnerSelect(
        leading: Text("${inner[index]["value"]}"),
    );
    },
    onSelect: (model, isSelect) {},
    selected: selected,
)
```


## Selected

If there are previously selected structures in the model you have. And you want to show that they are selected in the widget.

```dart
selected: [1,3,5]
```

As you can see above, you can specify that they are selected by writing the selected ones as a list.


```dart
Selectable<SelectModel>(
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
  childBuilder: (context, inner, index, isSelected) {
    debugPrint("Check $isSelected");
    return SelectableChild(
      selected: isSelected,
      leading: Text(
        "${inner[index].value}",
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      suffixIcon: const Icon(
        Icons.done,
        color: Colors.white,
      ),
      margin: const EdgeInsets.symmetric(
          horizontal: 30.0, vertical: 5.0),
    );
  },
  onSelect: (selectedId, isSelect) {
    debugPrint("Seçili olan id : $selectedId değeri : $isSelect");
  },
  selectedList: selected,
),
```


