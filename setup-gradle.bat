@echo off
echo INTRA-MART Gradle環境のセットアップを開始します...

REM 必要なディレクトリを作成
echo ディレクトリ構造を作成中...
if not exist "src\main\java" mkdir "src\main\java"
if not exist "src\main\resources" mkdir "src\main\resources"
if not exist "src\main\webapp\WEB-INF" mkdir "src\main\webapp\WEB-INF"
if not exist "src\main\webapp\META-INF" mkdir "src\main\webapp\META-INF"
if not exist "src\test\java" mkdir "src\test\java"
if not exist "src\test\resources" mkdir "src\test\resources"

REM Gradle Wrapperのダウンロード
echo Gradle Wrapperをダウンロード中...
if not exist "gradle\wrapper\gradle-wrapper.jar" (
    echo Gradle Wrapper JARファイルをダウンロードしてください
    echo または、gradle wrapperコマンドを実行してください
)

REM 環境変数の確認
echo 環境変数を確認中...
if "%JAVA_HOME%"=="" (
    echo 警告: JAVA_HOMEが設定されていません
    echo Java 11以上をインストールしてJAVA_HOMEを設定してください
) else (
    echo JAVA_HOME: %JAVA_HOME%
    java -version
)

echo.
echo Gradle環境のセットアップが完了しました
echo.
echo 次のコマンドでプロジェクトをビルドできます：
echo   gradlew.bat build
echo.
echo 次のコマンドでアプリケーションを起動できます：
echo   gradlew.bat appRun
echo.
pause
