# COOOLa Micro Vercel デプロイスクリプト
# UTF-8 エンコーディングで保存
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "COOOLa Micro Vercel デプロイスクリプト" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 環境変数の確認
Write-Host "環境変数を確認中..." -ForegroundColor Yellow
$vercelToken = $env:VERCEL_TOKEN
$vercelProjectId = $env:VERCEL_PROJECT_ID

if (-not $vercelToken) {
    Write-Host "警告: VERCEL_TOKENが設定されていません" -ForegroundColor Yellow
    Write-Host "Vercel CLIにログインしてください" -ForegroundColor Cyan
    Write-Host "vercel login" -ForegroundColor White
    Read-Host "Enterキーを押して終了"
    exit 1
}

if (-not $vercelProjectId) {
    Write-Host "警告: VERCEL_PROJECT_IDが設定されていません" -ForegroundColor Yellow
    Write-Host "プロジェクトIDを設定してください" -ForegroundColor Cyan
    Read-Host "Enterキーを押して終了"
    exit 1
}

Write-Host "Vercel環境変数が設定されています" -ForegroundColor Green
Write-Host ""

# フロントエンドのビルド
Write-Host "フロントエンドのビルドを開始..." -ForegroundColor Yellow
Set-Location frontend

Write-Host "npm install を実行中..." -ForegroundColor Gray
try {
    npm install
    if ($LASTEXITCODE -ne 0) {
        throw "npm install でエラーが発生しました"
    }
} catch {
    Write-Host "npm install でエラーが発生しました: $_" -ForegroundColor Red
    Read-Host "Enterキーを押して終了"
    exit 1
}

Write-Host "Angular アプリケーションをビルド中..." -ForegroundColor Gray
try {
    npm run build:intra-mart
    if ($LASTEXITCODE -ne 0) {
        throw "ビルドでエラーが発生しました"
    }
} catch {
    Write-Host "ビルドでエラーが発生しました: $_" -ForegroundColor Red
    Read-Host "Enterキーを押して終了"
    exit 1
}

Write-Host "フロントエンドのビルドが完了しました" -ForegroundColor Green
Write-Host ""

# プロジェクトルートに戻る
Set-Location ..

# Vercelデプロイの実行
Write-Host "Vercelデプロイを開始..." -ForegroundColor Yellow
Write-Host ""

Write-Host "1. プロジェクトの設定確認..." -ForegroundColor Cyan
try {
    $vercelVersion = vercel --version 2>&1
    Write-Host "Vercel CLI バージョン: $vercelVersion" -ForegroundColor Gray
} catch {
    Write-Host "Vercel CLIがインストールされていません" -ForegroundColor Red
    Write-Host "npm install -g vercel を実行してください" -ForegroundColor Cyan
    Read-Host "Enterキーを押して終了"
    exit 1
}

Write-Host ""
Write-Host "2. プロジェクトのリンク確認..." -ForegroundColor Cyan
try {
    vercel link --yes
    if ($LASTEXITCODE -ne 0) {
        throw "プロジェクトのリンクに失敗しました"
    }
} catch {
    Write-Host "プロジェクトのリンクに失敗しました: $_" -ForegroundColor Red
    Read-Host "Enterキーを押して終了"
    exit 1
}

Write-Host ""
Write-Host "3. 本番環境へのデプロイ..." -ForegroundColor Cyan
try {
    vercel --prod --yes
    if ($LASTEXITCODE -ne 0) {
        throw "デプロイに失敗しました"
    }
} catch {
    Write-Host "デプロイに失敗しました: $_" -ForegroundColor Red
    Read-Host "Enterキーを押して終了"
    exit 1
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "デプロイが完了しました！" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "次のコマンドでデプロイ状況を確認できます：" -ForegroundColor Cyan
Write-Host "vercel ls" -ForegroundColor White
Write-Host ""

Write-Host "プロジェクトの詳細を確認するには：" -ForegroundColor Cyan
Write-Host "vercel inspect" -ForegroundColor White
Write-Host ""

Read-Host "Enterキーを押して終了"
