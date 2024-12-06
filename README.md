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

### プレビュー速度が長くなりづらい
Featureモジュールは1画面ごとにモジュール分割されている。
各モジュールは独立してビルドできるようにすることで、最小限の依存のみでビルドできる。
これによって、SwiftUIのPreviewの起動時間を短縮できる。

## このアーキテクチャの欠点
### routerの肥大化
routerでは画面の数だけswitch文で分岐するような構造になっているため、画面数が増えるに従って肥大化して見通しが悪くなる。
ただし、画面を全てenumでまとめているため、定義漏れなどは発生しない。
処理内容としてはsceneStateに必要なオブジェクトをDIした後に、sceneを作成して返しているだけなので複雑な処理はしていない。

## その他
### iOS版クックパッドアプリが採用しているアーキテクチャとの違い
このアーキテクチャはiOS版クックパッドで採用されているアーキテクチャを参考に作成しています。
詳しくは[こちらの記事](https://techlife.cookpad.com/entry/2021/06/16/110000)をご参照ください
このアーキテクチャを参考にするにあたって解決したかった点が2点ありました
- AppEnvironment.resolveの実装忘れがクラッシュにつながってしまう
- AppEnvironmentoを各FeatureにDIしている
それぞれ説明します。

#### AppEnvironment.resolveの実装忘れがクラッシュにつながってしまう
クックパッドのアーキテクチャでは、`AppEnvironment.resolve`を利用して具体実装を取り出しています。
このとき、resolveに対応するViewDescriptorの処理を書き忘れるとクラッシュしてしまいます。
クックパッドではこの問題点をSourceryデコードを自動生成することで解決していました
ただ、個人開発ではリソースも限られているので言語の仕組みで解決したいです。
そこで、`AppScene`というenumを使って遷移できる画面を網羅しました。
このようにすることで、具体実装を取り出す`Router.show`ではAppSceneを全て網羅しないとコンパイルエラーとなるようにしました。

#### AppEnvironmentoを各FeatureにDIしている
SwiftUIで実装するにあたってはAppEnvironmentを直接FeatureにDIしたくありませんでした。
理由としては、アプリ全体で必要な依存全てを、個別のFeatureにDIする必要は本来ないはずです。
マルチモジュール構成では、モジュール単位の依存は明確になりますが、それ以上詳しい依存関係は担保できません。
DIコンテナをDIすることで、例えば全てのFeatureから全てのRepositoryにアクセスできる状態になってしまい、安全とは言えません
SampleArchitectureでは、愚直なやり方ですがイニシャライザインジェクションで必要な依存のみを注入しています。

### Repository/sceneState間のデータの受け渡し
`actor isolated`したrepositoryと、`MainActor isolated`したSceneState間でデータを受け渡す際、actor境界をまたぐことになる。
受け渡す型をSendableにする、値の取得を行う関数をnonisolatedにするなどの対策が必要。

このサンプルでは、SwiftDataで値を保存しているが、modelクラスはスレッドセーフではないのでSendableにできない。
Repository側で、SendableなDTOオブジェクトに変換してから渡したり、値を取得する関数だけnonisolatedにしたりする必要がある。
このサンプルでは、SendableなDTOを用意して、SwiftDataのModelはRepositoryモジュール内に閉じ込めている。

### Realmを利用した場合のRepository/SceneState間のデータの受け渡し
realmを利用する場合は、results型をcombineのpublisherに変換することで任意のクエリの結果に変化があれば通知される。
```
var publisher: AnyPublisher<Results<HogeModel>, any Error> {
    let results = realm.objects(HogeModel.self)
    return results.collectionPublisher.freeze().eraseToAnyPublisher()
}
```

SwiftDataを利用する場合、sceneState内で`@query`が利用できない。
また、combineを利用して更新通知を受け取ることは2024-12-01現在ではできない。
手動でfetchするか、notificationCenterからdidSave通知を受け取ってから更新する必要がある。
