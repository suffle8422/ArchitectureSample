# ArchitectureSample
iOSアプリをマルチモジュールで開発する際のアーキテクチャサンプル

## モジュールの種類
### App
全てのモジュールの存在を知ることのできるモジュール。
このモジュールからFeatureモジュールに対してDIすることで循環参照を防ぐ。

### Core
アプリ全体の共通知識を配置するモジュール。
あらゆるモジュールが参照することができる。
他のモジュールに依存しない。

### CoreUI
複数のFeatureモジュールで利用する共通UIを配置するモジュール。
Coreモジュール以外には依存しない。

### Repository
Repositoryを実装するモジュール。
Featureモジュールは自由に参照できる。

### Features
各画面の実装を行うモジュール。
Featureモジュール同士は依存することを禁止する。
画面遷移は、Appモジュールに実装されたRouterを利用して行う。

## このアーキテクチャの利点
### モジュール分割されており、不必要に外部に影響を与えない。
モジュール分がつされていることで、修正時の影響範囲がわかりやすい。
また、project側に配下のような最低限の実装しか配置しないことで、projectファイルのコンフリクトも起きづらい。
- `@main`のついたAppオブジェクト
- アプリアイコンのみを配置したAssets(その他の画像や色定義はCoreUIにAssetsを作って配置する)
- 各モジュールのテストをまとめたtestplanファイル

### Featureモジュールを互いに参照する必要がない
Featureモジュールを互いに参照し合うことなく、自由に画面遷移ができるため、循環参照が起きない。
そのため、Featureモジュールの親子関係を意識しながら開発する必要がない。

### actor境界がわかりやすい
Featureモジュールに定義されているSceneやSceneStateはMainActorにisolatedしている。
Repositoryはactor isolatedするので、境界がわかりやすい。

## このアーキテクチャの欠点
### routerの肥大化
routerでは画面の数だけswitch文で分岐するような構造になっているため、画面数が増えるに従って肥大化して見通しが悪くなる。
ただし、画面を全てenumでまとめているため、定義漏れなどは発生しない。
処理内容としてはsceneStateに必要なオブジェクトをDIした後に、sceneを作成して返しているだけなので複雑な処理はしていない。

## その他
### ローカルDBを管理するrepositoryとsceneStateとのバインディング
現状、sceneStateはrepositoryの関数を呼び出すことで最新の値を取得する仕組みになっている。
できれば、ローカルDBの内容とsceneStateの内容をうまくバインディングしてfetchを何度も行わずに済むようにしたい。

realmを利用する場合は、resultsをcombineのpublisherに変換することで任意のresultsに変化があれば通知される。
```
var publisher: AnyPublisher<Results<HogeModel>, any Error> {
    let results = realm.objects(HogeModel.self)
    return results.collectionPublisher.freeze().eraseToAnyPublisher()
}
```

SwiftDataを利用する場合、sceneState内で@queryが利用できない。
また、combineを利用して更新通知を受け取ることは2024-12-01現在ではできない。
手動でfetchするか、notificationCenterからdidSave通知を受け取ってから更新する必要がある。
