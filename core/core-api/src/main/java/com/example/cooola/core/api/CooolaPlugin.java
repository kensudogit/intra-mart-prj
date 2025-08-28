package com.example.cooola.core.api;

import java.util.Map;

/**
 * COOOLa Micro プラグインインターフェース
 * INTRA-MART環境で動作するプラグインの基本契約を定義
 */
public interface CooolaPlugin {

    /**
     * プラグイン名を取得
     * 
     * @return プラグイン名
     */
    String getName();

    /**
     * プラグインのバージョンを取得
     * 
     * @return プラグインのバージョン
     */
    String getVersion();

    /**
     * プラグインの説明を取得
     * 
     * @return プラグインの説明
     */
    String getDescription();

    /**
     * プラグインを初期化
     * 
     * @param context プラグインコンテキスト
     */
    void initialize(PluginContext context);

    /**
     * プラグインを開始
     */
    void start();

    /**
     * プラグインを停止
     */
    void stop();

    /**
     * プラグインの状態を取得
     * 
     * @return プラグインの状態
     */
    PluginStatus getStatus();

    /**
     * プラグインのメタデータを取得
     * 
     * @return プラグインのメタデータ
     */
    PluginMetadata getMetadata();

    /**
     * プラグインの設定を取得
     * 
     * @return プラグインの設定
     */
    Map<String, Object> getConfiguration();

    /**
     * プラグインの設定を更新
     * 
     * @param config 新しい設定
     */
    void updateConfiguration(Map<String, Object> config);
}
