// lib/features/player_record/controllers/player_record_controller.dart
import 'package:get/get.dart';

import '../../Model/player_record_model.dart';

class PlayerRecordController extends GetxController {
  final PlayerRecordRepository _repository = PlayerRecordRepository();
  final isLoading = false.obs;
  final error = RxString('');
  final playerRecord = Rx<PlayerRecordResponse?>(null);

  Future<void> fetchPlayerRecord({
    required String playerId,
    required String tournamentId,
    required String oppTeamId,
    required String oppPlayerId,
    required String format,
    required String lstGroundId,
    required String bowlingType,
    required String bowlingArm,
    required String battingType,
  }) async {
    try {
      isLoading(true);
      error('');
      final result = await _repository.getPlayerRecord(
        playerId: playerId,
        tournamentId: tournamentId,
        oppTeamId: oppTeamId,
        oppPlayerId: oppPlayerId,
        format: format,
        lstGroundId: lstGroundId,
        bowlingType: bowlingType,
        bowlingArm: bowlingArm,
        battingType: battingType,
      );
      playerRecord(result);
    } catch (e) {
      error(e.toString());
    } finally {
      isLoading(false);
    }
  }
}