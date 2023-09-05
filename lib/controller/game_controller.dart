/* import 'dart:async';
import 'dart:developer';

import 'package:flip_game/model/card_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameController extends GetxController {
  static GameController gameControllerInstance = Get.find();

  @override
  void onInit() async {
    super.onInit();
    await loadBestTime();

    resetGame();
    startTimer();
  }

//timer section
  var seconds = 0.obs;
  late Timer timer;

  final RxBool _isTimerActive = true.obs;
  bool get isTimerActive => _isTimerActive.value;

  resetTimer() {
    seconds.value = 0;
  }

  int bestTime = 0;

  // SharedPreferences key for storing best time
  static const String bestTimeKey = 'best_time';

  Future<void> loadBestTime() async {
    final prefs = await SharedPreferences.getInstance();
    bestTime = prefs.getInt(bestTimeKey) ?? 0;
    update();
  }

  Future<void> saveBestTime() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(bestTimeKey, bestTime);
    update();
  }

  void startTimer() {
    _isTimerActive.value = true;
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      seconds++;
    });
  }

  void stopTimer() {
    if (timer.isActive) {
      _isTimerActive.value = false;
      timer.cancel();
      if (seconds < bestTime || bestTime == 0) {
        bestTime = seconds.value;
        saveBestTime();
      }
    }
  }

  @override
  void onClose() {
    timer.cancel();
    super.onClose();
  }

  //resetGame

  void resetGame() async {
    log("in reset");
    resetTimer();
    _isTimerActive.value = true;

    for (var card in cards) {
      card.isFlipped = false;
      card.isMatched = false;
    }
    await setShuffledCards();
    flippedCount.value = 0;
    matchedCount.value = 0;
  }

  //card_game_logic

  RxList<CardModel> cards = List<CardModel>.generate(
    8,
    (index) => CardModel(id: index + 1),
  ).obs;

  RxInt flippedCount = 0.obs;
  RxInt matchedCount = 0.obs;

  RxBool isFlipped = false.obs;

  RxList<CardModel> shuffleCards = <CardModel>[].obs;

  Future<void> setShuffledCards() async {
    log("inhere");
    shuffleCards.clear();
    List<CardModel> tempCards = cards;
    tempCards.shuffle();
    shuffleCards.addAll(tempCards);
    log("$shuffleCards");
  }

  bool get allCardsMatched => matchedCount.value == cards.length;

  void flipCard(int index) {
    final card = shuffleCards[index];
    if (!card.isFlipped && flippedCount.value < 2) {
      shuffleCards[index].isFlipped = true;
      isFlipped.value = true;
      flippedCount.value++;
      if (flippedCount.value == 2) {
        Future.delayed(const Duration(seconds: 1), () {
          checkMatchedCards();
        });
      }
    }
  }

  void checkMatchedCards() {
    final flippedCards = cards.where((card) => card.isFlipped).toList();
    if (flippedCards.length == 2) {
      if (flippedCards[0].id == flippedCards[1].id) {
        flippedCards[0].isMatched = true;
        flippedCards[1].isMatched = true;
        matchedCount.value += 2;
        if (allCardsMatched) {
          log("win");
        }
      } else {
        for (var card in flippedCards) {
          card.isFlipped = false;
          isFlipped.value = false;
        }
      }
      flippedCount.value = 0;
    }
  }
}
 */

import 'dart:async';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameController extends GetxController {
  static GameController gameControllerInstance = Get.find();

  @override
  void onInit() async {
    super.onInit();
    await loadBestTime();

    //resetGame();
    startTimer();
  }

  // Timer section
  var seconds = 0.obs;
  late Timer timer;

  final RxBool _isTimerActive = true.obs;
  bool get isTimerActive => _isTimerActive.value;

  resetTimer() {
    seconds.value = 0;
  }

  int bestTime = 0;

  // SharedPreferences key for storing best time
  static const String bestTimeKey = 'best_time';

  Future<void> loadBestTime() async {
    final prefs = await SharedPreferences.getInstance();
    bestTime = prefs.getInt(bestTimeKey) ?? 0;
    update();
  }

  Future<void> saveBestTime() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(bestTimeKey, bestTime);
    update();
  }

  void startTimer() {
    _isTimerActive.value = true;
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      seconds++;
    });
  }

  void stopTimer() {
    if (timer.isActive) {
      _isTimerActive.value = false;
      timer.cancel();
      if (seconds < bestTime || bestTime == 0) {
        bestTime = seconds.value;
        saveBestTime();
      }
    }
  }

  @override
  void onClose() {
    timer.cancel();
    super.onClose();
  }

  // Reset Game

  void resetGame() {
    log("in reset");
    resetTimer();
    _isTimerActive.value = true;

    for (int i = 0; i < cardValues.length; i++) {
      isFlipped[i] = false;
      isMatched[i] = false;
    }
    setShuffledCards();
    flippedCount.value = 0;
    matchedCount.value = 0;
  }

  // Card game logic

  // List<Map<String, dynamic>> cards = List.generate(
  //   8,
  //   (index) => {
  //     'id': index + 1,
  //     'isFlipped': false,
  //     'isMatched': false,
  //   },
  // );
  RxList<int> cardValues = [1, 2, 3, 4, 1, 2, 3, 4].obs;
  RxList<bool> isFlipped = List.generate(8, (index) => false).obs;
  RxList<bool> isMatched = List.generate(8, (index) => false).obs;

  RxInt flippedCount = 0.obs;
  RxInt matchedCount = 0.obs;

  // RxBool isFlipped = false.obs;

  RxList<int> shuffleCards = <int>[].obs;

  void setShuffledCards() {
    log("in here");
    shuffleCards.clear();
    List<int> tempCards = List.from(cardValues);
    tempCards.shuffle();
    shuffleCards.addAll(tempCards);
    log("$shuffleCards");
  }

  bool get allCardsMatched => matchedCount.value == shuffleCards.length;

  List<int> newflipIndex = [];
  void flipCard(int index) {
    //final card = shuffleCards[index];
    if (!isFlipped[index] && flippedCount.value < 2) {
      isFlipped[index] = true;
      newflipIndex.add(index);

      flippedCount.value++;
      if (flippedCount.value == 2) {
        log("$newflipIndex newindex");
        Future.delayed(const Duration(seconds: 1), () {
          checkMatchedCards();
        });
      }
    }
  }

  void checkMatchedCards() {
    List<int> flippedCards = [];
    List<int> indexes = [];
    for (int i = 0; i < shuffleCards.length; i++) {
      if (isFlipped[i] == true && newflipIndex.contains(i)) {
        flippedCards.add(shuffleCards[i]);
        indexes.add(i);
      }
    }
   
    log("$flippedCards - flipped");
    if (flippedCards.length == 2) {
      if (flippedCards[0] == flippedCards[1]) {
        log("inside true ");
        isMatched[0] = true;
        isMatched[1] = true;
        matchedCount.value += 2;
        if (allCardsMatched) {
          log("win");
        }
      } else {
        for (int i = 0; i < flippedCards.length; i++) {
          isFlipped[indexes[i]] = false;
        }
        log("$isFlipped");
      }
      flippedCount.value = 0;
      newflipIndex.clear();
    }
  }
}
