package com.example.cooola.core.api;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * プラグインコンテキスト
 * プラグインがINTRA-MART環境と連携するためのコンテキスト情報を提供
 */
public class PluginContext {

    private final String pluginId;
    private final Map<String, Object> attributes;
    private final PluginRegistry pluginRegistry;

    public PluginContext(String pluginId, PluginRegistry pluginRegistry) {
        this.pluginId = pluginId;
        this.pluginRegistry = pluginRegistry;
        this.attributes = new ConcurrentHashMap<>();
    }

    /**
     * プラグインIDを取得
     * 
     * @return プラグインID
     */
    public String getPluginId() {
        return pluginId;
    }

    /**
     * プラグインレジストリを取得
     * 
     * @return プラグインレジストリ
     */
    public PluginRegistry getPluginRegistry() {
        return pluginRegistry;
    }

    /**
     * 属性を設定
     * 
     * @param key   キー
     * @param value 値
     */
    public void setAttribute(String key, Object value) {
        attributes.put(key, value);
    }

    /**
     * 属性を取得
     * 
     * @param key キー
     * @return 値
     */
    public Object getAttribute(String key) {
        return attributes.get(key);
    }

    /**
     * 属性を取得（型指定）
     * 
     * @param key  キー
     * @param type 型
     * @param <T>  型パラメータ
     * @return 値
     */
    @SuppressWarnings("unchecked")
    public <T> T getAttribute(String key, Class<T> type) {
        Object value = attributes.get(key);
        if (type.isInstance(value)) {
            return (T) value;
        }
        return null;
    }

    /**
     * 属性を削除
     * 
     * @param key キー
     */
    public void removeAttribute(String key) {
        attributes.remove(key);
    }

    /**
     * 全属性を取得
     * 
     * @return 属性のマップ
     */
    public Map<String, Object> getAttributes() {
        return new ConcurrentHashMap<>(attributes);
    }
}
