import './App.css'

function App() {
  return (
    <div className="App">
      {/* ヘッダー */}
      <div className="header">
        <h1>🏪 COOOLa Micro</h1>
        <p>INTRA-MART統合型倉庫管理システム</p>
      </div>
      
      {/* ナビゲーション */}
      <nav className="nav">
        <div className="nav-content">
          <a href="#" className="nav-brand">COOOLa Micro</a>
          <div className="nav-links">
            <a href="#" className="nav-link">ホーム</a>
            <a href="#" className="nav-link">在庫管理</a>
            <a href="#" className="nav-link">レポート</a>
          </div>
        </div>
      </nav>
      
      {/* メインコンテンツ */}
      <div className="main-content">
        <h2>🚀 システム概要</h2>
        <p>
          マイクロカーネルアーキテクチャを採用した、プラグイン可能な倉庫管理システムです。
          商品管理、在庫追跡、レポート生成などの機能を提供します。
        </p>
        <button className="btn">在庫管理を開始</button>
      </div>
      
      {/* 機能カード */}
      <div className="features">
        <div className="feature-card">
          <h3>📦 商品管理</h3>
          <p>商品の登録、編集、削除、検索を行うプラグイン</p>
        </div>
        
        <div className="feature-card">
          <h3>📊 在庫管理</h3>
          <p>在庫の追跡、アラート、レポート生成を行うプラグイン</p>
        </div>
        
        <div className="feature-card">
          <h3>📈 レポート生成</h3>
          <p>CSV、Excel、PDF形式でのレポート出力に対応</p>
        </div>
      </div>
    </div>
  )
}

export default App
