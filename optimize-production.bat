@echo off
chcp 65001 >nul
echo ========================================
echo 本番環境最適化スクリプト
echo ========================================
echo.

echo 1. 依存関係の最適化...
cd frontend
call npm prune --production

echo.
echo 2. ビルドサイズの最適化...
call npm run build:intra-mart -- --configuration production --optimization

echo.
echo 3. ビルド結果の確認...
if exist "dist\cooola-micro-frontend" (
    echo ✓ ビルドディレクトリが存在します
    dir "dist\cooola-micro-frontend" /s
) else (
    echo ✗ ビルドディレクトリが見つかりません
)

echo.
echo 4. 本番環境への再デプロイ...
cd ..
vercel --prod

echo.
echo 最適化が完了しました！
pause
