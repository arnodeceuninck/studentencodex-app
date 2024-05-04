# codex

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Random notes
Main structure of this project is based on this article: https://medium.com/@ishanakilas8/flutter-searching-list-view-with-json-data-657b422aff6b

assets/search.json is generated from this jekyll repo: https://github.com/arnodeceuninck/studentencodex
Just run it, this generates code from the search.json file. Copy paste the output (_site/search.json) to assets/search.json

Build apk: flutter build apk --split-per-abi

### Building for play store
Be sure the keys are set up correctly

flutter build appbundle

More info: https://docs.flutter.dev/deployment/android

Note, last time I did the flutter build command, I got following warning: 
You are applying Flutter's app_plugin_loader Gradle plugin imperatively using the apply script method, which is deprecated and will be removed in a future release. Migrate to applying Gradle plugins with the declarative plugins block: https://flutter.dev/go/flutter-gradle-plugin-apply
