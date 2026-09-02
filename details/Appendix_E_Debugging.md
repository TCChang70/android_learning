# Appendix E：模擬器/實機除錯技巧

---

## Logcat 過濾技巧

| 過濾器 | 用法 | 範例 |
|---|---|---|
| **Tag** | 只看特定 Tag | `DEBUG`、`MainActivity` |
| **Package** | 只看自己 App | 勾選「Show only selected application」 |
| **Level** | 錯誤/警告/資訊 | `Error`、`Warn`、`Info`、`Debug` |
| **Regex** | 正則過濾 | `Exception\|Error\|Crash` |
| **搜尋框** | 關鍵字 | `onCreate`、`BMI`、`insert` |

> 建議：在程式碼用固定 Tag：`private static final String TAG = "MyApp";` → `Log.d(TAG, "msg")`。

---

## 斷點除錯

1. 程式碼左側行號點一下 → 紅點 = 斷點
2. 工具列點 **蟲子圖示 (Debug)** 或 `Shift+F9`
3. 程式停在斷點 → 下方 **Debug** 視窗可看：
   - **Variables**：區域/成員變數即時值
   - **Watches**：加入運算式（如 `name.length()`）
   - **Call Stack**：呼叫堆疊
4. 控制鍵：
   - `F8` Step Over（跳過）
   - `F7` Step Into（進入方法）
   - `Shift+F8` Step Out（跳出）
   - `F9` Resume（繼續跑到下一斷點）

---

## Layout Inspector（畫面結構檢查）

- 工具列 → **Layout Inspector**（或 `View → Tool Windows → Layout Inspector`）
- 即時顯示：
  - View 階層樹
  - 屬性面板（id、width、height、margin、padding、background、text）
  - 3D 模式看層級遮蓋
- 用途：找「為什麼元件不見了、位置錯、重疊」

---

## App Inspection → Databases（資料庫瀏覽）

- `View → Tool Windows → App Inspection` → **Databases** 標籤
- 選擇模擬器/裝置 → 展開套件名 → `databases` → `memo.db`、`expense.db` 等
- 可：
  - 查看表結構、資料列
  - 執行自訂 SQL 查詢
  - 匯出 CSV

---

## 實機除錯（USB Debugging）

1. 手機：設定 → 開發人員選項 → **USB 偵錯** 開啟
2. USB 連電腦 → 彈出「允許 USB 偵錯」→ 勾選「一律允許」→ 確定
3. Android Studio 工具列裝置下拉選單會出現實機型號
4. Run 直接安裝到實機

> 實機優點：感應器、相機、GPS、指紋、真實效能；模擬器優點：可模擬各螢幕尺寸、API 版本、網路狀況。

---

## 常用 ADB 指令（終端機）

```bash
# 列出連線裝置
adb devices

# 安裝 APK
adb install app/build/outputs/apk/debug/app-debug.apk

# 解除安裝
adb uninstall com.example.bmiapp

# 看 Logcat（可存檔）
adb logcat -s MainActivity:D *:S > log.txt

# 進入 Shell
adb shell

# 複製檔案從裝置（如資料庫）
adb shell "run-as com.example.memoapp cp databases/memo.db /sdcard/memo.db"
adb pull /sdcard/memo.db .

# 截圖
adb exec-out screencap -p > screen.png

# 重啟 adb
adb kill-server && adb start-server
```

---

## 效能分析

- **Profiler** 標籤（`View → Tool Windows → Profiler`）
  - CPU：找耗時方法
  - Memory：看記憶體洩漏、GC 頻率
  - Network：API 呼叫時間
  - Energy：耗電
- 建議：Release build 才看真實效能（Debug build 有額外檢查）