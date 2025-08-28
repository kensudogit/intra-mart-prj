@echo off
chcp 65001 >nul
echo ========================================
echo Angular プロジェクト診断スクリプト
echo ========================================
echo.

echo 現在のディレクトリ: %CD%
echo.

echo 1. フロントエンドディレクトリの確認...
if exist "frontend" (
    echo ✓ frontend ディレクトリが存在します
    cd frontend
    echo   現在のディレクトリ: %CD%
) else (
    echo ✗ frontend ディレクトリが見つかりません
    pause
    exit /b 1
)

echo.
echo 2. package.json の確認...
if exist "package.json" (
    echo ✓ package.json が存在します
) else (
    echo ✗ package.json が見つかりません
    pause
    exit /b 1
)

echo.
echo 3. angular.json の確認...
if exist "angular.json" (
    echo ✓ angular.json が存在します
) else (
    echo ✗ angular.json が見つかりません
    pause
    exit /b 1
)

echo.
echo 4. tsconfig.json の確認...
if exist "tsconfig.json" (
    echo ✓ tsconfig.json が存在します
) else (
    echo ✗ tsconfig.json が見つかりません
    pause
    exit /b 1
)

echo.
echo 5. src ディレクトリの確認...
if exist "src" (
    echo ✓ src ディレクトリが存在します
    if exist "src\main.ts" (
        echo ✓ src\main.ts が存在します
    ) else (
        echo ✗ src\main.ts が見つかりません
    )
    if exist "src\polyfills.ts" (
        echo ✓ src\polyfills.ts が存在します
    ) else (
        echo ✗ src\polyfills.ts が見つかりません
    )
) else (
    echo ✗ src ディレクトリが見つかりません
    pause
    exit /b 1
)

echo.
echo 6. node_modules の確認...
if exist "node_modules" (
    echo ✓ node_modules ディレクトリが存在します
) else (
    echo ✗ node_modules ディレクトリが見つかりません
    echo   npm install を実行してください
)

echo.
echo 7. Angular CLI の確認...
call ng version
if %ERRORLEVEL% neq 0 (
    echo ✗ Angular CLI がインストールされていません
    echo   npm install -g @angular/cli を実行してください
) else (
    echo ✓ Angular CLI が利用可能です
)

echo.
echo 診断が完了しました。
cd ..
pause
