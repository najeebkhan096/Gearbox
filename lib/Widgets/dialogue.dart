import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gearbox/Widgets/constant.dart';
import 'package:gearbox/Widgets/text.dart';

class FilterDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.symmetric(vertical: 8.0,horizontal: 25),

      title: Center(child: BlackTextRegular(title: "Choose Filter".tr(), weight: FontWeight.w800, size: 18)),
      content: FilterOptions(),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context,[selectedManufacturer,selectedModel,selectedPriceRange]);
          },
          child: Text('Okay'.tr()),
        ),
      ],
    );
  }
}

class FilterOptions extends StatefulWidget {
  @override
  _FilterOptionsState createState() => _FilterOptionsState();
}

class _FilterOptionsState extends State<FilterOptions> {

  List<String> modelOptions =

  selectedManufacturer==null?[]:
  getModelsForManufacturer(selectedManufacturer!);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          FilterOption(
            selected_value: selectedManufacturer,
            title: 'Manufacturer'.tr(),
            options: getManufacturers(),
            onChanged: (value) {
              setState(() {
                selectedModel = null;
                selectedManufacturer = value;
                modelOptions = getModelsForManufacturer(selectedManufacturer!);
              });
            },
          ),
          FilterOption(
            title: 'Model'.tr(),
            options: modelOptions,

            onChanged: (value) {
              setState(() {
                selectedModel = value;
              });
            },
            selected_value: selectedModel,
          ),
          FilterOption(
            title: 'Price Range'.tr(),
            options: getPriceRanges(),
            onChanged: (value) {
              setState(() {
                selectedPriceRange = value;
              });
            },
            selected_value: selectedPriceRange,
          ),
        ],
      ),
    );
  }
}

class FilterOption extends StatelessWidget {
  final String? title;
  final List<String>? options;
  final String? selected_value;
  final Function(String?)? onChanged;

  FilterOption({
    @required this.title,
    @required this.options,
    @required this.selected_value,

    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Padding(
            padding:  EdgeInsets.only(top: 5),
            child: BlueTextRegularNunita(title: title!, weight: FontWeight.w500, size: 18)
          ),

          DropdownButton<String>(
            value: selected_value,
            hint: Text("Select value".tr(),style: TextStyle(
              fontSize: 13
            ),),
            onChanged: onChanged ,
            underline: Text(""),
            items: options?.map((option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(option),
              );
            }).toList(),
          ),

        ],
      ),
    );
  }
}
List<String> getPriceRanges() {
  List<String> priceRanges = [];
  int maxPrice = 10000000;
  int step = 200000 ;

  for (int i = 100000; i <= maxPrice; i += step) {
    int endRange = i + step - 1;
    if (endRange > maxPrice) {
      endRange = maxPrice;
    }
    String range = 'egp$i - egp$endRange';
    priceRanges.add(range);
  }

  return priceRanges;
}



List<String> getModelsForManufacturer(String manufacturer) {
  List<String> models = [];

  var selectedManufacturer = groupedCarModels.firstWhere(
        (carModel) => carModel['Manufacturer'] == manufacturer,
  );

  if (selectedManufacturer != null) {
    models = List<String>.from(selectedManufacturer['Models']);
  }

  return models;
}

List<String> getManufacturers() {
  List<String> manufacturers = [];

  for (var carModel in groupedCarModels) {
    manufacturers.add(carModel['Manufacturer']);
  }

  return manufacturers;
}

String? selectedManufacturer;
String? selectedModel;
String? selectedPriceRange;
