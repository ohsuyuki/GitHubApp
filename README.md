# GitHubApp

https://user-images.githubusercontent.com/27656410/169704473-ad1bcac8-ff27-4058-bb01-95845416891e.mp4

### Personal Access Tokenの設定方法
本アプリでは [GitHub REST API](https://developer.github.com/v3/)を利用しています。 
このAPIにはRate Limitがあり、1時間に60回のリクエストまでに制限されています。ただし、Personal Accesss Tokenを用いると、Rate Limitの上限を上げることができます。
本アプリで Personal Access Token を使うには、 Environment Varialbe に ACCESS_TOKEN を設定してください。

<img width="936" alt="Screen Shot 2022-05-23 at 9 43 49" src="https://user-images.githubusercontent.com/27656410/169813789-128f4729-0c20-42cf-b72a-1d188c2bd2ca.png">

### プロジェクトの構成
- UserList
  - ユーザーの一覧画面

- RepoList
  - リポジトリ一覧画面

- WebView
  - WebView画面

- Model
  - モデル

- Environment
  - 各画面や機能で依存する（共通利用する）クラスやデータ。APIクライアントなど。

- Common
  - 各画面や機能で共通利用するExtensionや便利系のBaseクラスなど。
