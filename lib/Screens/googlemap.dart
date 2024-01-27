import 'package:flutter/material.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';

const kGoogleApiKey = "AIzaSyApnhrulne3KHGhuiQyIgmwbEYv2XUAVFc";

class PlaceAutocompleteScreen extends StatefulWidget {
  @override
  _PlaceAutocompleteScreenState createState() =>
      _PlaceAutocompleteScreenState();
}

class _PlaceAutocompleteScreenState extends State<PlaceAutocompleteScreen> {
  TextEditingController _searchController = TextEditingController();
  List<AutocompletePrediction> _predictions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Address'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Search for a place...',
              ),
            ),
            SizedBox(height: 16),
            _buildPredictionsList(),
          ],
        ),
      ),
    );
  }

  void _onSearchChanged(String query) async {
    final places = FlutterGooglePlacesSdk(kGoogleApiKey);
    final predictions = await places.findAutocompletePredictions(query);
    FindAutocompletePredictionsResponse ? data = predictions as FindAutocompletePredictionsResponse;
    setState(() {

    _predictions=data.predictions;
    });
  }

  Widget _buildPredictionsList() {
    return Expanded(
      child: ListView.builder(
        itemCount: _predictions.length,
        itemBuilder: (context, index) {
          final prediction = _predictions[index];
          return ListTile(
            title: Text(prediction.fullText),
            onTap: () {
              // Handle the selected prediction

              _searchController.text = prediction.fullText;
              Navigator.pop(context,prediction.fullText);
            },
          );
        },
      ),
    );
  }
}


