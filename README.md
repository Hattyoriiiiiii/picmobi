# picmobi app

- 免許返納後の高齢者等を対象に、移動が困難な者に向けた買い物をお助けするサービス。
- 利用者は商品を撮影するだけで、モビリティが商品を近所のハブに届けてくれる。
- 買い物をお助けし、コミュニティを大事するサービスを提供を目指す。

## Flutterの環境構築
### Set up the environment
1. [XCode](https://apps.apple.com/jp/app/xcode/id497799835?mt=12)のインストール
2. [Homebrew](https://brew.sh/index_ja)のインストール
3. `brew install flutter android-studio google-chrome`

### Installing Dependencies

To install the dependencies, run the following command in the root directory of the project:

```bash
flutter pub get
```

### Running the App

To run the app, run the following command in the root directory of the project:

```bash
# web app
flutter build web
```

## Firebase Settings

[Firebase CLIのインストール](https://firebase.google.com/docs/cli?hl=ja#setup_update_cli)

```
# for macOS
curl -sL https://firebase.tools | bash
```

```
# GoogleアカウントでFirebaseにログインする
firebase login

# FlutterFire CLIをインストール
dart pub global activate flutterfire_cli

# Firebase を使用するようにアプリを構成する (Flutterプロジェクトのルートディレクトリで実行する)
flutterfire configure --project=picmobi-59434
```


```
# ML モデル ダウンローダー プラグインをインストール
flutter pub add firebase_ml_model_downloader

# プロジェクトを再ビルドする
flutter run
```

## Google ML Kit

1. `cmd + shift + P`でFlutter projectの作成
2. Firebaseで`picmobi`を作成
3. `firebase login`
4. `flutterfire configure`でFlutter appとfirebaseとの連携ができる。
5. `firebase_core`をインストールするために、`flutter pub add firebase_core`を実行する。
6. `flutter pub add google_ml_kit`
7. 環境が変わったタイミングで`flutterfire configure`を実行


# Raspberry Pi Settings
## 環境構築

```
python3 -m venv venv
source venv/bin/activate
pip3 install --upgrade pip
pip3 install --upgrade firebase-admin
pip3 install gpsd-py3

# ラズパイにsshで接続
ssh 

# ラズパイにscpでファイルを転送
scp -r firebase-sdk.json user@raspberrypi.local:~/
```