# 株式会社ゆめみ iOS エンジニアコードチェック課題　　

## 課題完成度
- [ ]：未達成
- [/]：一部達成
- [x]：達成

### 初級
- [/]  可読性の向上
- [/]  安全性の向上
- [/]  バグの修正
- [x]  Fat VCの回避

### 中級
- [x]  構造のリファクタリング
- [/]  アーキテクチャの適用
- [ ]  テストの追加

### ボーナス
- [ ]  UIのブラッシュアップ
- [x]  機能の追加

## 良かった点
- 1画面1Storyboardな構成はコンフリクトも起こりづらく好感が持てます
- ViewControllerのコードを機能ごとにProtocolに分けて実装されていて読みやすいです
- (後述しましたがMVVMかどうか少し疑問符がありますが)ViewControllerからロジックをうまく分離できていると思います
- 画像が取得できなかった場合のプレースホルダー画像が用意されています。素晴らしい考慮！
- メソッドの分割の仕方、単位が良いです

## 改善点
- 検索結果がfetcherのコールバックと、dataSetsの2箇所で通知される点が気になりました。一般的なMVVMですと、ViewModelは入力と出力を分けてあることが多いかと思います (コールバックスタイルはあまり用いられないと思います)
- APIのレスポンスに 'items' というKeyがない場合、successもerrorも返らないようです。一方、Json変換は `try!` で失敗した場合は強制終了するようです。
クラッシュさせることは悪ではありません。ポリシーが統一されていると良いと思います。
- SearchViewModelのfetchResultが小文字から始まる型名になっています
- クロージャの中でselfを利用しているためメモリーリークのリスクがあります
- DetailViewControllerからWebViewControllerに遷移するとき、アニメーションは有効なままでよかったかも知れません
- ブラウザで開く機能を追加して頂きましたが、Webページの移動 (戻る操作) が出来ると嬉しいです！

## 質問内容
- スレッドの概念を理解できていないので、そこを学習する必要がある
ここ最近のiOS開発ですと(iOS以外も全般にかも知れません)、スレッドそのものはあまり意識しない方向に進んでいます。もちろん、スレッドの概念を理解した上で扱えるとベストですが、まずは非同期プログラミングに慣れる っというのも良いかも知れません。
今回ご提出いただいたコードは `DispatchQueue.main.async` を多用されていましたが、 `DispatchQueue.main.sync` とどう違うのか、ログを出しながら観察してみるなどが出発点としては良いように思います。

- ModelとviewModelのうまく切り分けることができていない
なぜアーキテクチャが必要なのか、それぞれのアーキテクチャはどのような考え方で実装するのか、などはやぱりこの本がオススメかと思います！
https://peaks.cc/books/iOS_architecture
ーーーーーーーーーーーーーーーーーーーー

（上記内容への追記）
## 改善点
- サーチバーの初期表示はplaceholderを使いましょう
https://developer.apple.com/documentation/uikit/uisearchbar/1624322-placeholder
- 日本語が検索できないようです、urlにする前にパーセントエンコードが必要です
https://developer.apple.com/documentation/foundation/nsstring/1411946-addingpercentencoding
- featchなどtypoがあります、Xcodeのスペルチェックを活用しましょう
- ダークモードにすると文字が見えなくなってしまいます、ダイナミックシステムカラー等を活用しましょう
- 長いリポジトリ名などで表示が崩れてしまいます、オートレイアウトで境界との制約をつけたり、UITableViewCellのCellStyleなど活用しましょう
https://developer.apple.com/documentation/uikit/uitableviewcell
- fetchResultなど定義してありますがResult型はSwiftに定義してあります
https://developer.apple.com/documentation/swift/result

## 質問内容
- githubのデフォルトブランチはどっちに設定しておくべきか
メインで開発を進めるブランチでよいと思います
mainで開発を進める場合は、main。developで開発を進める場合はdevelop
developで開発を進め、リリース時にdevelopからmainへマージする運用などがよく使われます

　　
## 頑張ったこと
- 今までアーキテクチャー(MVVM)を考えることができなかったが一週間という短い期間でも形にすることができた
- storyboard分割など共同開発もしやすいことを心がけることができた。
- 新しい機能をシンプルだがつけることができた
  
## 中山涼真の課題・テックリードの方へ聞きたいこと
- スレッドの概念を理解できていないので、そこを学習する必要がある
- ModelとviewModelのうまく切り分けることができていない  
(データの受け渡し方が正しいのかわからない) 
    ### 原因  
    - Modelへの理解が足りない
    - 何でアーキテクチャー勉強すればいいかわからないのでテックリードの方、ぜひご教授ください  (おすすめの記事もあったらそれも一緒にお願いします)
- githubのデフォルトブランチはどっちに設定しておくべきか
- completion handlerの違い、それぞれの違い
- デザイン(UI/UX)をもっと研究・勉強する必要がある
　　
## 追加機能
- 指定されたリポジトリをwebで開く機能

## 検証範囲
iphoneSE2  ~ iphone13Pro 

## 概要

本プロジェクトは株式会社ゆめみ（以下弊社）が、弊社に iOS エンジニアを希望する方に出す課題のベースプロジェクトです。本課題が与えられた方は、下記の概要を詳しく読んだ上で課題を取り組んでください。

## アプリ仕様

本アプリは GitHub のリポジトリーを検索するアプリです。

![動作イメージ](README_Images/app.gif)

### 環境

- IDE：基本最新の安定版（本概要更新時点では Xcode 13.0）
- Swift：基本最新の安定版（本概要更新時点では Swift 5.5）
- 開発ターゲット：基本最新の安定版（本概要更新時点では iOS 15.0）
- サードパーティーライブラリーの利用：オープンソースのものに限り制限しない

### 動作

1. 何かしらのキーワードを入力
2. GitHub API（`search/repositories`）でリポジトリーを検索し、結果一覧を概要（リポジトリ名）で表示
3. 特定の結果を選択したら、該当リポジトリの詳細（リポジトリ名、オーナーアイコン、プロジェクト言語、Star 数、Watcher 数、Fork 数、Issue 数）を表示

## 課題取り組み方法

Issues を確認した上、本プロジェクトを [**Duplicate** してください](https://help.github.com/en/github/creating-cloning-and-archiving-repositories/duplicating-a-repository)（Fork しないようにしてください。必要ならプライベートリポジトリーにしても大丈夫です）。今後のコミットは全てご自身のリポジトリーで行ってください。

コードチェックの課題 Issue は全て [`課題`](https://github.com/yumemi/ios-engineer-codecheck/milestone/1) Milestone がついており、難易度に応じて Label が [`初級`](https://github.com/yumemi/ios-engineer-codecheck/issues?q=is%3Aopen+is%3Aissue+label%3A初級+milestone%3A課題)、[`中級`](https://github.com/yumemi/ios-engineer-codecheck/issues?q=is%3Aopen+is%3Aissue+label%3A中級+milestone%3A課題+) と [`ボーナス`](https://github.com/yumemi/ios-engineer-codecheck/issues?q=is%3Aopen+is%3Aissue+label%3Aボーナス+milestone%3A課題+) に分けられています。課題の必須／選択は下記の表とします：

|   | 初級 | 中級 | ボーナス
|--:|:--:|:--:|:--:|
| 新卒／未経験者 | 必須 | 選択 | 選択 |
| 中途／経験者 | 必須 | 必須 | 選択 |


課題 Issueをご自身のリポジトリーにコピーするGitHub Actionsをご用意しております。  
[こちらのWorkflow](./.github/workflows/copy-issues.yml)を[手動でトリガーする](https://docs.github.com/ja/actions/managing-workflow-runs/manually-running-a-workflow)ことでコピーできますのでご活用下さい。

課題が完成したら、リポジトリーのアドレスを教えてください。

## 参考記事

提出された課題の評価ポイントに関しては、[こちらの記事](https://qiita.com/lovee/items/d76c68341ec3e7beb611)に詳しく書かれてありますので、ぜひご覧ください。
