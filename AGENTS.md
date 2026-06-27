# AGENTS.md

このファイルは、AIコーディングエージェント（Claude Code など）がこのリポジトリで作業する際のガイドラインです。

## プロジェクト概要

`flutter_test_app` は Flutter で構築されたクロスプラットフォームアプリケーションです。
Android / iOS / Web / Linux / macOS / Windows をターゲットとしています。

- 言語: Dart
- フレームワーク: Flutter (SDK `^3.9.2`)
- エントリーポイント: `lib/main.dart`

## ディレクトリ構成

| パス | 役割 |
| --- | --- |
| `lib/` | アプリケーションの Dart ソースコード |
| `test/` | ウィジェット／ユニットテスト |
| `android/`, `ios/`, `web/`, `linux/`, `macos/`, `windows/` | 各プラットフォーム固有のネイティブ設定 |
| `pubspec.yaml` | 依存関係とアセットの定義 |
| `analysis_options.yaml` | 静的解析（lint）ルール |

## セットアップ

```bash
flutter pub get
```

## よく使うコマンド

```bash
# 依存関係の取得
flutter pub get

# アプリの実行（接続中のデバイス／エミュレータ）
flutter run

# テストの実行
flutter test

# 静的解析（lint）
flutter analyze

# コードフォーマット
dart format .

# ビルド（例: Web）
flutter build web
```

## コーディング規約

- `analysis_options.yaml` で有効化された `flutter_lints` のルールに従うこと。
- コミット前に `dart format .` を実行してフォーマットを統一すること。
- `flutter analyze` で警告・エラーが出ない状態を保つこと。
- ウィジェットは可能な限り `const` コンストラクタを使用すること。
- 命名は Dart の慣例に従う（クラス: `UpperCamelCase`、変数・メソッド: `lowerCamelCase`、ファイル: `snake_case`）。

## テスト

- テストは `test/` 配下に配置する。
- 変更を加えたら `flutter test` を実行し、すべてパスすることを確認すること。
- UI の挙動を変更した場合は対応するウィジェットテストを追加・更新すること。

## エージェントへの指示

1. 変更後は必ず `flutter analyze` と `flutter test` を実行して問題がないことを確認する。
2. コードのフォーマットには `dart format .` を使用する。
3. 既存のコードスタイルと構成に合わせる。
4. ネイティブ設定（`android/`, `ios/` など）は必要な場合のみ変更する。
5. コミットメッセージは変更内容が明確に伝わるように記述する。
