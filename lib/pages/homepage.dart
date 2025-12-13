import 'package:flutter/material.dart';
import 'dart:math';

enum GameState { playing, won, lost }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController controller = TextEditingController();

  int count = 10;
  int targetNumber = Random().nextInt(100) + 1;
  String indicator = '';
  GameState gameState = GameState.playing;
  final List<int> previousGuesses = [];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void submitGuess() {
    if (gameState != GameState.playing) return;

    final int? guess = int.tryParse(controller.text);

    if (guess == null || guess < 1 || guess > 100) {
      setState(() {
        indicator = 'Enter a valid number between 1 and 100';
      });
      return;
    }

    setState(() {
      previousGuesses.add(guess);
      count--;

      if (guess < targetNumber) {
        indicator = '$guess is too low';
      } else if (guess > targetNumber) {
        indicator = '$guess is too high';
      } else {
        indicator = '🎉 Correct! Number was $targetNumber';
        gameState = GameState.won;
      }

      if (count == 0 && gameState != GameState.won) {
        indicator = '❌ Game Over! Number was $targetNumber';
        gameState = GameState.lost;
      }

      controller.clear();
    });
  }

  void resetGame() {
    setState(() {
      targetNumber = Random().nextInt(100) + 1;
      count = 10;
      previousGuesses.clear();
      indicator = '';
      gameState = GameState.playing;
      controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Try to guess the number between 1 and 100\n'
                'You have 10 attempts to guess the correct number.',
                textAlign: TextAlign.center,
                style: TextStyle(color: scheme.onBackground, fontSize: 12),
              ),
              const SizedBox(height: 12),
              Text(
                'Guess the Number',
                style: TextStyle(
                  color: scheme.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                enabled: gameState == GameState.playing,
                decoration: InputDecoration(
                  hintText: 'Enter your guess',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: gameState == GameState.playing ? submitGuess : null,
                child: const Text('Submit Guess'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: resetGame,
                child: const Text('Reset Game'),
              ),
              const SizedBox(height: 12),
              Text(
                'Attempts left: $count',
                style: TextStyle(color: scheme.onBackground),
              ),
              const SizedBox(height: 8),
              Text(
                'Previous guesses: ${previousGuesses.join(', ')}',
                textAlign: TextAlign.center,
                style: TextStyle(color: scheme.onBackground),
              ),
              const SizedBox(height: 12),
              Text(
                indicator,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: gameState == GameState.won
                      ? Colors.green
                      : gameState == GameState.lost
                      ? Colors.red
                      : scheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
