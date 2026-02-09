#!/bin/sh
set -e

echo "Starting Web Build Preparation..."

# 1. Add dependencies required for Web
# We use 'dart pub add' to ensure they are added to pubspec.yaml correctly
echo "Adding Web dependencies..."
# supabase_flutter and audioplayers are the main ones we need
# We might need to specify versions if latest breaks something, but usually latest is fine for web
dart pub add supabase_flutter audioplayers

# 2. Inject Real Service Implementations
echo "Injecting Web Services..."
cp web_resources/lib/services/supabase_service.dart lib/services/
cp web_resources/lib/services/audio_service.dart lib/services/
cp web_resources/lib/services/crash_report_service.dart lib/services/

echo "Web Build Preparation Complete."
