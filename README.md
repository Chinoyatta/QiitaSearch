# QiitaSearch
## 概要  
QiitaApiから特定の投稿者の記事を取得し、TableView上に表示します。  
また、セルををタップするとその記事をwebview上で閲覧することができます。

環境:Xcode12.0.1  
動作確認iOS: iOS14.0  
言語: Swift5  
ライブラリ: Alamofire, SwiftyJSON, RxSwift

## 使い方
当リポジトリはCarthageを使用してライブラリの導入を行っていますが、  
ライブラリ本体が入ったフォルダはアップロードしていません。(リポジトリを小さく保ちたいため)  

よって、git cloneした後に手動でターミナルからコマンドを叩く必要があります。  

### Carthage導入手順  
ターミナルで、cloneを行ったディレクトリに移動した後
```
% carthage update --platform iOS --no-use-binaries --cache-builds
```  
を実行してください。  
ただし、Xcode12以上だとTask failed with exit code 1:  
となる場合があります。(2020/10/19時点でXcode12以上でCarthageをアップデートしようとするとfaileすることがある模様)  

そうなった場合、cloneしたファイルにxcconfigがありますので
```
% export XCODE_XCCONFIG_FILE=(xcconfigのパス）
```  
を入力してから再度updateコマンドを叩いて見てください。  
参考:[Xcode12でcarthageのFrameworkを更新しようとするとTask failed with exit code 1:になる時の対処法(Qiita)](https://qiita.com/pinoerumo/items/0a340078ea2e0f8d01b0)  

### アプリを動かす際に

ArticleListViewcontroller内のuser変数を検索したい投稿者IDに設定しビルドを行うと、  
アプリ起動時に設定した投稿者がQiitaに投稿した記事が表示されます。

### 注意
MVVMアーキ適用を想定したファイル群が存在するが、[コード不具合](https://github.com/Chinoyatta/QiitaSearch/issues/2)により動かないので、  
現在動くアプリにアーキテクチャの適用は行っていません。
