package com.example.cooola.plugins.report;

import com.example.cooola.core.api.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;

/**
 * レポートプラグイン
 * INTRA-MART環境で動作するレポート生成機能を提供
 * CSV、Excel、PDF形式でのレポート出力に対応
 */
@Slf4j
@Component
public class ReportPlugin implements CooolaPlugin {

    private PluginContext context;
    private PluginStatus status = PluginStatus.UNINITIALIZED;
    private final Map<String, Object> configuration = new HashMap<>();
    private final PluginMetadata metadata;

    public ReportPlugin() {
        this.metadata = PluginMetadata.builder()
                .id("report-generation")
                .name("レポートプラグイン")
                .version("1.0.0")
                .description("CSV、Excel、PDF形式でのレポート生成を行うプラグイン")
                .vendor("COOOLa Micro")
                .license("MIT")
                .build();

        // デフォルト設定
        configuration.put("enableCSVExport", true);
        configuration.put("enableExcelExport", true);
        configuration.put("enablePDFExport", true);
        configuration.put("defaultEncoding", "UTF-8");
        configuration.put("maxReportSize", 100000);
        configuration.put("enableScheduledReports", false);
        configuration.put("reportRetentionDays", 30);
    }

    @Override
    public String getName() {
        return metadata.getName();
    }

    @Override
    public String getVersion() {
        return metadata.getVersion();
    }

    @Override
    public String getDescription() {
        return metadata.getDescription();
    }

    @Override
    public void initialize(PluginContext context) {
        log.info("レポートプラグインの初期化を開始: {}", context.getPluginId());
        this.context = context;

        try {
            // データベース接続の確認
            // レポートテンプレートの読み込み
            // 出力ディレクトリの確認・作成
            // スケジュール設定の初期化

            this.status = PluginStatus.INITIALIZED;
            log.info("レポートプラグインの初期化が完了しました");

        } catch (Exception e) {
            log.error("レポートプラグインの初期化中にエラーが発生しました", e);
            this.status = PluginStatus.ERROR;
            throw new RuntimeException("プラグイン初期化エラー", e);
        }
    }

    @Override
    public void start() {
        log.info("レポートプラグインの開始を開始");

        if (status != PluginStatus.INITIALIZED && status != PluginStatus.STOPPED) {
            log.warn("プラグインが開始可能な状態ではありません: {}", status);
            return;
        }

        try {
            this.status = PluginStatus.STARTING;

            // レポート生成サービスの開始
            // スケジュール実行サービスの開始
            // テンプレート管理サービスの開始
            // イベントリスナーの登録

            this.status = PluginStatus.RUNNING;
            log.info("レポートプラグインが開始されました");

        } catch (Exception e) {
            log.error("レポートプラグインの開始中にエラーが発生しました", e);
            this.status = PluginStatus.ERROR;
            throw new RuntimeException("プラグイン開始エラー", e);
        }
    }

    @Override
    public void stop() {
        log.info("レポートプラグインの停止を開始");

        if (!status.isStoppable()) {
            log.warn("プラグインが停止可能な状態ではありません: {}", status);
            return;
        }

        try {
            this.status = PluginStatus.STOPPING;

            // レポート生成サービスの停止
            // スケジュール実行サービスの停止
            // テンプレート管理サービスの停止
            // イベントリスナーの解除

            this.status = PluginStatus.STOPPED;
            log.info("レポートプラグインが停止されました");

        } catch (Exception e) {
            log.error("レポートプラグインの停止中にエラーが発生しました", e);
            this.status = PluginStatus.ERROR;
            throw new RuntimeException("プラグイン停止エラー", e);
        }
    }

    @Override
    public PluginStatus getStatus() {
        return status;
    }

    @Override
    public PluginMetadata getMetadata() {
        return metadata;
    }

    @Override
    public Map<String, Object> getConfiguration() {
        return new HashMap<>(configuration);
    }

    @Override
    public void updateConfiguration(Map<String, Object> config) {
        log.info("レポートプラグインの設定を更新: {}", config);

        // 設定の検証
        validateConfiguration(config);

        // 設定の更新
        configuration.putAll(config);

        log.info("レポートプラグインの設定が更新されました");
    }

    /**
     * 設定の検証
     * 
     * @param config 新しい設定
     */
    private void validateConfiguration(Map<String, Object> config) {
        if (config.containsKey("maxReportSize")) {
            Object maxSize = config.get("maxReportSize");
            if (!(maxSize instanceof Integer) || (Integer) maxSize <= 0) {
                throw new IllegalArgumentException("maxReportSizeは正の整数である必要があります");
            }
        }

        if (config.containsKey("reportRetentionDays")) {
            Object retentionDays = config.get("reportRetentionDays");
            if (!(retentionDays instanceof Integer) || (Integer) retentionDays <= 0) {
                throw new IllegalArgumentException("reportRetentionDaysは正の整数である必要があります");
            }
        }

        if (config.containsKey("enableCSVExport")) {
            Object enableCSV = config.get("enableCSVExport");
            if (!(enableCSV instanceof Boolean)) {
                throw new IllegalArgumentException("enableCSVExportはboolean値である必要があります");
            }
        }

        if (config.containsKey("enableExcelExport")) {
            Object enableExcel = config.get("enableExcelExport");
            if (!(enableExcel instanceof Boolean)) {
                throw new IllegalArgumentException("enableExcelExportはboolean値である必要があります");
            }
        }

        if (config.containsKey("enablePDFExport")) {
            Object enablePDF = config.get("enablePDFExport");
            if (!(enablePDF instanceof Boolean)) {
                throw new IllegalArgumentException("enablePDFExportはboolean値である必要があります");
            }
        }

        if (config.containsKey("enableScheduledReports")) {
            Object enableScheduled = config.get("enableScheduledReports");
            if (!(enableScheduled instanceof Boolean)) {
                throw new IllegalArgumentException("enableScheduledReportsはboolean値である必要があります");
            }
        }

        if (config.containsKey("defaultEncoding")) {
            Object encoding = config.get("defaultEncoding");
            if (!(encoding instanceof String) || ((String) encoding).trim().isEmpty()) {
                throw new IllegalArgumentException("defaultEncodingは空でない文字列である必要があります");
            }
        }
    }
}
