package com.example.cooola.core.api;

import java.util.List;
import java.util.Optional;

/**
 * プラグインレジストリ
 * プラグインの登録、管理、検索を行う
 */
public interface PluginRegistry {

    /**
     * プラグインを登録
     * 
     * @param plugin プラグイン
     * @return 登録が成功した場合はtrue
     */
    boolean registerPlugin(CooolaPlugin plugin);

    /**
     * プラグインを登録解除
     * 
     * @param pluginId プラグインID
     * @return 登録解除が成功した場合はtrue
     */
    boolean unregisterPlugin(String pluginId);

    /**
     * プラグインを取得
     * 
     * @param pluginId プラグインID
     * @return プラグイン（存在しない場合は空）
     */
    Optional<CooolaPlugin> getPlugin(String pluginId);

    /**
     * 全プラグインを取得
     * 
     * @return 全プラグインのリスト
     */
    List<CooolaPlugin> getAllPlugins();

    /**
     * 指定された状態のプラグインを取得
     * 
     * @param status プラグインの状態
     * @return 該当するプラグインのリスト
     */
    List<CooolaPlugin> getPluginsByStatus(PluginStatus status);

    /**
     * プラグインが存在するかどうかを判定
     * 
     * @param pluginId プラグインID
     * @return 存在する場合はtrue
     */
    boolean hasPlugin(String pluginId);

    /**
     * 登録されているプラグインの数を取得
     * 
     * @return プラグインの数
     */
    int getPluginCount();

    /**
     * プラグインを開始
     * 
     * @param pluginId プラグインID
     * @return 開始が成功した場合はtrue
     */
    boolean startPlugin(String pluginId);

    /**
     * プラグインを停止
     * 
     * @param pluginId プラグインID
     * @return 停止が成功した場合はtrue
     */
    boolean stopPlugin(String pluginId);

    /**
     * 全プラグインを開始
     * 
     * @return 開始が成功したプラグインの数
     */
    int startAllPlugins();

    /**
     * 全プラグインを停止
     * 
     * @return 停止が成功したプラグインの数
     */
    int stopAllPlugins();

    /**
     * プラグインの状態を更新
     * 
     * @param pluginId プラグインID
     * @param status   新しい状態
     */
    void updatePluginStatus(String pluginId, PluginStatus status);
}
