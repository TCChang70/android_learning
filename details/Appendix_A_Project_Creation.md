# Appendix A：建立 Empty Views Activity 專案（共用樣板）

> 所有範例專案的 **Step 1** 皆相同，請參考此處，不再於各範例重複。

---

## 步驟

1. Android Studio → **File → New → New Project**
2. 選 **Empty Views Activity**（注意：**不是** Compose 版）
3. 填寫：
   - **Name**：專案名稱（如 `BmiApp`、`TempConverter`、`MemoApp`）
   - **Package name**：建議 `com.example.專案名小寫`（如 `com.example.bmiapp`）
   - **Language**：**Java**
   - **Minimum SDK**：`API 24`（Android 7.0）
4. **Finish**，等待 Gradle 同步完成
5. 驗證：點 ▶ Run，模擬器出現「Hello World」即成功

---

## 專案結構（建立後）

```
專案根目錄/
├── app/
│   ├── src/
│   │   ├── main/
│   │   │   ├── java/com/example/專案名/   # Java 原始碼
│   │   │   │   └── MainActivity.java
│   │   │   ├── res/
│   │   │   │   ├── layout/activity_main.xml   # 畫面佈局
│   │   │   │   ├── values/strings.xml         # 字串資源
│   │   │   │   ├── values/themes.xml          # 主題
│   │   │   │   └── values/colors.xml          # 顏色
│   │   │   └── AndroidManifest.xml            # 元件宣告
│   │   └── build.gradle                       # 模組設定
│   └── build.gradle                           # 專案設定
├── settings.gradle
└── gradle.properties
```

---

## 常用檔案位置速查

| 檔案 | 用途 | 位置 |
|---|---|---|
| `activity_main.xml` | 主畫面佈局 | `app/src/main/res/layout/` |
| `MainActivity.java` | 主畫面邏輯 | `app/src/main/java/com/example/.../` |
| `strings.xml` | App 名稱、文字 | `app/src/main/res/values/` |
| `AndroidManifest.xml` | Activity 權限宣告 | `app/src/main/` |
| `build.gradle (Module: app)` | 依賴庫、編譯設定 | `app/` |

---

## 給各範例的「取代指令」

| 範例類型 | 需取代的檔案 |
|---|---|
| **單一 Activity** | `activity_main.xml`、`MainActivity.java` |
| **雙 Activity** | 同上 + 新增 `SecondActivity.java` + `activity_second.xml` |
| **RecyclerView** | 同上 + `row_xxx.xml` + `XxxAdapter.java` |
| **Room** | 同上 + `Entity.java`、`Dao.java`、`AppDatabase.java` + `build.gradle` 加依賴 |

> 具體內容請見各範例文件的 Step 2 之後。

---

## 驗證清單（每支範例跑完必做）

- [ ] 模擬器啟動無 Crash
- [ ] 畫面元素對齊、文字顯示正確
- [ ] 點擊/輸入互動無紅字錯誤
- [ ] 重開 App（從多工滑掉再開），資料若應持久化則仍在