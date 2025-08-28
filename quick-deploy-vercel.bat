@echo off
chcp 65001 >nul
echo ========================================
echo COOOLa Micro Vercel クイックデプロイ
echo ========================================
echo.

REM Vercel CLIの確認
echo Vercel CLIの確認中...
vercel --version >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Vercel CLIがインストールされていません
    echo インストール中...
    npm install -g vercel
    if %ERRORLEVEL% neq 0 (
        echo Vercel CLIのインストールに失敗しました
        pause
        exit /b 1
    )
)

echo Vercel CLIが利用可能です
echo.

REM ログイン確認
echo Vercelへのログインを確認中...
vercel whoami >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Vercelにログインしていません
    echo ログインしてください...
    vercel login
    if %ERRORLEVEL% neq 0 (
        echo ログインに失敗しました
        pause
        exit /b 1
    )
)

echo Vercelにログイン済みです
echo.

REM フロントエンドのビルド
echo フロントエンドのビルドを開始...
cd frontend

echo 依存関係のインストール中...
call npm install
if %ERRORLEVEL% neq 0 (
    echo 依存関係のインストールに失敗しました
    pause
    exit /b 1
)

echo Angularアプリケーションをビルド中...
call npm run build:intra-mart
if %ERRORLEVEL% neq 0 (
    echo ビルドに失敗しました
    pause
    exit /b 1
)

echo ビルドが完了しました
cd ..
echo.

REM Vercelデプロイ
echo Vercelデプロイを開始...
echo.

echo プロジェクトのリンク確認中...
vercel link --yes
if %ERRORLEVEL% neq 0 (
    echo プロジェクトのリンクに失敗しました
    pause
    exit /b 1
)

echo.
echo 本番環境へのデプロイ中...
vercel --prod --yes
if %ERRORLEVEL% neq 0 (
    echo デプロイに失敗しました
    pause
    exit /b 1
)

echo.
echo ========================================
echo デプロイが完了しました！
echo ========================================
echo.
echo デプロイ状況の確認:
echo vercel ls
echo.
echo プロジェクト詳細:
echo vercel inspect
echo.
pause
