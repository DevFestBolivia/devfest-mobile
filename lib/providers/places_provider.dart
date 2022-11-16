import 'package:devfestbolivia/models/place.dart';
import 'package:devfestbolivia/places/places_firestore.dart';
import 'package:flutter/material.dart';

enum PlacesState {
  initial,
  loading,
  failure,
  loaded,
}

class PlacesProvider extends ChangeNotifier {
  PlacesProvider({
    required PlacesFirestore placesFirestore,
  }) : _placesFirestore = placesFirestore;

  final PlacesFirestore _placesFirestore;

  PlacesState state = PlacesState.initial;
  late List<Place> places;
  String? errorMessage;

  void getAllPlaces() async {
    try {
      state = PlacesState.loading;
      notifyListeners();
      places = await _placesFirestore.getAllPlacesFirestore();
      state = PlacesState.loaded;
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
      state = PlacesState.failure;
      notifyListeners();
    }
  }
}
