import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:spooker/data/model/artwork.dart';
import 'package:spooker/data/remote/artwork/artwork_data_source.dart';

import '../FirestoreConstants.dart';

class ArtworkDataSourceImpl extends ArtworkDataSource {
  ArtworkDataSourceImpl(this._firestore, this._storage, this._firebaseAuth);

  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;
  final FirebaseAuth _firebaseAuth;

  @override
  Future<void> createNewArtwork(Artwork artwork) async {
    final artworkRef = _storage.ref().child('${artwork.name}.jpg');
    File file = File(artwork.imagePath);
    await artworkRef.putFile(file);
    var url = await artworkRef.getDownloadURL();
    artwork.imagePath = url;
    artwork.userId = await getUserId();
    await _firestore
        .collection(FirestoreConstants.artworksCollection)
        .add(artwork.toMap())
        .then((value) {})
        .catchError((error) {});
  }

  @override
  Future<void> deleteNewArtwork(String artworkId) async {
    await _firestore
        .collection(FirestoreConstants.artworksCollection)
        .doc(artworkId)
        .delete()
        .then((querySnapshot) {})
        .catchError((error) {});
  }

  @override
  Future<List<Artwork>> fetchArtworks() async {
    var artworks = <Artwork>[];
    await _firestore
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

  @override
  Future<List<Artwork>> fetchMyArtworks() async {
    var userId = await getUserId();
    var artworks = <Artwork>[];
    await _firestore
        .collection(FirestoreConstants.artworksCollection)
        .where(FirestoreConstants.user, isEqualTo: userId)
        .get()
        .then(
          (querySnapshot) => querySnapshot.docs.forEach(
            (element) {
              var artwork = Artwork.fromMap(element.data());
              artwork.id = element.id;
              artworks.add(artwork);
            },
          ),
        );
    return artworks;
  }

  @override
  Future<void> updateArtwork(Artwork artwork) {
    // TODO: implement updateArtwork
    throw UnimplementedError();
  }

  Future<String> getUserId() async {
    var userId = '';
    final currentUser = _firebaseAuth.currentUser;
    await _firestore
        .collection(FirestoreConstants.usersCollection)
        .where(FirestoreConstants.email, isEqualTo: currentUser!.email)
        .get()
        .then((querySnapshot) {
      userId = querySnapshot.docs.first.id;
    });
    return userId;
  }
}
