import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spooker/data/model/artwork.dart';
import 'package:spooker/data/remote/artwork/artwork_data_source.dart';

import '../FirestoreConstants.dart';

class ArtworkDataSourceImpl extends ArtworkDataSource {
  ArtworkDataSourceImpl(this._firebaseFirestore);

  final FirebaseFirestore _firebaseFirestore;

  @override
  Future<void> createNewArtwork() async {}

  @override
  Future<void> deleteNewArtwork() async {}

  @override
  Future<List<Artwork>> fetchArtworks() async {
    var artworks = <Artwork>[];
    await _firebaseFirestore
        .collection(FirestoreConstants.artworksCollection)
        .get()
        .then(
          (querySnapshot) => querySnapshot.docs.forEach(
            (element) {
              artworks.add(
                Artwork.fromMap(element.data()),
              );
            },
          ),
        );
    return artworks;
  }
}
