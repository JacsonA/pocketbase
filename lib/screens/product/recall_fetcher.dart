import 'package:flutter/material.dart';
import 'package:formation_flutter/api/pocketbase_api.dart';
import 'package:formation_flutter/model/recall.dart';

class RecallFetcher extends ChangeNotifier {
  RecallFetcher({required String barcode})
    : _barcode = barcode,
      _state = RecallFetcherLoading() {
    loadRecall();
  }

  final String _barcode;
  RecallFetcherState _state;

  Future<void> loadRecall() async {
    // on met en mod chargement l'tps dla requete
    _state = RecallFetcherLoading();
    notifyListeners();

    try {
      final pb = PocketBaseAPI().client;

      final result = await pb
          .collection('rappels')
          .getList(
            page: 1,
            perPage: 1,
            filter:
                'gtin="$_barcode"', // on recup just le rappel qui match avc le code-bar
          );

      if (result.items.isNotEmpty) {
        final recall = Recall.fromRecord(result.items.first);
        _state = RecallFetcherSuccess(recall);
      } else {
        _state = RecallFetcherNoRecall();
      }
    } catch (error) {
      _state = RecallFetcherError(error);
    } finally {
      notifyListeners();
    }
  }

  RecallFetcherState get state => _state;
}

sealed class RecallFetcherState {}

class RecallFetcherLoading extends RecallFetcherState {}

class RecallFetcherNoRecall extends RecallFetcherState {}

class RecallFetcherSuccess extends RecallFetcherState {
  RecallFetcherSuccess(this.recall);

  final Recall recall;
}

class RecallFetcherError extends RecallFetcherState {
  RecallFetcherError(this.error);

  final dynamic error;
}
