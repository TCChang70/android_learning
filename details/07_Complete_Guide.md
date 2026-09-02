# 常常見問題排解與完整實作指引（一步步做完三個專案）

> 這份文件把 Day 1～Day 3 的「程式片段」串成**完整可編譯的專案**，一步步帶你做，
> 並說明**每一步做完之後的預期結果**，讓你知道做到哪、對不對。
> 對應專案完整程式碼：`04_Example_BMI.md`、`05_Example_MemoApp.md`
> 新增補齊：Day 2 待辦清單 App 完整檔案（本文件第 4 章）。

---

## Part 0. 三個專案的「共用前置步驟」

不管做哪一個專案，都要先做這些一次性的步驟。

### Step 0-1　用精靈建立空白專案

1. Android Studio → **File → New → New Project**
2. 選 **Empty Views Activity**（範本名稱可能顯示為 Empty Activity）
3. 填寫：
   - **Name**：如 `BmiApp` / `TodoApp` / `MemoApp`
   - **Package name**：自動產生，可改為 `com.example.bmi` 等
   - **Language**：**Java**（務必選 Java，不是 Kotlin）
   - **Minimum SDK**：`API 24`
4. 按 **Finish**，等待 Gradle 第一次建置完成
5. 建立後畫面如下：
   - `MainActivity.java`
   - `res/layout/activity_main.xml`
   - `res/values/strings.xml`、`themes.xml`、`colors.xml`
   - `AndroidManifest.xml`
   - `app/build.gradle`

> **預期結果**：專案能直接「Run」出一個顯示 Hello World 的空白畫面 App。

### Step 0-2　把 App 名稱改成自己的（strings.xml）

`res/values/strings.xml` 預設內容：

```xml
<resources>
    <string name="app_name">BmiApp</string>
</resources>
```

改成你想要的顯示名稱：

```xml
<resources>
    <string name="app_name">BMI 計算機</string>
</resources>
```

> **預期結果**：重跑後模擬器桌面上的 App 名稱會變（需先移除舊的再重新安裝才看得到變化）。

### Step 0-3　確認 Manifest（幾乎不用動）

精靈已自動把 `MainActivity` 註冊好。做法：開啟 `AndroidManifest.xml` 確認有：

```xml
<activity android:name=".MainActivity" />
```

> ⚠️ 本學習系列都只改「同一個 MainActivity」或「精靈幫你新增的 Activity」，
> **沒有手動新增 class**，所以空白範本不會有「activity 沒註冊」的錯誤。
> 只有當你自己「手動 new 一個 class 當 Activity」時才需要補此行。

---

## Part 1. 專案一：BMI 計算機（Day 1 成果）

### Step 1-1　替換佈局檔

開啟 `res/layout/activity_main.xml`，**全部內容**替換成 `04_Example_BMI.md` 第 1 節的 XML。

> **預期結果**：切到 **Design** 標籤，會看到直立排版：標題「BMI 計算機」、
> 兩個輸入框（身高 / 體重）、一個「計算 BMI」按鈕、一個結果文字。

### Step 1-2　替換 Java 檔

開啟 `MainActivity.java`，**全部內容**替換成 `04_Example_BMI.md` 第 2 節的 Java（記得把 `package` 改成你的）。

> **預期結果**：無紅字錯誤（若有 import 紅字，按 `Alt+Enter` 讓 Android Studio 自動補 import）。

### Step 1-3　執行與驗證

1. 點 ▶ **Run**，選擇模擬器
2. 輸入 身高 `170`、體重 `60` → 按「計算 BMI」
3. 結果應顯示：
   - `BMI = 20.8`
   - `分類：正常`
4. 故意不輸入直接按計算 → 出現 Toast「請輸入身高與體重」

> ✅ **實作完成**。你已完成 Day 1 全部重點：佈局、加入 View、findViewById 綁定、事件處理、Toast。

---

## Part 2. 專案二：待辦事項 Todo App（Day 2 成果 · 完整檔案本文件補齊）

> Day 2 教材只給片段，這裡給你**完整可編譯**的兩支檔案。

### Step 2-1　替換 `activity_main.xml`

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:padding="16dp">

    <LinearLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:orientation="horizontal">

        <EditText
            android:id="@+id/etTodo"
            android:layout_width="0dp"
            android:layout_height="wrap_content"
            android:layout_weight="1"
            android:hint="輸入待辦事項" />

        <Button
            android:id="@+id/btnAdd"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="新增" />
    </LinearLayout>

    <ListView
        android:id="@+id/listView"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:layout_marginTop="16dp" />
</LinearLayout>
```

> **預期結果**：上方水平排列「輸入框 + 新增鈕」，下方整片 ListView。

### Step 2-2　替換 `MainActivity.java`

```java
package com.example.todoapp;

import android.app.AlertDialog;
import android.os.Bundle;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import java.util.ArrayList;

public class MainActivity extends AppCompatActivity {

    private final ArrayList<String> todoList = new ArrayList<>();
    private ArrayAdapter<String> adapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        EditText etTodo = findViewById(R.id.etTodo);
        Button btnAdd = findViewById(R.id.btnAdd);
        ListView listView = findViewById(R.id.listView);

        // ArrayAdapter：把 ArrayList 的每一筆資料變成 ListView 的一列
        adapter = new ArrayAdapter<>(this, android.R.layout.simple_list_item_1, todoList);
        listView.setAdapter(adapter);

        // 新增（lambda 對照：即 new View.OnClickListener(){ onClick() { ... } }）
        btnAdd.setOnClickListener(v -> {
            String text = etTodo.getText().toString().trim();
            if (text.isEmpty()) {
                Toast.makeText(this, "請輸入待辦內容", Toast.LENGTH_SHORT).show();
                return;
            }
            todoList.add(text);
            adapter.notifyDataSetChanged();   // 通知 ListView 重新繪製
            etTodo.setText("");
        });

        // 點擊列 → AlertDialog 確認刪除（lambda 對照：setOnItemClickListener 有 4 參數）
        listView.setOnItemClickListener((parent, view, position, id) -> {
            String item = todoList.get(position);
            new AlertDialog.Builder(this)
                    .setTitle("刪除")
                    .setMessage("確定要刪除「" + item + "」嗎？")
                    .setPositiveButton("刪除", (dialog, which) -> {
                        todoList.remove(position);
                        adapter.notifyDataSetChanged();
                    })
                    .setNegativeButton("取消", null)
                    .show();
        });
    }
}
```

> **預期結果**：無編譯錯誤。

### Step 2-3　執行與驗證

1. Run
2. 輸入「買牛奶」→ 新增 → 列表出現「買牛奶」
3. 再新增「寫作業」→ 兩列並排顯示
4. 點「買牛奶」→ 跳出確認對話框 → 按「刪除」→ 該列消失
5. 對焦新增：按「新增」但內容空白 → 出現 Toast

> ✅ **實作完成**。驗證重點：Adapter 讓資料與畫面同步、點擊列刪除。

> 💡 提醒：資料只存在 `ArrayList`（記憶體）。**把 App 滑掉重開，資料會不見**——這就是 Day 3 要解決的「持久化」。

---

## Part 3. 專案三：備忘錄 Memo App（Day 3 成果 · Room 持久化）

### Step 3-1　加入 Room 依賴

開啟 `app/build.gradle`，在 `dependencies { ... }` 區塊**加上**：

```groovy
dependencies {
    implementation 'androidx.appcompat:appcompat:1.6.1'
    implementation 'com.google.android.material:material:1.9.0'
    implementation 'androidx.recyclerview:recyclerview:1.3.0'

    implementation 'androidx.room:room-runtime:2.6.1'
    annotationProcessor 'androidx.room:room-compiler:2.6.1'
}
```

按右上角出現的 **Sync Now** 同步。

> ⚠️ 專案建立時若尚未加入 recyclerview 依賴，`<androidx.recyclerview.widget.RecyclerView>` 會標紅字，加入後即消失。
> ⚠️ 若你是 Java 專案請用 `annotationProcessor`，**不是** `kapt`（那是 Kotlin 用的）。

### Step 3-2　貼入 5 個 Java 檔 + 1 個佈局檔

依 `05_Example_MemoApp.md`，在原本的 `MainActivity.java` 旁邊（同套件資料夾）按下右鍵 **New → Java Class** 建立：

| 檔案 | 內容出處 |
|---|---|
| `Memo.java` | `05` 第 2 節 |
| `MemoDao.java` | `05` 第 3 節 |
| `AppDatabase.java` | `05` 第 4 節 |
| `MemoAdapter.java` | `05` 第 6 節 |
| `row_memo.xml` | `05` 第 5 節（`res/layout/` 下 New → Layout Resource File） |
| `activity_main.xml` | 用 `05` 第 7 節替換 |
| `MainActivity.java` | 用 `05` 第 8 節替換 |

> **預期結果**：專案總共 4 個 Java class（MainActivity、Memo、MemoDao、AppDatabase、MemoAdapter），
> Gradle 同步後**無紅字**。若有紅字，多半是 import 沒補齊，游標停紅字上按 `Alt+Enter`。

### Step 3-3　執行與驗證

1. Run
2. 輸入標題「第一個筆記」+ 內容 → 新增 → 列表出現
3. 多新增幾筆 → 資料以 id 倒序（最新的在上面）
4. **把 App 從最近使用的應用程式列表滑掉，再重新開啟** → 資料還在
   - ✅ 這代表已真正寫入 SQLite（Room 底層就是 SQLite），不只是記憶體

### Step 3-4　驗證「資料真的有存進資料庫」

想親眼看到數據庫內容，用 Android Studio 內建工具：

1. 模擬器開著 App
2. **View → Tool Windows → App Inspection（或 Device Explorer → data/data/套件名/databases）**
3. 開啟 `memo.db` 即可瀏覽 `memo` 資料表內容

> 💡 `memo.db` 位置：`data/data/你的套件名/databases/memo.db`

---

## Part 4. 常見錯誤排解表

| # | 錯誤現象 | 原因 | 解法 |
|---|---|---|---|
| 1 | `R` 找不到 / `R.id.xxx` 紅字 | import 的是別的 `R`，或資源檔有 XML 錯誤 | 確認 import 為 `你的套件名.R`、修好 XML |
| 2 | `new View.OnClickListener` 或 lambda 不認識 | Language 選到 Kotlin，或沒開 Java 8 | 換成 Java 重開專案 |
| 3 | RecyclerView 標紅字 | 缺少 recyclerview 依賴 | 加 `androidx.recyclerview:recyclerview` |
| 4 | `annotationProcessor` 找不到 Room 的 DAO/Entity | 漏貼 `@Dao` / `@Entity`、或忘了加 `room-compiler` | 檢查註解與依賴 |
| 5 | `ClassNotFound` 或 App 直接閃退 | Activity 沒註冊進 Manifest | 補 `<activity android:name=".XxxActivity" />` |
| 6 | 資料重開就消失（Day2 現象） | 用了記憶體 ArrayList / 沒接資料庫 | 參考 Day 3 改用 Room |
| 7 | 字體/排版在不同手機忽大忽小 | 用了 px | 用 `dp`（距離）/ `sp`（文字） |
| 8 | 執行時 `Default FirebaseApp is not initialized` | 誤加到 Firebase | 忽略；非本系列用到的東西別加依賴即可 |

---

## 下一步

全部三個專案做完，表示你已完成 Day1～Day3 的全部實作。
接著可以挑戰額外完整範例：**記帳 App** → `08_Extra_ExpenseTracker.md`