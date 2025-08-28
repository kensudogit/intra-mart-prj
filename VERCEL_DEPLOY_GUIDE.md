# Vercel デプロイガイド

## 概要

このガイドでは、COOOLa MicroシステムをVercelにデプロイする手順を説明します。

## 前提条件

### 1. 必要なツール
- **Node.js**: 18.0.0以上
- **npm**: 9.0.0以上
- **Vercel CLI**: 最新版
- **Git**: バージョン管理

### 2. Vercelアカウント
- [Vercel](https://vercel.com)でアカウントを作成
- GitHub、GitLab、Bitbucketとの連携設定

## セットアップ手順

### 1. Vercel CLIのインストール

```bash
# グローバルにインストール
npm install -g vercel

# バージョン確認
vercel --version
```

### 2. Vercelへのログイン

```bash
# ブラウザでログイン
vercel login

# または、トークンを使用
vercel login --token YOUR_VERCEL_TOKEN
```

### 3. 環境変数の設定

以下の環境変数を設定してください：

```bash
# Windows (CMD)
set VERCEL_TOKEN=your-vercel-token-here
set VERCEL_PROJECT_ID=your-project-id-here
set VERCEL_ORG_ID=your-org-id-here

# Windows (PowerShell)
$env:VERCEL_TOKEN="your-vercel-token-here"
$env:VERCEL_PROJECT_ID="your-project-id-here"
$env:VERCEL_ORG_ID="your-org-id-here"

# Linux/macOS
export VERCEL_TOKEN=your-vercel-token-here
export VERCEL_PROJECT_ID=your-project-id-here
export VERCEL_ORG_ID=your-org-id-here
```

### 4. プロジェクトのリンク

```bash
# プロジェクトディレクトリで実行
vercel link

# プロジェクトIDとオーガニゼーションIDを入力
# または、自動設定
vercel link --yes
```

## デプロイ手順

### 方法1: 自動化スクリプトを使用

#### Windows (バッチファイル)
```bash
deploy-vercel.bat
```

#### Windows (PowerShell)
```powershell
.\deploy-vercel.ps1
```

### 方法2: 手動デプロイ

#### 1. フロントエンドのビルド
```bash
cd frontend
npm install
npm run build:intra-mart
cd ..
```

#### 2. Vercelデプロイ
```bash
# プレビューデプロイ
vercel

# 本番環境へのデプロイ
vercel --prod
```

## 設定ファイルの説明

### vercel.json (ルート)
- プロジェクト全体の設定
- ビルド設定とルーティング
- 環境変数の設定

### frontend/vercel.json
- フロントエンド専用の設定
- 静的ファイルの配信設定
- SPAルーティングの設定

### .vercelignore
- デプロイ時に除外するファイル
- ビルド成果物、ログ、設定ファイル等

## デプロイ後の確認

### 1. デプロイ状況の確認
```bash
# デプロイ履歴
vercel ls

# プロジェクト詳細
vercel inspect

# ログの確認
vercel logs
```

### 2. 動作確認
- フロントエンドの表示確認
- APIエンドポイントの動作確認
- データベース接続の確認

### 3. ドメイン設定
```bash
# カスタムドメインの追加
vercel domains add your-domain.com

# SSL証明書の確認
vercel certs ls
```

## トラブルシューティング

### よくある問題

#### 1. ビルドエラー
**問題**: Angularビルドでエラーが発生
**解決方法**:
```bash
# 依存関係の再インストール
rm -rf node_modules package-lock.json
npm install

# キャッシュのクリア
npm cache clean --force
```

#### 2. デプロイエラー
**問題**: Vercelデプロイでエラーが発生
**解決方法**:
```bash
# プロジェクトの再リンク
vercel unlink
vercel link

# 環境変数の再設定
vercel env add VERCEL_TOKEN
```

#### 3. ルーティングエラー
**問題**: SPAルーティングが動作しない
**解決方法**:
- `vercel.json`のルーティング設定を確認
- フォールバックルートの設定確認

#### 4. 環境変数の問題
**問題**: 環境変数が読み込まれない
**解決方法**:
```bash
# 環境変数の確認
vercel env ls

# 環境変数の追加
vercel env add VARIABLE_NAME
```

## 本番環境の最適化

### 1. パフォーマンス最適化
- 画像の最適化
- コード分割の設定
- キャッシュ戦略の設定

### 2. セキュリティ設定
- HTTPSの強制
- セキュリティヘッダーの設定
- CORS設定の最適化

### 3. 監視・ログ
- エラー監視の設定
- パフォーマンス監視
- ログの集約

## CI/CD パイプライン

### GitHub Actions の例

```yaml
name: Deploy to Vercel
on:
  push:
    branches: [main]
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: '18'
      - run: npm ci
      - run: npm run build:intra-mart
      - uses: amondnet/vercel-action@v25
        with:
          vercel-token: ${{ secrets.VERCEL_TOKEN }}
          vercel-org-id: ${{ secrets.ORG_ID }}
          vercel-project-id: ${{ secrets.PROJECT_ID }}
          working-directory: ./frontend
```

## メンテナンス

### 1. 定期的な更新
- 依存関係の更新
- セキュリティパッチの適用
- パフォーマンス監視

### 2. バックアップ
- データベースのバックアップ
- 設定ファイルのバックアップ
- ログの保存

### 3. 監視
- アプリケーションの可用性
- パフォーマンスメトリクス
- エラー率の監視

## サポート

Vercelデプロイに関する問題がございましたら、以下の方法でサポートを受けられます：

- [Vercel Documentation](https://vercel.com/docs)
- [Vercel Community](https://github.com/vercel/vercel/discussions)
- 開発チームへの直接連絡

## 参考資料

- [Vercel CLI Documentation](https://vercel.com/docs/cli)
- [Angular Deployment Guide](https://angular.io/guide/deployment)
- [Spring Boot Deployment](https://spring.io/guides/gs/spring-boot/)
