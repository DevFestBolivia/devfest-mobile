import 'package:devfestbolivia/models/place.dart';
import 'package:devfestbolivia/places/places_firestore.dart';
import 'package:devfestbolivia/providers/places_provider.dart';
import 'package:devfestbolivia/style/devfest_colors.dart';
import 'package:devfestbolivia/style/spacing.dart';
import 'package:devfestbolivia/text_strings.dart';
import 'package:devfestbolivia/utils/map_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PlacesScreen extends StatefulWidget {
  const PlacesScreen({super.key});

  @override
  State<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PlacesProvider(
        placesFirestore: PlacesFirestore(),
      )..getAllPlaces(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: DevFestColors.primary,
          title: Text(
            TextStrings.tourismInCochabamba.toUpperCase(),
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: DevFestColors.primaryLight,
                ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: SpacingValues.l,
            vertical: SpacingValues.xxl,
          ),
          child: Consumer<PlacesProvider>(
            builder: (_, placesProvider, child) {
              if (placesProvider.state == PlacesState.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (placesProvider.state == PlacesState.loaded) {
                final places = placesProvider.places;

                return ListView.builder(
                  itemCount: places.length,
                  itemBuilder: (context, index) {
                    final place = places[index];
                    return _PlaceCard(place: place);
                  },
                );
              }

              if (placesProvider.state == PlacesState.failure) {
                return Center(
                  child: Text(
                      'Hubo un problema al cargar datos \n ${placesProvider.errorMessage!}'),
                );
              }

              return Container();
            },
          ),
        ),
      ),
    );
  }
}

class _PlaceCard extends StatelessWidget {
  const _PlaceCard({
    required this.place,
  });

  final Place place;

  final _imageCardHeight = 184.0;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: SpacingValues.l,
              vertical: SpacingValues.m,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  place.title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                VerticalSpacing.xs,
                Text(
                  place.subtitle,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          SizedBox(
            height: _imageCardHeight,
            width: double.infinity,
            child: Image.network(
              place.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () async {
                  MapUtils.openMap(place.latitude, place.longitude);
                },
                child: Text(
                  TextStrings.showOnMap,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: DevFestColors.primary,
                      ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
