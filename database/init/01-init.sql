-- INTRA-MART データベース初期化スクリプト
-- PostgreSQL 13用

-- データベースの作成（既に存在する場合はスキップ）
-- CREATE DATABASE intramart_dev;

-- スキーマの作成
CREATE SCHEMA IF NOT EXISTS intramart;

-- INTRA-MART用の基本テーブル
CREATE TABLE IF NOT EXISTS intramart.users (
    user_id VARCHAR(32) PRIMARY KEY,
    user_name VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    status INTEGER DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS intramart.roles (
    role_id VARCHAR(32) PRIMARY KEY,
    role_name VARCHAR(100) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS intramart.user_roles (
    user_id VARCHAR(32) REFERENCES intramart.users(user_id),
    role_id VARCHAR(32) REFERENCES intramart.roles(role_id),
    PRIMARY KEY (user_id, role_id)
);

CREATE TABLE IF NOT EXISTS intramart.menu_items (
    menu_id VARCHAR(32) PRIMARY KEY,
    parent_menu_id VARCHAR(32),
    menu_name VARCHAR(100) NOT NULL,
    menu_url VARCHAR(255),
    display_order INTEGER DEFAULT 0,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- サンプルデータの挿入
INSERT INTO intramart.users (user_id, user_name, password, email) VALUES
('admin', '管理者', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'admin@intramart.local'),
('user1', '一般ユーザー1', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'user1@intramart.local')
ON CONFLICT (user_id) DO NOTHING;

INSERT INTO intramart.roles (role_id, role_name, description) VALUES
('ADMIN', '管理者', 'システム管理者権限'),
('USER', '一般ユーザー', '一般ユーザー権限')
ON CONFLICT (role_id) DO NOTHING;

INSERT INTO intramart.user_roles (user_id, role_id) VALUES
('admin', 'ADMIN'),
('user1', 'USER')
ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO intramart.menu_items (menu_id, parent_menu_id, menu_name, menu_url, display_order) VALUES
('HOME', NULL, 'ホーム', '/home', 1),
('USER_MANAGEMENT', NULL, 'ユーザー管理', '/users', 2),
('SYSTEM_SETTINGS', NULL, 'システム設定', '/settings', 3)
ON CONFLICT (menu_id) DO NOTHING;

-- インデックスの作成
CREATE INDEX IF NOT EXISTS idx_users_email ON intramart.users(email);
CREATE INDEX IF NOT EXISTS idx_users_status ON intramart.users(status);
CREATE INDEX IF NOT EXISTS idx_menu_items_parent ON intramart.menu_items(parent_menu_id);
CREATE INDEX IF NOT EXISTS idx_menu_items_order ON intramart.menu_items(display_order);

-- コメントの追加
COMMENT ON TABLE intramart.users IS 'ユーザー情報テーブル';
COMMENT ON TABLE intramart.roles IS 'ロール情報テーブル';
COMMENT ON TABLE intramart.user_roles IS 'ユーザーロール関連テーブル';
COMMENT ON TABLE intramart.menu_items IS 'メニュー項目テーブル';
