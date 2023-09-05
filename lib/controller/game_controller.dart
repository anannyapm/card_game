import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
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

  RxInt bestTime = 0.obs;

  // SharedPreferences key for storing best time
  static const String bestTimeKey = 'best_time';

  Future<void> loadBestTime() async {
    final prefs = await SharedPreferences.getInstance();
    bestTime.value = prefs.getInt(bestTimeKey) ?? 0;
    update();
  }

  Future<void> saveBestTime() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(bestTimeKey, bestTime.value);
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
      if (seconds < bestTime.value || bestTime.value == 0) {
        bestTime.value = seconds.value;
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
          stopTimer();
          //bestTime.value = seconds.value;
          saveBestTime();
          Get.snackbar("Yay", "You Win!!!!",
              backgroundColor: Colors.green, colorText: Colors.white);
          resetGame();
          startTimer();
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
