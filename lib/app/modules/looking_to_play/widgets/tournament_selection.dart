import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:golf_game_play/app/modules/looking_to_play/controllers/tournament_selection_controller.dart';
import 'package:golf_game_play/app/modules/looking_to_play/model/tournament_selection_model.dart';
import 'package:golf_game_play/app/modules/looking_to_play/widgets/small_tournament_card_item.dart';
import 'package:golf_game_play/app/modules/looking_to_play/widgets/tournament_selection_cartitem.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/widgets/bottomSheet_top_line.dart';
import 'package:golf_game_play/common/widgets/spacing.dart';

class TournamentSelection extends StatefulWidget {
  const TournamentSelection({
    super.key,
  });

  @override
  State<TournamentSelection> createState() => _TournamentSelectionState();
}

class _TournamentSelectionState extends State<TournamentSelection> {
  final TournamentSelectionController _tournamentSelectionController =
      Get.put(TournamentSelectionController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((__) async {
      await _tournamentSelectionController.fetchMyTournaments();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BottomSheetTopLine(),
        verticalSpacing(10.h),
        Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Text(AppString.chooseTournamentText, style: AppStyles.h3()),
        ),
        /// Big Tournament
        verticalSpacing(10.h),
        Text('--Club tournament--', style: AppStyles.h5()),
        Obx(() {
         List<BigTournament>  bigTournament = _tournamentSelectionController.tournamentSelectionModel.value.data?.attributes?.bigTournament??[];
         if(_tournamentSelectionController.isLoading.value){
           return Center(child: CupertinoActivityIndicator());
         }
         if(bigTournament.isEmpty){
           return Text('Your club tournament not created yet',style: AppStyles.h4(),);
         }
          return Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: bigTournament.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
               final bigTournamentIndex = bigTournament[index];
                return ClubTournamentSelectionCardItem(bigTournament: bigTournamentIndex,);
              },
            ),
          );
        }),
        /// Small Tournament
        Divider(height: 2, color: Colors.black54),
        verticalSpacing(10.h),
        Text('--Small Outing--', style: AppStyles.h5()),
        Obx(() {
          List<SmallTournament>  bigTournament = _tournamentSelectionController.tournamentSelectionModel.value.data?.attributes?.smallTournament??[];
          if(_tournamentSelectionController.isLoading.value){
            return Center(child: CupertinoActivityIndicator());
          }
          if(bigTournament.isEmpty){
            return Text('Your small outing not created yet',style: AppStyles.h4(),);
          }
          return Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: bigTournament.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                final bigTournamentIndex=bigTournament[index];
                return SmallTournamentSelectionCardItem(smallTournament: bigTournamentIndex,);
              },
            ),
          );
        }),
      ],
    );
  }
}
