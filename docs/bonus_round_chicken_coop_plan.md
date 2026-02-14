# Implementation Plan: Bonus Round - Chicken Coop Egg Catch

## Overview
This bonus round occurs after Level 2. It introduces a new gameplay mechanic: catching falling eggs by moving Ernie left and right.

## Assets
- **Background**: `assets/images/bonus_rounds/chicken_coop.webp`
- **Chickens**: `assets/images/bonus_rounds/chicken_1.png`, `assets/images/bonus_rounds/chicken_2.png`, etc.
- **Items**: `assets/images/bonus_rounds/egg.png` (Need to verify if this exists or if I should use a generic egg)
- **Ernie**: Existing sprites, but will move horizontally.

## Technical Changes

### 1. GameState (lib/providers/game_state.dart)
- [ ] Add `BonusRoundType` enum (e.g., `goldenDash`, `eggCatch`).
- [ ] Update `GameState` to track `currentBonusType`.
- [ ] Update `isBonusRoundEarned` logic to allow Level 2 bonus.
- [ ] Update `startBonusRound` to set the correct `BonusRoundType` based on level.

### 2. Obstacle System (lib/game/obstacle_manager.dart)
- [ ] Add `ObstacleType.egg`.
- [ ] Implement falling logic for eggs (vertical movement instead of horizontal).
- [ ] Implement egg spawning from the top of the screen.

### 3. Gameplay Screen (lib/screens/game/game_loop_screen.dart)
- [ ] Add horizontal movement for Ernie during `eggCatch` bonus round.
- [ ] Update `_gameLoop` to handle horizontal input (left/right screen touch).
- [ ] Render chickens at the top of the screen during this mode.
- [ ] Handle catch collision.

### 4. Audio (lib/services/audio_service.dart)
- [ ] (Optional) Add egg catch sound effect.
- [ ] Add chicken clucking sound or specific BGM.

## Implementation Steps

### Phase 1: Core Definitions
- Define `BonusRoundType`.
- Add `ObstacleType.egg`.
- Update `GameState` triggers.

### Phase 2: Egg Falling Logic
- Modify `ObstacleManager` to support falling objects.
- Adjust `_spawnObstacle` for the egg catch theme.

### Phase 3: Ernie's Horizontal Move
- Implement horizontal position tracking in `_GameLoopScreenState`.
- Add touch detection for left/right sides.

### Phase 4: Visual Polish
- Implement the Chicken Coop background.
- Position chickens at the top.
- Add egg breaking animation/effect when hitting the ground? (Optional)
