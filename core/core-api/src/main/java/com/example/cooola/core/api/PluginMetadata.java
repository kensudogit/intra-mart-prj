package com.example.cooola.core.api;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.Collections;

/**
 * プラグインのメタデータ
 * プラグインの詳細情報を管理
 */
public class PluginMetadata {
    
    private final String id;
    private final String name;
    private final String version;
    private final String description;
    private final String vendor;
    private final String license;
    private final List<String> dependencies;
    private final Map<String, String> properties;
    private final LocalDateTime createdDate;
    private final LocalDateTime lastModifiedDate;
    
    private PluginMetadata(Builder builder) {
        this.id = builder.id;
        this.name = builder.name;
        this.version = builder.version;
        this.description = builder.description;
        this.vendor = builder.vendor;
        this.license = builder.license;
        this.dependencies = Collections.unmodifiableList(builder.dependencies);
        this.properties = Collections.unmodifiableMap(builder.properties);
        this.createdDate = builder.createdDate;
        this.lastModifiedDate = builder.lastModifiedDate;
    }
    
    // Getters
    public String getId() { return id; }
    public String getName() { return name; }
    public String getVersion() { return version; }
    public String getDescription() { return description; }
    public String getVendor() { return vendor; }
    public String getLicense() { return license; }
    public List<String> getDependencies() { return dependencies; }
    public Map<String, String> getProperties() { return properties; }
    public LocalDateTime getCreatedDate() { return createdDate; }
    public LocalDateTime getLastModifiedDate() { return lastModifiedDate; }
    
    /**
     * プロパティの値を取得
     * @param key キー
     * @return 値
     */
    public String getProperty(String key) {
        return properties.get(key);
    }
    
    /**
     * プロパティの値を取得（デフォルト値付き）
     * @param key キー
     * @param defaultValue デフォルト値
     * @return 値
     */
    public String getProperty(String key, String defaultValue) {
        return properties.getOrDefault(key, defaultValue);
    }
    
    /**
     * 依存関係があるかどうかを判定
     * @return 依存関係がある場合はtrue
     */
    public boolean hasDependencies() {
        return !dependencies.isEmpty();
    }
    
    /**
     * ビルダークラス
     */
    public static class Builder {
        private String id;
        private String name;
        private String version;
        private String description;
        private String vendor;
        private String license;
        private List<String> dependencies = Collections.emptyList();
        private Map<String, String> properties = Collections.emptyMap();
        private LocalDateTime createdDate = LocalDateTime.now();
        private LocalDateTime lastModifiedDate = LocalDateTime.now();
        
        public Builder id(String id) {
            this.id = id;
            return this;
        }
        
        public Builder name(String name) {
            this.name = name;
            return this;
        }
        
        public Builder version(String version) {
            this.version = version;
            return this;
        }
        
        public Builder description(String description) {
            this.description = description;
            return this;
        }
        
        public Builder vendor(String vendor) {
            this.vendor = vendor;
            return this;
        }
        
        public Builder license(String license) {
            this.license = license;
            return this;
        }
        
        public Builder dependencies(List<String> dependencies) {
            this.dependencies = dependencies;
            return this;
        }
        
        public Builder properties(Map<String, String> properties) {
            this.properties = properties;
            return this;
        }
        
        public Builder createdDate(LocalDateTime createdDate) {
            this.createdDate = createdDate;
            return this;
        }
        
        public Builder lastModifiedDate(LocalDateTime lastModifiedDate) {
            this.lastModifiedDate = lastModifiedDate;
            return this;
        }
        
        public PluginMetadata build() {
            return new PluginMetadata(this);
        }
    }
    
    /**
     * 新しいビルダーを作成
     * @return ビルダーインスタンス
     */
    public static Builder builder() {
        return new Builder();
    }
}
