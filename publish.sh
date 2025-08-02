#!/bin/bash

echo "🚀 Publishing multiselector to pub.dev..."

# Backup original pubspec.yaml
cp example/pubspec.yaml example/pubspec.yaml.backup

# Replace with publish version
cp example/pubspec.publish.yaml example/pubspec.yaml

# Publish
flutter pub publish

# Restore original pubspec.yaml
mv example/pubspec.yaml.backup example/pubspec.yaml

echo "✅ Published successfully!"
echo "📦 Package available at: https://pub.dev/packages/multiselector" 