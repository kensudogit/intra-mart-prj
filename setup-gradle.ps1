# INTRA-MART Gradle環境のセットアップスクリプト
Write-Host "INTRA-MART Gradle環境のセットアップを開始します..." -ForegroundColor Green

# 必要なディレクトリを作成
Write-Host "ディレクトリ構造を作成中..." -ForegroundColor Yellow
$directories = @(
    "src\main\java",
    "src\main\resources", 
    "src\main\webapp\WEB-INF",
    "src\main\webapp\META-INF",
    "src\test\java",
    "src\test\resources"
)

foreach ($dir in $directories) {
    if (!(Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
        Write-Host "作成: $dir" -ForegroundColor Gray
    }
}

# Gradle Wrapperの確認
Write-Host "Gradle Wrapperを確認中..." -ForegroundColor Yellow
if (!(Test-Path "gradle\wrapper\gradle-wrapper.jar")) {
    Write-Host "警告: Gradle Wrapper JARファイルが見つかりません" -ForegroundColor Yellow
    Write-Host "次のコマンドでGradle Wrapperをダウンロードしてください:" -ForegroundColor Cyan
    Write-Host "  gradle wrapper" -ForegroundColor White
}

# 環境変数の確認
Write-Host "環境変数を確認中..." -ForegroundColor Yellow
$javaHome = $env:JAVA_HOME
if ($javaHome) {
    Write-Host "JAVA_HOME: $javaHome" -ForegroundColor Green
    try {
        $javaVersion = & java -version 2>&1
        Write-Host "Java バージョン:" -ForegroundColor Green
        Write-Host $javaVersion -ForegroundColor Gray
    }
    catch {
        Write-Host "警告: Javaコマンドが実行できません" -ForegroundColor Yellow
    }
} else {
    Write-Host "警告: JAVA_HOMEが設定されていません" -ForegroundColor Yellow
    Write-Host "Java 11以上をインストールしてJAVA_HOMEを設定してください" -ForegroundColor Cyan
}

# Gradleの確認
Write-Host "Gradleの確認中..." -ForegroundColor Yellow
try {
    $gradleVersion = & gradle -version 2>&1
    Write-Host "Gradle バージョン:" -ForegroundColor Green
    Write-Host $gradleVersion -ForegroundColor Gray
} catch {
    Write-Host "Gradleがインストールされていないか、PATHに設定されていません" -ForegroundColor Yellow
    Write-Host "Gradle Wrapperを使用してください: gradlew.bat" -ForegroundColor Cyan
}

Write-Host ""
Write-Host "Gradle環境のセットアップが完了しました" -ForegroundColor Green
Write-Host ""
Write-Host "次のコマンドでプロジェクトをビルドできます:" -ForegroundColor Cyan
Write-Host "  .\gradlew.bat build" -ForegroundColor White
Write-Host ""
Write-Host "次のコマンドでアプリケーションを起動できます:" -ForegroundColor Cyan
Write-Host "  .\gradlew.bat appRun" -ForegroundColor White
Write-Host ""

Read-Host "Enterキーを押して終了"
