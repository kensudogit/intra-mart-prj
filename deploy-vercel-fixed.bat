@echo off
chcp 65001 >nul
echo ========================================
echo COOOLa Micro Vercel 修正版デプロイ
echo ========================================
echo.

REM フロントエンドのビルド
echo フロントエンドのビルドを開始...
cd frontend

echo npm install を実行中...
call npm install --legacy-peer-deps
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

echo ビルドが完了しました
cd ..
echo.

REM Vercelデプロイ
echo Vercelデプロイを開始...
vercel --prod

echo.
echo デプロイが完了しました！
pause
