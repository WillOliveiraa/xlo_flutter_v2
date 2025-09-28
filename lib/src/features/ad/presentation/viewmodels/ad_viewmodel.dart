import 'package:command_it/command_it.dart';
import 'package:dartz/dartz.dart';
import 'package:xlo_flutter_v2/src/features/ad/application/usecases/save_ad.dart';
import 'package:xlo_flutter_v2/src/features/ad/domain/entities/ad.dart';

class AdViewmodel {
  final SaveAd _saveAdUsecase;
  late final Command<Ad, Unit?> saveAdCommand;

  AdViewmodel(this._saveAdUsecase) {
    saveAdCommand = Command.createAsync(_saveAd, initialValue: null);
  }

  Future<Unit?> _saveAd(Ad input) async {
    final result = await _saveAdUsecase(input);
    await Future.delayed(const Duration(seconds: 2));
    return result.fold((l) => throw l, (data) => data);
  }
}
