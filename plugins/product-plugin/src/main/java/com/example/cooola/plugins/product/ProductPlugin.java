package com.example.cooola.plugins.product;

import com.example.cooola.core.api.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;

/**
 * 商品管理プラグイン
 * INTRA-MART環境で動作する商品管理機能を提供
 */
@Slf4j
@Component
public class ProductPlugin implements CooolaPlugin {

    private PluginContext context;
    private PluginStatus status = PluginStatus.UNINITIALIZED;
    private final Map<String, Object> configuration = new HashMap<>();
    private final PluginMetadata metadata;

    public ProductPlugin() {
        this.metadata = PluginMetadata.builder()
                .id("product-management")
                .name("商品管理プラグイン")
                .version("1.0.0")
                .description("商品の登録、編集、削除、検索を行うプラグイン")
                .vendor("COOOLa Micro")
                .license("MIT")
                .build();

        // デフォルト設定
        configuration.put("maxProducts", 10000);
        configuration.put("enableBarcode", true);
        configuration.put("enableImageUpload", true);
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
        log.info("商品管理プラグインの初期化を開始: {}", context.getPluginId());
        this.context = context;

        try {
            // データベース接続の確認
            // テーブルの存在確認
            // 初期データの設定

            this.status = PluginStatus.INITIALIZED;
            log.info("商品管理プラグインの初期化が完了しました");

        } catch (Exception e) {
            log.error("商品管理プラグインの初期化中にエラーが発生しました", e);
            this.status = PluginStatus.ERROR;
            throw new RuntimeException("プラグイン初期化エラー", e);
        }
    }

    @Override
    public void start() {
        log.info("商品管理プラグインの開始を開始");

        if (status != PluginStatus.INITIALIZED && status != PluginStatus.STOPPED) {
            log.warn("プラグインが開始可能な状態ではありません: {}", status);
            return;
        }

        try {
            this.status = PluginStatus.STARTING;

            // 商品管理サービスの開始
            // イベントリスナーの登録
            // スケジューラーの開始

            this.status = PluginStatus.RUNNING;
            log.info("商品管理プラグインが開始されました");

        } catch (Exception e) {
            log.error("商品管理プラグインの開始中にエラーが発生しました", e);
            this.status = PluginStatus.ERROR;
            throw new RuntimeException("プラグイン開始エラー", e);
        }
    }

    @Override
    public void stop() {
        log.info("商品管理プラグインの停止を開始");

        if (!status.isStoppable()) {
            log.warn("プラグインが停止可能な状態ではありません: {}", status);
            return;
        }

        try {
            this.status = PluginStatus.STOPPING;

            // 商品管理サービスの停止
            // イベントリスナーの解除
            // スケジューラーの停止

            this.status = PluginStatus.STOPPED;
            log.info("商品管理プラグインが停止されました");

        } catch (Exception e) {
            log.error("商品管理プラグインの停止中にエラーが発生しました", e);
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
        log.info("商品管理プラグインの設定を更新: {}", config);

        // 設定の検証
        validateConfiguration(config);

        // 設定の更新
        configuration.putAll(config);

        log.info("商品管理プラグインの設定が更新されました");
    }

    /**
     * 設定の検証
     * 
     * @param config 新しい設定
     */
    private void validateConfiguration(Map<String, Object> config) {
        if (config.containsKey("maxProducts")) {
            Object maxProducts = config.get("maxProducts");
            if (!(maxProducts instanceof Integer) || (Integer) maxProducts <= 0) {
                throw new IllegalArgumentException("maxProductsは正の整数である必要があります");
            }
        }

        if (config.containsKey("enableBarcode")) {
            Object enableBarcode = config.get("enableBarcode");
            if (!(enableBarcode instanceof Boolean)) {
                throw new IllegalArgumentException("enableBarcodeはboolean値である必要があります");
            }
        }

        if (config.containsKey("enableImageUpload")) {
            Object enableImageUpload = config.get("enableImageUpload");
            if (!(enableImageUpload instanceof Boolean)) {
                throw new IllegalArgumentException("enableImageUploadはboolean値である必要があります");
            }
        }
    }
}
