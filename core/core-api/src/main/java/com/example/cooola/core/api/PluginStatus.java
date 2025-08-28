package com.example.cooola.core.api;

/**
 * プラグインの状態を表す列挙型
 */
public enum PluginStatus {

    /**
     * 未初期化
     */
    UNINITIALIZED("未初期化"),

    /**
     * 初期化済み
     */
    INITIALIZED("初期化済み"),

    /**
     * 開始中
     */
    STARTING("開始中"),

    /**
     * 実行中
     */
    RUNNING("実行中"),

    /**
     * 停止中
     */
    STOPPING("停止中"),

    /**
     * 停止済み
     */
    STOPPED("停止済み"),

    /**
     * エラー状態
     */
    ERROR("エラー"),

    /**
     * 無効化
     */
    DISABLED("無効化");

    private final String displayName;

    PluginStatus(String displayName) {
        this.displayName = displayName;
    }

    /**
     * 表示名を取得
     * 
     * @return 表示名
     */
    public String getDisplayName() {
        return displayName;
    }

    /**
     * 実行可能な状態かどうかを判定
     * 
     * @return 実行可能な場合はtrue
     */
    public boolean isRunnable() {
        return this == RUNNING;
    }

    /**
     * 停止可能な状態かどうかを判定
     * 
     * @return 停止可能な場合はtrue
     */
    public boolean isStoppable() {
        return this == RUNNING || this == STARTING;
    }

    /**
     * エラー状態かどうかを判定
     * 
     * @return エラー状態の場合はtrue
     */
    public boolean isError() {
        return this == ERROR;
    }
}
