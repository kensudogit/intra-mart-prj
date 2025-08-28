@echo off
chcp 65001 >nul
echo ========================================
echo COOOLa Micro Vercel デプロイスクリプト
echo ========================================
echo.

REM 環境変数の確認
echo 環境変数を確認中...
if "%VERCEL_TOKEN%"=="" (
    echo 警告: VERCEL_TOKENが設定されていません
    echo Vercel CLIにログインしてください
    echo vercel login
    pause
    exit /b 1
)

if "%VERCEL_PROJECT_ID%"=="" (
    echo 警告: VERCEL_PROJECT_IDが設定されていません
    echo プロジェクトIDを設定してください
    pause
    exit /b 1
)

echo Vercel環境変数が設定されています
echo.

REM フロントエンドのビルド
echo フロントエンドのビルドを開始...
cd frontend

echo npm install を実行中...
call npm install
if %ERRORLEVEL% neq 0 (
    echo npm install でエラーが発生しました
    pause
    exit /b 1
)

echo Angular アプリケーションをビルド中...
call npm run build:intra-mart
if %ERRORLEVEL% neq 0 (
    echo ビルドでエラーが発生しました
    pause
    exit /b 1
)

echo フロントエンドのビルドが完了しました
echo.

REM プロジェクトルートに戻る
cd ..

REM Vercelデプロイの実行
echo Vercelデプロイを開始...
echo.

echo 1. プロジェクトの設定確認...
vercel --version
if %ERRORLEVEL% neq 0 (
    echo Vercel CLIがインストールされていません
    echo npm install -g vercel を実行してください
    pause
    exit /b 1
)

echo.
echo 2. プロジェクトのリンク確認...
vercel link --yes
if %ERRORLEVEL% neq 0 (
    echo プロジェクトのリンクに失敗しました
    pause
    exit /b 1
)

echo.
echo 3. 本番環境へのデプロイ...
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
echo 次のコマンドでデプロイ状況を確認できます：
echo vercel ls
echo.
echo プロジェクトの詳細を確認するには：
echo vercel inspect
echo.
pause
