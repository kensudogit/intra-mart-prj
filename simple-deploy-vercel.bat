@echo off
chcp 65001 >nul
echo ========================================
echo COOOLa Micro Vercel シンプルデプロイ
echo ========================================
echo.

REM フロントエンドのビルド
echo フロントエンドのビルドを開始...
cd frontend

echo npm install を実行中...
call npm install

echo Angular アプリケーションをビルド中...
call npm run build:intra-mart

echo ビルドが完了しました
cd ..
echo.

REM Vercelデプロイ
echo Vercelデプロイを開始...
vercel --prod

echo.
echo デプロイが完了しました！
pause
