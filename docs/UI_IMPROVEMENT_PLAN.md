# 🎨 Fay Gator Run — UI/UX Improvement Plan

> **Goal:** Modernize the UI, reduce clutter, improve mobile-friendliness, and maintain all critical user-facing information.

---

## 📋 Table of Contents

1. [Global Issues & Quick Wins](#1-global-issues--quick-wins)
2. [Login Screen](#2-login-screen)
3. [Sign Up Screen](#3-sign-up-screen)
4. [Student Select Screen](#4-student-select-screen)
5. [Student Setup Screen (Onboarding)](#5-student-setup-screen-onboarding)
6. [Main Menu / Dashboard](#6-main-menu--dashboard)
7. [Game Loop HUD](#7-game-loop-hud)
8. [Quiz Overlay](#8-quiz-overlay)
9. [Leaderboard Screen](#9-leaderboard-screen)
10. [Mobile / Portrait Mode Strategy](#10-mobile--portrait-mode-strategy)
11. [Design System Upgrades](#11-design-system-upgrades)

---

## 1. Global Issues & Quick Wins

### 🔴 P0 — Remove Unnecessary/Raw Data Shown to Users

| Issue | File | Fix |
|-------|------|-----|
| **Raw error `e.toString()` shown in SnackBars** — exposes technical Supabase/Dart errors to parents & kids | `login_screen.dart:66`, `sign_up_screen.dart:56`, `student_setup_screen.dart:91`, `main_menu_screen.dart:147` | Replace with friendly messages: *"Oops! Something went wrong. Please try again."* Log the real error with `debugPrint` only. |
| **Debug auto-login in release** — `kDebugMode` pre-fills email/password; safe, but the `force: true` auto-login flow can confuse | `login_screen.dart:15-19, 41-46` | Ensure it's gated by `kDebugMode` (it is), but clean up the UX: remove visible pre-filled text in release. |
| **Bonus Test card visible in release?** — `kDebugMode ? 11 : 10` controls visibility. Verify it's not leaking. | `main_menu_screen.dart:546-560` | Already gated. No change needed — just verify in a release build. |

### 🟡 P1 — Friendlier Error Handling Pattern (All Screens)

Instead of:
```dart
SnackBar(content: Text('Error: ${e.toString()}'))
```
Use:
```dart
SnackBar(
  content: Row(
    children: [
      Icon(Icons.warning_amber_rounded, color: Colors.white),
      SizedBox(width: 8),
      Expanded(child: Text('Oops! Something went wrong. Please try again.')),
    ],
  ),
  backgroundColor: Colors.redAccent,
  behavior: SnackBarBehavior.floating,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
)
```

---

## 2. Login Screen

**Current State:** Clean gradient background, school icon, two text fields, gold button. Solid starting point.

### Proposed Changes

| Category | Change | Priority |
|----------|--------|----------|
| **Branding** | Replace generic `Icons.school` with the actual Ernie mascot image (`ernie_run.png`) for instant brand recognition | 🟢 High |
| **Layout** | Add `ConstrainedBox(maxWidth: 420)` to center the form card on tablets/web, preventing it from stretching full-width | 🟢 High |
| **Animation** | Add a subtle `FadeIn` + `SlideUp` animation on the form when the screen loads (200ms stagger per element) | 🟡 Medium |
| **Password** | Add a visibility toggle icon on the password field (eye icon) | 🟡 Medium |
| **Visual Polish** | Add a faint radial glow behind the mascot image | 🟠 Low |

### Mobile Considerations
- Already uses `SingleChildScrollView` ✅
- Already uses `SafeArea` ✅
- Form fields are full-width — works well on small screens ✅

---

## 3. Sign Up Screen

**Current State:** Navy background, school icon, card-based form with side-by-side name fields.

### Proposed Changes

| Category | Change | Priority |
|----------|--------|----------|
| **Layout** | On narrow screens (`MediaQuery.of(context).size.width < 500`), stack First Name / Last Name vertically instead of side-by-side `Row` | 🟢 High |
| **Branding** | Replace `Icons.school` with Ernie mascot (same as login) | 🟢 High |
| **Form Card** | Add `ConstrainedBox(maxWidth: 480)` so it doesn't span the full width on tablets/landscape | 🟢 High |
| **Password** | Add visibility toggle | 🟡 Medium |
| **Card Style** | Add subtle shadow + border radius matching the theme (16→20px) for consistency | 🟠 Low |
| **Success Dialog** | Style the `AlertDialog` to match the FayTheme (Navy bg, white text, gold button) instead of default Material | 🟡 Medium |

---

## 4. Student Select Screen

**Current State:** Navy bg, grid of gold cards with avatar circles, grade badges, an "Add Student" card.

### Proposed Changes

| Category | Change | Priority |
|----------|--------|----------|
| **Avatar** | Replace generic `Icons.face` with distinct, fun avatar icons per student (e.g., based on first letter or a random seed → select from 6-8 cartoon animal icons) | 🟢 High |
| **Card Interaction** | Add a subtle scale animation on tap (`Transform.scale`) with haptic feedback | 🟡 Medium |
| **Grid Responsiveness** | Adjust `maxCrossAxisExtent` dynamically: `220` on desktop, `160` on mobile portrait — use `LayoutBuilder` | 🟢 High |
| **Logout Button** | Add a text label "Log Out" next to the icon for clarity (parents may not know what the icon means) | 🟡 Medium |
| **Empty State** | When no students exist, show a friendly illustration + "Add your first student!" message instead of an empty grid | 🟡 Medium |

---

## 5. Student Setup Screen (Onboarding)

**Current State:** Simple form with a large face icon, text field, grade dropdown, nickname generator.

### Proposed Changes

| Category | Change | Priority |
|----------|--------|----------|
| **Visual** | Replace `Icons.face` with a randomly animated Ernie character or a selectable avatar picker | 🟢 High |
| **Background** | Match the navy gradient background from other screens for consistency (currently uses scaffold default bg) | 🟢 High |
| **Form Layout** | Wrap everything in a card with `ConstrainedBox(maxWidth: 500)` and center it | 🟢 High |
| **Nickname UX** | Auto-generate a nickname as soon as the name field has 2+ characters (remove the manual button step) OR keep the button but make it more prominent + fun (pulsing glow?) | 🟡 Medium |
| **Buttons** | The dual "Save & Add Another" / "Finish & Play" buttons overlap on narrow screens → stack vertically on mobile | 🟢 High |

---

## 6. Main Menu / Dashboard

**Current State:** Gradient bg, floating academic icons, welcome text, top score, exam mode toggle, level grid with background images. This is the most complex and most important screen to optimize.

### Proposed Changes

| Category | Change | Priority |
|----------|--------|----------|
| **Clutter: Exam Mode** | Collapse `Exam Mode` into a **bottom sheet** or **expandable card** — it takes up too much vertical space when expanded and most users won't use it every session | 🟢 High |
| **Clutter: Reminder Note** | Remove the "Remember: Finish the level..." info box. It's important info, but can be shown as a **tooltip on first play** or a **one-time onboarding tip** instead of permanent UI real estate | 🟡 Medium |
| **Header Icons** | The top-right icon buttons (Leaderboard, Logout, Settings) have no labels. Add tooltips and consider grouping them into a **hamburger/overflow menu** on mobile, or adding labels on desktop | 🟢 High |
| **Level Grid** | On mobile/portrait web, the grid cards are too small. Use `LayoutBuilder` to adjust `maxCrossAxisExtent` (280 desktop → 160 mobile) and `childAspectRatio` (1.6 landscape → 1.2 portrait) | 🟢 High |
| **Level Cards** | Add the subject/topic name or a small icon to each level card to give context on what's being learned | 🟡 Medium |
| **Floating Background Icons** | The ambient icons at 5% opacity are a nice touch. No change needed. | ✅ Keep |
| **Welcome Section** | Tighten spacing. The welcome + nickname + top score section can be more compact | 🟡 Medium |
| **Scroll Performance** | The `SingleChildScrollView` with `NeverScrollableScrollPhysics` on the GridView is fine for small lists but should verify performance with many levels visible | 🟠 Low |

### Recommended Layout (Mobile Portrait):
```
┌──────────────────────┐
│ Grade Badge    [≡]   │  ← Hamburger replaces 3 icons
│                      │
│ Welcome Back,        │
│ Bayou Scholar ⭐     │
│ Top: 1200 PTS        │
│                      │
│ ┌──────┐ ┌──────┐    │
│ │  L1  │ │  L2  │    │  ← 2-column grid
│ │  ✓   │ │  ▶   │    │
│ └──────┘ └──────┘    │
│ ┌──────┐ ┌──────┐    │
│ │  L3  │ │  L4  │    │
│ │  🔒  │ │  🔒  │    │
│ └──────┘ └──────┘    │
│        ...           │
│                      │
│ [📝 Exam Mode]       │  ← Collapsible card at bottom
└──────────────────────┘
```

---

## 7. Game Loop HUD

**Current State:** Score pill, high-score pill, 5 hearts, pause button, progress bar. All overlaid on the game.

### Proposed Changes

| Category | Change | Priority |
|----------|--------|----------|
| **HUD Density** | On very small screens, the score pills + hearts + pause button can overflow. Use `Flexible` / `FittedBox` to auto-shrink | 🟢 High |
| **Score Display** | Merge `Score` and `Best` into a single compact widget: `450 / Best: 1200` to save horizontal space | 🟡 Medium |
| **Hearts** | Keep hearts at 18px but add a `FittedBox` wrapper to prevent overflow on tiny screens | 🟢 High |
| **Pause Screen** | The PAUSED overlay is functional but plain. Add a semi-transparent blur effect + the Ernie mascot for visual polish | 🟡 Medium |
| **Game Over Screen** | Currently a single minimal button. Enhance with: final score, number of questions answered correctly, a "Try Again" button, and a "Return to Menu" option | 🟢 High |
| **Level Complete** | Add a score summary: `Level Score: +150 | Total: 450` before the "Next Level" button | 🟡 Medium |
| **Orientation Warning** | Already implemented for web ✅. Ensure it also shows on native mobile if someone unlocks rotation. | 🟡 Medium |

### Game Over — Proposed Redesign:
```
┌──────────────────────────────┐
│        💀 GAME OVER 💀       │
│                              │
│     This Run: 450 PTS        │
│     Best: 1200 PTS           │
│     Questions Right: 8/12    │
│                              │
│  ┌──────────┐ ┌────────────┐ │
│  │ TRY AGAIN│ │RETURN HOME │ │
│  └──────────┘ └────────────┘ │
└──────────────────────────────┘
```

---

## 8. Quiz Overlay

**Current State:** Beautiful frosted card, gold header, animated scale entrance. This is one of the best-designed screens.

### Proposed Changes

| Category | Change | Priority |
|----------|--------|----------|
| **Feedback** | After answering, briefly show ✅ or ❌ with the correct answer before closing (300ms delay). Currently it silently closes. | 🟢 High |
| **Accessibility** | Increase button height from `18px vertical padding` to at least `48px` total touchable area for mobile compliance | 🟡 Medium |
| **Timer** | Consider adding a visible countdown timer (10-15 seconds?) to add urgency. Optional — discuss with stakeholders. | 🟠 Low |

---

## 9. Leaderboard Screen

**Current State:** Simple Navy bg with a list of entries. Top 3 highlighted with gold circle.

### Proposed Changes

| Category | Change | Priority |
|----------|--------|----------|
| **Top 3 Podium** | Replace the simple list for the top 3 with a visual **podium layout** (1st center + raised, 2nd left, 3rd right) with trophies 🥇🥈🥉 | 🟡 Medium |
| **Current Player Highlight** | Highlight the current user's entry with a subtle glow or different background color so they can find themselves | 🟡 Medium |
| **Empty State** | Already has one ✅ | ✅ Keep |
| **Pull-to-Refresh** | Add `RefreshIndicator` for pull-to-refresh on mobile | 🟡 Medium |

---

## 10. Mobile / Portrait Mode Strategy

### Current Problem
The app is **locked to landscape** (`DeviceOrientation.landscapeLeft/Right` in `main.dart`). This works for native mobile, but:
- **Web on mobile:** Users can access in portrait, hitting the rotation warning only in the game loop
- **Pre-game screens** (Login, Sign Up, Menu) are not optimized for portrait orientation at all

### Recommended Strategy

| Approach | Details |
|----------|---------|
| **Game Loop** | Keep landscape-only. The side-scroller requires it. The existing rotation warning is good. ✅ |
| **All Other Screens** | Allow **both orientations**. These screens are form-based or menu-based and should adapt naturally. |
| **Implementation** | In `main.dart`, only lock to landscape when entering `/game`. Unlock orientations on other routes. Use `SystemChrome.setPreferredOrientations` in each screen's `initState`/`dispose`. |
| **Responsive Breakpoints** | Define breakpoints: `< 600px` = mobile, `600-900px` = tablet, `> 900px` = desktop. Use these in `LayoutBuilder` across all screens. |

### Responsive Utilities (New File: `lib/core/responsive.dart`)
```dart
class Responsive {
  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < 600;
  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 600 &&
      MediaQuery.sizeOf(context).width < 900;
  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 900;
}
```

---

## 11. Design System Upgrades

### Theme Consistency

| Area | Current | Proposed |
|------|---------|----------|
| **Border Radius** | Mixed (12px, 16px, 20px, 24px, 32px) | Standardize: `sm: 8, md: 16, lg: 24, xl: 32` |
| **Spacing** | Inconsistent padding (12, 16, 20, 24, 32, 40) | Standardize to 8px grid: `xs: 4, sm: 8, md: 16, lg: 24, xl: 32` |
| **Button Styles** | Some buttons use theme, others override inline | Create 3 standard button variants in theme: Primary (Gold), Secondary (Navy), Danger (Red) |
| **Card Style** | Inconsistent card backgrounds and shadows | Create a reusable `FayCard` widget with standard styling |
| **Font Sizes** | Hardcoded throughout | Define in theme: `caption: 12, body: 16, title: 22, headline: 28, display: 36` |

### Proposed Reusable Widgets

1. **`FayCard`** — Consistent card with navy bg, gold border option, shadow  
2. **`FayButton`** — Primary/Secondary variants, loading state built-in  
3. **`FaySnackBar`** — Styled error/success/info snack bars (no raw errors)  
4. **`ResponsiveGrid`** — Wrapper that adjusts column count based on screen width  

---

## 📊 Implementation Priority

### Phase 1: Quick Wins (1-2 hours)
- [ ] Replace all raw `e.toString()` SnackBars with friendly messages
- [ ] Add `ConstrainedBox` max-width to Login/SignUp forms  
- [ ] Replace `Icons.school`/`Icons.face` with Ernie mascot image
- [ ] Add `Responsive` utility class
- [ ] Fix sign-up name fields stacking on mobile

### Phase 2: Mobile Responsiveness (2-3 hours)
- [ ] Unlock portrait mode for non-game screens
- [ ] Add responsive breakpoints to Student Select grid
- [ ] Add responsive breakpoints to Level Select grid on Main Menu
- [ ] Stack buttons vertically on narrow screens (Student Setup)
- [ ] Collapse Exam Mode into expandable card

### Phase 3: Polish & Delight (2-3 hours)
- [ ] Enhance Game Over screen with score summary
- [ ] Add quiz answer feedback (correct/incorrect flash)
- [ ] Style Pause screen with blur + mascot
- [ ] Add entrance animations to Login/SignUp screens
- [ ] Match Student Setup bg to other screens (navy gradient)
- [ ] Create `FayButton` and `FayCard` reusable widgets

### Phase 4: Advanced (Optional / Future)
- [ ] Leaderboard podium for top 3
- [ ] Student avatar picker/randomizer
- [ ] One-time onboarding tooltips instead of permanent UI hints
- [ ] Quiz countdown timer
- [ ] Pull-to-refresh on Leaderboard

---

## 🚫 What NOT to Change

- **Game physics/mechanics** — no gameplay changes
- **Color palette** — Navy/Gold/White is strong brand identity, keep it
- **BubblegumSans font** — great for a kids' game, keep it
- **Parallax backgrounds** — beautiful, keep them
- **Staff chaos animations** — fun, keep them
- **Quiz overlay design** — already premium, minor tweaks only
- **Floating score animations** — engaging, keep them

---

*Last Updated: February 24, 2026*
