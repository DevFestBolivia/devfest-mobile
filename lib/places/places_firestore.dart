import 'package:devfestbolivia/models/place.dart';
import 'package:devfestbolivia/firebase/cloud_firestore.dart';
import 'package:devfestbolivia/firebase/collection_name.dart';

class PlacesFirestore extends CloudFireStore {
  Future<List<Place>> getAllPlacesFirestore() async {
    final querySnapshot = await db.collection(CollectionName.PLACES).get();
    final places =
        querySnapshot.docs.map((doc) => Place.fromJson(doc.data())).toList();
    return places;
  }
}
