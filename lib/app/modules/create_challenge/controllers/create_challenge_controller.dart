
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:golf_game_play/app/data/api_constants.dart';
import 'package:golf_game_play/app/modules/assign_group/controllers/assign_group_controller.dart';
import 'package:golf_game_play/app/modules/assign_group/model/tournament_player_list_model.dart';
import 'package:golf_game_play/common/prefs_helper/prefs_helpers.dart';
import 'package:http/http.dart' as http;

class CreateChallengeController extends GetxController {

  List tournamentNameList = ['Spring', 'Summer', 'Winter'];
  List player1List = ['Player 1','Player 2', 'Player 3','Player 4','Player 5','Player 6'];
  List player2List = ['Player A','Player B', 'Player C','Player D','Player E','Player F'];
  String? tournamentName;
  String? player1;
  String? player2;

  Rx<TournamentPlayerListModel> tournamentPlayerListModel = TournamentPlayerListModel().obs;
  RxBool isLoading2= false.obs;

  RxList<GroupPlayer> groupPlayer = <GroupPlayer>[].obs;

  fetchTournamentPlayer(String tournamentType, String tournamentId) async {
    isLoading2.value = true;
    try {
      String token = await PrefsHelper.getString('token');
      String userId = await PrefsHelper.getString('userId');

      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };

      var request = http.Request('GET', Uri.parse(ApiConstants.tournamentPlayerUrl(tournamentType, tournamentId)));

      request.headers.addAll(headers);
      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);
      print('Response body: ${responseBody.body}');
      Map<String,dynamic> decodedBody = jsonDecode(responseBody.body);

      if (response.statusCode == 200) {
        tournamentPlayerListModel.value= TournamentPlayerListModel.fromJson(decodedBody);
        print(tournamentPlayerListModel.value);
      } else {
        print('Error: ${response.statusCode}');
        Get.snackbar('Failed', decodedBody['message']);
      }
    } on SocketException catch (_) {
      Get.snackbar(
        'Error',
        'No internet connection. Please check your network and try again.',
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again later.',
        snackPosition: SnackPosition.TOP,
      );
      print(e);
    } finally {
      isLoading2.value = false;
    }
  }


}
