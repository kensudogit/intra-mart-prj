# COOOLa Micro - INTRA-MART統合版

## 概要

COOOLa Microは、INTRA-MART環境で動作するマイクロカーネル型倉庫管理システムです。元のCOOOLa Microシステムの機能をINTRA-MART環境に統合し、プラグインアーキテクチャとマイクロサービス設計を採用しています。

## 移植された機能

### 1. プラグインシステム
- **商品管理プラグイン**: 商品のCRUD操作、バーコード管理
- **在庫管理プラグイン**: 在庫追跡、アラート、自動発注
- **レポートプラグイン**: CSV、Excel、PDF形式でのレポート生成
- **入出庫プラグイン**: 入出庫処理、履歴管理
- **バーコードプラグイン**: バーコード・QRコード生成・読み取り

### 2. マイクロサービス
- **商品サービス**: 商品情報管理
- **在庫サービス**: 在庫状態管理
- **入出庫サービス**: 入出庫処理
- **レポートサービス**: レポート生成（CSV/印刷対応）
- **通知サービス**: アラート・通知

### 3. フロントエンド（Angular 17）
- モダンなWeb UI
- レスポンシブデザイン
- リアルタイム更新
- 多言語対応

## アーキテクチャ

### プラグインアーキテクチャ
```
INTRA-MART Core
    ↓
COOOLa Micro Core API
    ↓
Plugin Manager
    ↓
[Product Plugin] [Inventory Plugin] [Report Plugin] ...
```

### マイクロサービス構成
```
API Gateway (INTRA-MART)
    ↓
Service Discovery (Eureka)
    ↓
[Product Service] [Inventory Service] [Report Service] ...
```

## 技術スタック

### バックエンド
- **INTRA-MART**: 2023.1
- **Spring Boot**: 2.7.18
- **Spring Cloud**: 2021.0.8
- **Java**: 11
- **Gradle**: 7.6

### フロントエンド
- **Angular**: 17.0.0
- **TypeScript**: 5.2.0
- **Bootstrap**: 5.3.0
- **RxJS**: 7.8.0

### データベース
- **PostgreSQL**: 13
- **MySQL**: 8.0
- **Redis**: キャッシュ・セッション

### 監視・ログ
- **Spring Boot Actuator**: ヘルスチェック
- **Logback**: ログ管理
- **Prometheus**: メトリクス収集

## セットアップ手順

### 1. 前提条件
```bash
# Java 11以上
java -version

# Gradle 7.6以上
gradle -version

# Node.js 18以上
node -v
npm -v
```

### 2. プロジェクトのビルド
```bash
# 全モジュールのビルド
gradlew.bat build

# 特定のモジュールのビルド
gradlew.bat :core:core-api:build
gradlew.bat :plugins:product-plugin:build
```

### 3. アプリケーションの起動
```bash
# 開発サーバーの起動
gradlew.bat appRun

# フロントエンドの起動
cd frontend
npm install
npm start
```

### 4. データベースの準備
```bash
# PostgreSQLの起動
docker-compose up -d postgres

# データベースの初期化
docker-compose exec postgres psql -U postgres -d intramart_dev -f /docker-entrypoint-initdb.d/01-init.sql
```

## 使用方法

### プラグインの管理
```java
// プラグインの登録
PluginRegistry registry = context.getPluginRegistry();
registry.registerPlugin(productPlugin);

// プラグインの開始
registry.startPlugin("product-management");

// プラグインの状態確認
PluginStatus status = productPlugin.getStatus();
```

### レポート生成
```java
// CSVエクスポート
ReportService reportService = new ReportService();
byte[] csvData = reportService.generateCSV(reportData);

// PDF生成
byte[] pdfData = reportService.generatePDF(reportData);

// Excel生成
byte[] excelData = reportService.generateExcel(reportData);
```

### フロントエンドでの使用
```typescript
// 商品データの取得
this.productService.getProducts().subscribe(products => {
    this.products = products;
});

// CSVエクスポート
this.exportService.exportToCSV(this.products, 'products.csv');

// PDF出力
this.exportService.exportToPDF(this.products, 'products.pdf');
```

## 開発ガイドライン

### 1. プラグイン開発
- `CooolaPlugin`インターフェースを実装
- 適切なライフサイクル管理
- エラーハンドリングの実装
- ログ出力の充実

### 2. サービス開発
- Spring Bootのベストプラクティスに従う
- 適切な例外処理
- ユニットテストの作成
- APIドキュメントの整備

### 3. フロントエンド開発
- Angularのコーディング規約に従う
- コンポーネントの再利用性
- 型安全性の確保
- レスポンシブデザイン

## 設定

### プラグイン設定
```yaml
# application.yml
cooola:
  plugins:
    product:
      maxProducts: 10000
      enableBarcode: true
      enableImageUpload: true
    inventory:
      lowStockThreshold: 10
      enableStockAlerts: true
      autoReorderEnabled: false
    report:
      enableCSVExport: true
      enableExcelExport: true
      enablePDFExport: true
      defaultEncoding: UTF-8
```

### データベース設定
```yaml
spring:
  datasource:
    url: jdbc:postgresql://localhost:5432/intramart_dev
    username: postgres
    password: postgres
  jpa:
    hibernate:
      ddl-auto: update
    show-sql: true
```

## トラブルシューティング

### よくある問題

#### 1. プラグイン読み込みエラー
- 依存関係の確認
- クラスパスの確認
- ログの詳細確認

#### 2. データベース接続エラー
- 接続設定の確認
- データベースの起動確認
- ネットワーク設定の確認

#### 3. フロントエンドビルドエラー
- Node.jsバージョンの確認
- 依存関係の再インストール
- キャッシュのクリア

## 今後の拡張予定

### 短期目標
- [ ] ワークフロー機能の追加
- [ ] モバイル対応の強化
- [ ] 多言語対応の拡充

### 長期目標
- [ ] AI/ML機能の統合
- [ ] IoTデバイスとの連携
- [ ] クラウドネイティブ化

## ライセンス

MIT License

## 貢献

プルリクエストやイシューの報告を歓迎します。開発に参加したい場合は、以下の手順でお願いします：

1. リポジトリをフォーク
2. 機能ブランチを作成
3. 変更をコミット
4. プルリクエストを作成

## サポート

技術的な質問や問題がございましたら、以下の方法でお問い合わせください：

- GitHub Issues
- 開発チームへの直接連絡
- ドキュメントの確認
