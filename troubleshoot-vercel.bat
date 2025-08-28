@echo off
chcp 65001 >nul
echo ========================================
echo Vercel デプロイ トラブルシューティング
echo ========================================
echo.

echo 1. Vercel CLIの状態確認...
echo.
vercel --version
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Vercel CLIがインストールされていません
    echo インストール中...
    npm install -g vercel
) else (
    echo [OK] Vercel CLIが利用可能です
)
echo.

echo 2. ログイン状態の確認...
echo.
vercel whoami
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Vercelにログインしていません
    echo ログインしてください...
    vercel login
) else (
    echo [OK] Vercelにログイン済みです
)
echo.

echo 3. プロジェクトのリンク状態確認...
echo.
vercel project ls
echo.

echo 4. 環境変数の確認...
echo.
echo VERCEL_TOKEN: %VERCEL_TOKEN%
echo VERCEL_PROJECT_ID: %VERCEL_PROJECT_ID%
echo VERCEL_ORG_ID: %VERCEL_ORG_ID%
echo.

echo 5. Node.jsとnpmの確認...
echo.
node --version
npm --version
echo.

echo 6. フロントエンドディレクトリの確認...
echo.
if exist "frontend" (
    echo [OK] frontendディレクトリが存在します
    if exist "frontend\package.json" (
        echo [OK] package.jsonが存在します
    ) else (
        echo [ERROR] package.jsonが見つかりません
    )
) else (
    echo [ERROR] frontendディレクトリが存在しません
)
echo.

echo 7. トラブルシューティング完了
echo.
echo 問題がある場合は、上記の出力を確認してください
echo.
pause
