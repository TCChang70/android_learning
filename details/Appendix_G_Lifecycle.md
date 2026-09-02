# Appendix G：Activity 生命週期

---

## 生命週期流程圖（文字版）

```
onCreate() → onStart() → onResume()   ← App 可見且可互動
                ↑        ↓
                ← onPause() ← onStop()   ← App 部分可見 / 完全不可見
                      ↓
                onDestroy()              ← App 被銷毀
```

---

## 各方法用途對照

| 方法 | 何時呼叫 | 必做的事 | 常見用途 |
|---|---|---|---|
| `onCreate(Bundle)` | **第一次建立** | `super.onCreate()`、`setContentView()` | 初始化 View、綁定事件、建立資料庫 |
| `onStart()` | 變為可見（前景） | `super.onStart()` | 註冊廣播接收器、開始動畫 |
| `onResume()` | **取得焦點、可互動** | `super.onResume()` | 開啟相機、開始感應器、恢復音樂 |
| `onPause()` | **失去焦點**（另一 Activity 彈出） | `super.onPause()`、**快速釋放資源** | 暫停相機、存檔草稿、停止動畫 |
| `onStop()` | 完全不可見 | `super.onStop()` | 釋放大記憶體、關閉資料庫連線 |
| `onDestroy()` | 即將銷毀 | `super.onDestroy()` | 釋放所有資源、取消註冊 |
| `onRestart()` | 從 Stop 回到 Start | `super.onRestart()` | 重新載入資料 |

> **關鍵差異**：JFrame 沒有「被系統回收再重建」的機制；Android 記憶體不足時會 **殺掉 onStop/onDestroy 狀態的 Activity**，下次使用者回來時從 `onCreate` 重建。

---

## 狀態保存與恢復

```java
// 1. 儲存暫態資料（旋轉螢幕、被系統殺掉前）
@Override
protected void onSaveInstanceState(@NonNull Bundle outState) {
    super.onSaveInstanceState(outState);
    outState.putString("draft", etInput.getText().toString());
    outState.putInt("counter", count);
}

// 2. 恢復（onCreate 或 onRestoreInstanceState）
@Override
protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    setContentView(R.layout.activity_main);
    if (savedInstanceState != null) {
        String draft = savedInstanceState.getString("draft", "");
        int count = savedInstanceState.getInt("counter", 0);
        etInput.setText(draft);
    }
}
```

> `onSaveInstanceState` 只在 **非正常關閉**（如旋轉、Home 鍵、系統回收）時呼叫；使用者主動按 Back 關閉則不呼叫。

---

## 與 JFrame 對照

| JFrame | Android Activity | 備註 |
|---|---|---|
| `new JFrame()` → `setVisible(true)` | `startActivity(intent)` | 建立並顯示 |
| `setDefaultCloseOperation(EXIT_ON_CLOSE)` | 按 Back → `finish()` | 關閉視窗 |
| `windowClosing(WindowEvent)` | `onPause()` → `onStop()` → `onDestroy()` | 關閉流程 |
| 無對應 | `onSaveInstanceState` | 系統強制回收前保存狀態 |
| 無對應 | `onRestart()` / `onStart()` | 從背景回前景 |
| `ComponentListener` | `onConfigurationChanged` | 螢幕旋轉、語言變更 |

---

## 常見坑

| 坑 | 現象 | 解法 |
|---|---|---|
| 在 `onPause` 做耗時操作 | ANR（Application Not Responding） | 只做「快速釋放」；耗時用背景執行緒 |
| 忘記 `super.onXxx()` | Crash 或行為異常 | 每個 override 開頭必寫 `super.onXxx()` |
| `onCreate` 重複初始化 | 旋轉螢幕資料重置 | 用 `savedInstanceState` 恢復、或用 `ViewModel` |
| 在 `onDestroy` 關資料庫 | 可能不會被呼叫（系統直接殺進程） | Room 用 `Room.databaseBuilder(...).build()` 單例，不需手動關閉 |

---

## 啟動模式（launchMode）

| 模式 | 行為 | 適用場景 |
|---|---|---|
| `standard`（預設） | 每次 `startActivity` 都新建實例 | 一般頁面 |
| `singleTop` | 栈頂已是同一類別則不新建、走 `onNewIntent` | 通知點開詳情頁 |
| `singleTask` | 任務堆疊內只有一個實例 | 主頁、登入頁 |
| `singleInstance` | 單獨任務堆疊 | 特殊需求（極少用） |

> Manifest 設定：`<activity android:name=".MainActivity" android:launchMode="singleTop" />`