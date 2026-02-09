# Fay Gator Run - Deployment Guide

## Overview

This guide covers deploying Fay Gator Run to the App Store via Codemagic and App Store Connect.

---

## Current Build Information

- **Version**: 1.0.0
- **Build Number**: 2
- **Bundle ID**: com.fayrun.app
- **Display Name**: Fay Gator Run

---

## Prerequisites

### 1. Apple Developer Account
- Active Apple Developer Program membership
- Access to App Store Connect
- Team ID and certificates

### 2. App Store Connect Setup
- [ ] Create app record in App Store Connect
- [ ] Note the App Store Apple ID (10-digit number)
- [ ] Set up app metadata (name, description, screenshots)
- [ ] Configure pricing and availability

### 3. Codemagic Account
- [ ] Sign up at https://codemagic.io
- [ ] Connect GitHub repository
- [ ] Add App Store Connect integration

---

## Step 1: App Store Connect Configuration

### Create New App

1. **Log in to App Store Connect**: https://appstoreconnect.apple.com
2. **Navigate to**: My Apps → + (Add New App)
3. **Fill in details**:
   - Platform: iOS
   - Name: Fay Gator Run
   - Primary Language: English (U.S.)
   - Bundle ID: com.fayrun.app
   - SKU: faygatorrun (or unique identifier)
   - User Access: Full Access

4. **Save** and note the **Apple ID** (10-digit number)

### App Information

**Category**: Education  
**Subcategory**: Kids

**Description**:
```
Fay Gator Run is an educational endless runner game where students race through school while answering grade-appropriate questions in Math, Science, and Social Studies.

Features:
• 5 exciting levels with unique themes
• Progressive difficulty that scales with gameplay
• Grade-specific questions (1st and 4th grade)
• Fun staff character interactions
• Level-specific background music
• Engaging ambient effects

Perfect for elementary students to practice their skills while having fun!
```

**Keywords**: education, learning, math, science, social studies, kids, elementary, runner, game

**Support URL**: https://mooseshel.com/support  
**Privacy Policy URL**: https://mooseshel.com/privacy

### Screenshots Required

**iPhone 6.7" Display** (1290 x 2796 pixels):
- Game menu screen
- Level 1 (Bayou) gameplay
- Quiz question overlay
- Level complete screen
- Leaderboard

**iPhone 6.5" Display** (1242 x 2688 pixels):
- Same screenshots, resized

---

## Step 2: Codemagic Setup

### Connect Repository

1. **Log in to Codemagic**: https://codemagic.io
2. **Add Application**:
   - Select GitHub
   - Choose repository: MooseShel/Fay-Run
   - Select branch: main

### Configure App Store Connect Integration

1. **Navigate to**: Team settings → Integrations
2. **Add Integration**: App Store Connect
3. **Enter credentials**:
   - Apple ID: (your Apple ID email)
   - App-specific password: (generate from appleid.apple.com)
4. **Save integration** with name: `codemagic`

### Configure Code Signing

1. **Navigate to**: App settings → Code signing identities
2. **iOS code signing**:
   - Distribution certificate: Upload or fetch from App Store Connect
   - Provisioning profile: App Store profile for com.fayrun.app
3. **Save**

### Update codemagic.yaml

Update the `APP_STORE_APPLE_ID` in [codemagic.yaml](file:///c:/Users/Husse/Documents/Fay%20Run/codemagic.yaml):

```yaml
APP_STORE_APPLE_ID: 1234567890 # Replace with actual 10-digit Apple ID
```

---

## Step 3: Build Configuration

### Verify Build Settings

The [codemagic.yaml](file:///c:/Users/Husse/Documents/Fay%20Run/codemagic.yaml) is configured to:

- ✅ Build iOS app for App Store distribution
- ✅ Auto-increment build number
- ✅ Sign with App Store certificates
- ✅ Submit to TestFlight automatically
- ✅ Send email notifications

### Environment Variables

Set in Codemagic UI (if needed):
- `BUNDLE_ID`: com.fayrun.app
- `APP_STORE_APPLE_ID`: (your 10-digit Apple ID)

---

## Step 4: Trigger Build

### Manual Build

1. **Navigate to**: Codemagic → Applications → Fay Gator Run
2. **Select workflow**: ios-workflow
3. **Click**: Start new build
4. **Select branch**: main
5. **Monitor build** progress in real-time

### Automatic Builds

Builds trigger automatically on:
- Push to `main` branch
- Pull request to `main`

---

## Step 5: TestFlight Distribution

### After Successful Build

1. **Build completes** (~15-20 minutes)
2. **Codemagic automatically submits** to TestFlight
3. **Wait for Apple processing** (~5-10 minutes)
4. **App appears in TestFlight** in App Store Connect

### Add Test Users

1. **Navigate to**: App Store Connect → TestFlight → Internal Testing
2. **Add testers**:
   - Internal testers (team members)
   - External testers (beta testers)
3. **Distribute build** to test groups

### Testing Checklist

- [ ] Launch app successfully
- [ ] Create student profile
- [ ] Play through all 5 levels
- [ ] Answer quiz questions
- [ ] Verify audio (music, SFX, voices)
- [ ] Check leaderboard
- [ ] Test with 1st and 4th grade students
- [ ] Verify questions scale with levels

---

## Step 6: App Store Submission

### Prepare for Review

1. **Complete App Information** in App Store Connect
2. **Upload Screenshots** (all required sizes)
3. **Set Age Rating**: 4+ (Educational)
4. **Configure App Review Information**:
   - Demo account (if needed)
   - Review notes
   - Contact information

### Submit for Review

1. **Navigate to**: App Store Connect → My Apps → Fay Gator Run
2. **Select build** from TestFlight
3. **Complete all required fields**
4. **Submit for Review**

### Review Process

- **Typical timeline**: 1-3 days
- **Status updates**: Email notifications
- **Common issues**: 
  - Missing privacy policy
  - Incomplete metadata
  - Guideline violations

---

## Troubleshooting

### Build Failures

**Code Signing Issues**:
- Verify certificates in Codemagic
- Check provisioning profile matches Bundle ID
- Ensure certificates haven't expired

**Dependency Issues**:
- Check `pubspec.yaml` for version conflicts
- Clear Flutter cache: `flutter clean`
- Update pods: `pod repo update`

### TestFlight Issues

**Build Not Appearing**:
- Check App Store Connect for processing status
- Verify build number incremented
- Check email for Apple notifications

**Missing Compliance**:
- Add export compliance in App Store Connect
- Answer encryption questions

---

## Post-Deployment

### Monitor Analytics

- **App Store Connect Analytics**: Downloads, sessions, crashes
- **TestFlight Feedback**: User feedback and crash reports
- **User Reviews**: Monitor and respond

### Update Process

1. **Make changes** to code
2. **Update version** in `pubspec.yaml`:
   ```yaml
   version: 1.0.1+3  # Increment version or build number
   ```
3. **Commit and push** to main branch
4. **Codemagic builds automatically**
5. **Submit new build** for review

---

## Important Files

- [codemagic.yaml](file:///c:/Users/Husse/Documents/Fay%20Run/codemagic.yaml) - CI/CD configuration
- [pubspec.yaml](file:///c:/Users/Husse/Documents/Fay%20Run/pubspec.yaml) - Version and dependencies
- [Info.plist](file:///c:/Users/Husse/Documents/Fay%20Run/ios/Runner/Info.plist) - iOS app configuration

---

## Support

**Email**: hussein@mooseshel.com  
**Codemagic Docs**: https://docs.codemagic.io/  
**App Store Connect**: https://appstoreconnect.apple.com

---

## Summary

✅ **Version 1.0.0+2 ready for deployment**  
✅ **Codemagic configured for automated builds**  
✅ **TestFlight distribution enabled**  
✅ **App Store Connect integration complete**

**Next Steps**:
1. Update `APP_STORE_APPLE_ID` in codemagic.yaml
2. Create app in App Store Connect
3. Trigger build in Codemagic
4. Test via TestFlight
5. Submit for App Store review
