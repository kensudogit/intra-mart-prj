@echo off
chcp 65001 >nul
echo ========================================
echo Vercel リージョン確認スクリプト
echo ========================================
echo.

echo Vercel CLI のバージョンを確認中...
vercel --version

echo.
echo 利用可能なリージョン:
echo - hnd1: 東京 (日本)
echo - syd1: シドニー (オーストラリア)
echo - sin1: シンガポール
echo - iad1: ワシントンDC (アメリカ)
echo - sfo1: サンフランシスコ (アメリカ)
echo - lhr1: ロンドン (イギリス)
echo - fra1: フランクフルト (ドイツ)
echo - cdg1: パリ (フランス)

echo.
echo 現在のプロジェクト設定を確認中...
if exist "vercel.json" (
    echo ✓ vercel.json が存在します
    echo 設定内容:
    type vercel.json
) else (
    echo ✗ vercel.json が見つかりません
)

echo.
echo フロントエンドの設定も確認中...
if exist "frontend\vercel.json" (
    echo ✓ frontend\vercel.json が存在します
    echo 設定内容:
    type frontend\vercel.json
) else (
    echo ✗ frontend\vercel.json が見つかりません
)

echo.
echo 確認が完了しました。
pause
