---
marp: true
theme: default
paginate: true
size: 16:9
header: 'Day 2：頁面跳轉與列表（多畫面 App）+ AI 互動指南'
style: |
  section { font-size: 24px; padding: 50px 70px; }
  h1 { font-size: 40px; }
  h2 { font-size: 30px; }
  h3 { font-size: 25px; }
  pre { font-size: 14px; line-height: 1.4; padding: 12px 16px; }
  table { font-size: 17px; }
  blockquote { font-size: 19px; }
  li { margin: 5px 0; }
---

<!--
使用方式：
1. VS Code 安裝 Marp for VS Code 外掛
2. 開啟本檔 → 右上角「Marp: Preview / 匯出 PDF / 匯出 HTML / 匯出 PPTX」
3. 分頁符號為 `---`
4. 「AI 動手做」章節穿插在各教學主題之後，跟著看、跟著做
-->

# Day 2 合併版投影片

## 頁面跳轉與列表：多畫面 App

### 教學內容 + AI 提示互動指南（穿插版）

---

# 本講內容

- 對象：具備 Java / JFrame 經驗，**已完成 Day 1**
- 時間：約 6–8 小時
- 今天會學到：
  - Activity 多畫面、`Intent` 跳轉
  - 畫面間 `putExtra` / `getExtra` 傳值、回傳結果（新舊兩套 API）
  - 系統功能 Intent（撥號、開網頁）
  - `ListView` / `RecyclerView` 列表 + `ArrayAdapter`
  - `AlertDialog` 彈窗
  - 三支完整整合範例：Todo App、商品編輯傳值、顏色選擇器
- ⚡ 與 JFrame 的對照會用 ⚡ 標記

---

# AI 動手做｜與 AI 互動提醒（指南 §0）

| 提醒 | 說明 |
|---|---|
| **背後的陷阱** | 新版 `registerForActivityResult` 用 lambda 回呼；舊 `onActivityResult` 是**方法覆寫，不能用 lambda** |
| **多檔案** | 有的範例要 4 支檔（2 XML + 2 Java），一次跟 AI 要完整才不會對不上 |
| **給套件名** | 不同範例套件名不同，務必指定，避免 id 或 class 對不上 |
| **驗證每一支** | 每個範例照貼後 Run 一次，確認跳轉、傳值、列表都正常 |

> 橘色 `[ ... ]` 是你要自己填的部分；凡是我給的範例提示都可直接複製。

---

# 第 1 章　認識 Activity（多個畫面）

一個 Activity = 一個畫面。要建第二個畫面：

1. 右鍵套件 → **New → Activity → Empty Views Activity**
2. 命名 `SecondActivity` → 自動產生 `SecondActivity.java` + `activity_second.xml`

> ⚡ `SecondActivity` 就等於你另外設計的第二個 `JFrame`。

## 1.1 AndroidManifest.xml 必須註冊 Activity

```xml
<activity android:name=".SecondActivity" />
```

- `android:name=".SecondActivity"`：`.` 開頭 = 「目前套件底下」，等同 `套件名 + .SecondActivity`
- Manifest 是 App 的「身分證」；**手動建 class 忘了註冊會跳錯**（精靈會自動註冊）

---

# AI 動手做｜建立第二個 Activity（指南 §1）

**建立過程通常不需要 AI**：照精靈做，Android Studio 會自動註冊到 `AndroidManifest.xml`。

但可以用 AI 確認「為什麼要註冊、忘了會怎樣」：

```
我用 Android Studio 建立了 SecondActivity，但它不小心沒被註冊到 AndroidManifest.xml，
請用 JFrame 的角度跟我解釋：1) AndroidManifest.xml 是甚麼？ 2) 沒註冊會發生什麼錯誤？
3) 怎麼手動補上 <activity android:name=".SecondActivity" />？
```

> 之後的範例都循「New Project → 新增第二個 Activity」的流程，先會跳轉，再學傳值。

---

# 第 2 章　Intent：啟動新的 Activity

```java
Button btnGo = findViewById(R.id.btnGo);
btnGo.setOnClickListener(v -> {
    Intent intent = new Intent(MainActivity.this, SecondActivity.class);
    startActivity(intent);   // 啟動並跳轉
});
```

- `new Intent(出發點, 目的地)`：第一參數 `MainActivity.this`（從哪）、第二參數 `SecondActivity.class`（到哪）
- `startActivity(intent)`：把意圖交給系統，系統啟動新畫面
- ⚡ JFrame 用 `new SecondFrame().setVisible(true)` 直接建物件；Android 是「描述要去哪裡」交給系統

## 2.1 為什麼用 `MainActivity.this`？

- lambda / anonymous class 裡面的 `this` 指的是**匿名類別自己**，不是 Activity
- 用「**類別名稱.this**」明確指向 `MainActivity` 實體，才能當作 Intent 的出發點

---

# ⭐ 第 2 章　完整範例：兩頁面跳轉 App（jumpdemo）

套件 `com.example.jumpdemo`，共 4 支檔案。

**Step 1** New Project（jumpdemo）→ **Step 2** New `SecondActivity`（自動註冊 Manifest + 產生 XML）

**Step 3–4 畫面 A**（`activity_main.xml` + `MainActivity.java`）：

```java
package com.example.jumpdemo;
public class MainActivity extends AppCompatActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Button btnGo = findViewById(R.id.btnGo);
        btnGo.setOnClickListener(v -> {
            Intent intent = new Intent(MainActivity.this, SecondActivity.class);
            startActivity(intent);
        });
    }
}
```

**Step 5–6 畫面 B**：`activity_second.xml`（置中 TextView「這是第二畫面」）+ `SecondActivity.java`（只 `setContentView(R.layout.activity_second)`）

| 執行 | 預期結果 |
|---|---|
| 點「點我跳到第二畫面」 | 切換到「這是第二畫面」 |
| 按返回鍵 ⌫ | 回到第一個畫面 |

> 若跳到 B 崩潰，先確認 Manifest 有 `<activity android:name=".SecondActivity" />`。
> ✅ 這正是 `new SecondFrame().setVisible(true)` 的等價。

---

# AI 動手做｜提示 1：兩頁面跳轉 App（指南 §2）

```
我是 Swing Java 開發者，已完成 Day 1，正在學 Android（Java + XML）。
請幫我完成「兩頁面跳轉 App」，套件 com.example.jumpdemo，共 4 支檔案：

1. activity_main.xml：垂直 LinearLayout、置中、一支 TextView「這是第一個畫面」、一支按鈕 btnGo「點我跳到第二畫面」
2. MainActivity.java：findViewById 綁定 btnGo，點擊後 new Intent(MainActivity.this, SecondActivity.class) 再 startActivity，用 lambda
3. activity_second.xml：一支置中 TextView「這是第二畫面」
4. SecondActivity.java：setContentView(R.layout.activity_second)

請用 lambda，並用 JFrame 的 new SecondFrame().setVisible(true) 對照說明。
```

**用戶端自我驗證**：點按鈕跳 B、按返回鍵回 A。

---

# 第 3 章　畫面間傳遞資料（putExtra / getExtra）

**3.1 A 端 putExtra（塞進行李袋）**

```java
Intent intent = new Intent(MainActivity.this, SecondActivity.class);
intent.putExtra("name", "張三");
intent.putExtra("age", 30);          // int
intent.putExtra("isStudent", true);  // boolean
startActivity(intent);
```

**3.2 B 端 getExtra（從行李袋拿出）**

```java
String name = getIntent().getStringExtra("name");
int age = getIntent().getIntExtra("age", 0);
boolean isStudent = getIntent().getBooleanExtra("isStudent", false);
```

- `Intent` 像行李袋；`putExtra` 一件件塞、`getExtra` 一件件拿（key 兩邊要相同）
- **`getIntExtra` 第二個參數是「預設值」**——沒拿到該 key 就回傳它，不崩潰

---

# ⭐ 第 3 章　完整範例：A → B 傳值 App（senddata）

畫面 A 輸入姓名/年齡傳給 B，B 顯示。套件 `com.example.senddata`。

**A 端 MainActivity**（putExtra 送出）：

```java
btnSend.setOnClickListener(v -> {
    Intent intent = new Intent(MainActivity.this, SecondActivity.class);
    intent.putExtra("name", etName.getText().toString().trim());
    String ageText = etAge.getText().toString().trim();
    intent.putExtra("age", ageText.isEmpty() ? 0 : Integer.parseInt(ageText));
    startActivity(intent);
});
```

**B 端 SecondActivity**（getExtra 讀取）：

```java
String name = getIntent().getStringExtra("name");
int age = getIntent().getIntExtra("age", -1);   // 預設 -1，拿不到時看得出來
tvShow.setText("你好，" + name + "，今年 " + age + " 歲");
```

| 執行 | 預期結果 |
|---|---|
| 張三 / 30 → 傳送 | B 顯示「你好，張三，今年 30 歲」 |
| 只填姓名、不填年齡 | B 顯示「年齡 -1」（預設值生效） |

> ⚡ 對照 Swing `showInputDialog`（同步卡住等輸入）；Android 改為「A 送出、B 接收」非同步拆兩邊。

---

# AI 動手做｜提示 2：A → B 傳值 App（指南 §3）

```
請幫我完成「A→B 傳值 App」，套件 com.example.senddata，共 4 支檔案：

1. activity_main.xml：標題「傳資料給 B」、EditText etName(姓名)、EditText etAge(inputType="number")、按鈕 btnSend「傳送並跳到 B」
2. MainActivity.java：按鈕點擊時 intent.putExtra("name", 姓名)、putExtra("age", 年齡 int)，再 startActivity
3. activity_second.xml：一支置中 TextView tvShow「尚未收到資料」
4. SecondActivity.java：用 getIntent().getStringExtra("name") 拿姓名、getIntExtra("age", -1) 拿年齡，setText 顯示「你好，xxx，今年 x 歲」

重點：getIntExtra 的第二個參數是「預設值」。請用 lambda。
```

**驗證**：只填姓名不填年齡 → B 顯示「年齡 -1」。

---

# 第 4 章　回傳結果給前一個畫面（舊寫法）

```java
// A 端：啟動並等待結果
btnPick.setOnClickListener(v -> {
    Intent intent = new Intent(MainActivity.this, SecondActivity.class);
    startActivityForResult(intent, 1001);   // 1001 = request code
});

@Override
protected void onActivityResult(int requestCode, int resultCode, Intent data) {
    super.onActivityResult(requestCode, resultCode, data);
    if (requestCode == 1001 && resultCode == RESULT_OK) {
        String result = data.getStringExtra("result");
        tvResult.setText("收到：" + result);
    }
}
```

```java
// B 端：回傳並關閉
Intent data = new Intent();
data.putExtra("result", "這是回傳的資料");
setResult(RESULT_OK, data);   // 設定結果（還沒送出）
finish();                     // 關閉 B → 系統把結果送回 A
```

- `requestCode`：分辨「是哪次要求」；`resultCode`：B 回的狀態（`RESULT_OK`）
- ⚠️ **`onActivityResult` 是方法覆寫 → 不能用 lambda**（只能 override）

---

# ⭐ 第 4 章　完整範例：A ↔ B 回傳結果（新舊寫法對照）

**新版 `registerForActivityResult`（官方推薦，lambda 回呼）**

```java
ActivityResultLauncher<Intent> lasResult = registerForActivityResult(
        new ActivityResultContracts.StartActivityForResult(),
        result -> {
            if (result.getResultCode() == RESULT_OK && result.getData() != null) {
                String value = result.getData().getStringExtra("result");
                tvResult.setText("收到（新版）：" + value);
            }
        });
```

**舊寫法**：`startActivityForResult(intent, 1001)` + `@Override onActivityResult(...)`

**B 端回傳（兩套共用）**：

```java
Intent data = new Intent();
data.putExtra("result", feedback);
setResult(RESULT_OK, data);
finish();
```

| 操作 | 預期結果 |
|---|---|
| 點「新版」→ B 輸入「Hello」→ 回傳 | A 顯示「收到（新版）：Hello」 |
| 點「舊寫法」→ B 輸入「Hi」→ 回傳 | A 顯示「收到（舊寫法）：Hi」 |

> 🔑 關鍵：新版 = Listener（單一方法介面 → **可 lambda**）；舊版 = 覆寫 Activity 方法 → **不能 lambda**。

---

# AI 動手做｜提示 3：回傳結果、新舊寫法（指南 §4）

```
請幫我完成「A↔B 回傳結果 App」，套件 com.example.resultdemo，共 4 支檔案。
要同時示範「新版 registerForActivityResult」和「舊 startActivityForResult」兩支按鈕：

1. activity_main.xml：標題、兩個按鈕 btnLaunchNew(新版) 和 btnLaunchOld(舊寫法)、結果 TextView tvResult
2. MainActivity.java：
   - 新版：ActivityResultLauncher<Intent> lasResult = registerForActivityResult(new ActivityResultContracts.StartActivityForResult(), result -> {...}，用 lambda 接結果
   - 舊版：onActivityResult 覆寫方法，檢查 requestCode == 1001 && resultCode == RESULT_OK（此方法不能用 lambda，請用 @Override）
3. activity_second.xml：標題、EditText etFeedback、按鈕 btnSendBack「回傳給 A 並關閉」
4. SecondActivity.java：空 Intent new Intent() + putExtra("result", ...) + setResult(RESULT_OK, data) + finish()

請特別講解：為什麼新版能 lambda、舊版不能（覆寫方法 vs 單一方法介面）。
```

> 這是 Day 2 最容易混淆的地方：**兩顆按鈕各跑一次**比較，再問 AI 講一次差異。

---

# 第 5 章　Intent 的其它用法（呼叫系統功能）

```java
// 撥號：只開啟撥號介面，不會真的播出
Intent dial = new Intent(Intent.ACTION_DIAL, Uri.parse("tel:0912345678"));
startActivity(dial);

// 開啟網頁：交給系統挑瀏覽器
Intent web = new Intent(Intent.ACTION_VIEW, Uri.parse("https://www.google.com"));
startActivity(web);
```

- `Intent.ACTION_DIAL` / `ACTION_VIEW`：**動作（action）**——「我想做什麼」
- `Uri.parse(...)`：把文字包成 Android URI（`tel:`、`https:`）
- 程式**不指定用哪個 App**——系統自動挑選能處理的應用程式
- ⚡ 對照 Swing 只能自己 `Desktop.open(uri)`；Android 更靈活

---

# ⭐ 第 5 章　完整範例：系統功能 App（sysints）

**佈局（activity_main.xml）**：標題「呼叫系統功能」+ `btnDial`「撥號（Dial）」+ `btnWeb`「開啟網頁（View）」，垂直置中。

**程式（MainActivity.java）**：

```java
btnDial.setOnClickListener(v -> {
    Intent dial = new Intent(Intent.ACTION_DIAL, Uri.parse("tel:0912345678"));
    startActivity(dial);
});
btnWeb.setOnClickListener(v -> {
    Intent web = new Intent(Intent.ACTION_VIEW, Uri.parse("https://www.google.com"));
    startActivity(web);
});
```

| 執行 | 預期結果 |
|---|---|
| 按「撥號（Dial）」 | 開啟系統撥號介面，號碼已帶入（不必真播出） |
| 按「開啟網頁（View）」 | 開啟瀏覽器載入 Google |

> 只需一支 Activity（呼叫其他 App），不需要第二個畫面。

---

# AI 動手做｜提示 4：系統功能 App（指南 §5）

```
請幫我完成「呼叫系統功能」App，套件 com.example.sysints，一支 Activity：
1. activity_main.xml：標題、btnDial「撥號」、btnWeb「開啟網頁」
2. MainActivity.java：
   - btnDial：new Intent(Intent.ACTION_DIAL, Uri.parse("tel:0912345678")) 再 startActivity
   - btnWeb：new Intent(Intent.ACTION_VIEW, Uri.parse("https://www.google.com")) 再 startActivity
   請用 lambda，並 import android.net.Uri。
```

> 現在你已會「跳轉 / 傳值 / 回傳 / 呼叫系統」。接著把重點轉到**列表**。

---

# 第 6 章　顯示列表：ListView + ArrayAdapter

**6.1 XML 加入 ListView**

```xml
<ListView android:id="@+id/listView"
    android:layout_width="match_parent"
    android:layout_height="match_parent" />
```

**6.2 用 ArrayAdapter 顯示文字陣列**

```java
String[] items = {"蘋果", "香蕉", "柳橙", "葡萄"};
ArrayAdapter<String> adapter = new ArrayAdapter<>(
        this, android.R.layout.simple_list_item_1, items);
listView.setAdapter(adapter);

listView.setOnItemClickListener((parent, view, position, id) ->
        Toast.makeText(this, "你選了：" + items[position], Toast.LENGTH_SHORT).show());
```

- `ListView` 只負責**顯示與捲動**；資料由 **Adapter** 管理
- `android.R.layout.simple_list_item_1`：系統內建「單行文字」樣式
- lambda 有 **4 個參數**：`parent, view, position, id`，個數與順序要跟介面一致
- ⚡ `setAdapter` ≈ `JList.setModel(...)`

---

# AI 動手做｜提示 5：學習 ListView 概念（指南 §6）

```
請用 JFrame 的角度解釋 Android 的 ListView 與 ArrayAdapter：
- ListView 對照 JList 的哪部分？
- ArrayAdapter 對照 Swing 的哪個（ListModel / ListCellRenderer）？
- setAdapter / notifyDataSetChanged 分別做什麼？
給我一支迷你範例（String 陣列 + ArrayAdapter + setOnItemClickListener 用 4 參數 lambda）。
```

> 對照 `02_Day2_Complete.md` 第 6、8 章。先把「資料 ↔ Adapter ↔ 列表」三者的關係搞懂。

---

# 第 7 章　顯示列表：RecyclerView（常用進階）

ListView 較舊、效能不佳 → 現代 App 用 **RecyclerView**（較多程式碼但彈性大、效能好）。

**6 個步驟**：

1. XML 加入 `<RecyclerView>`
2. 建立**單列佈局** `row_item.xml`
3. 建立 **ViewHolder** class
4. 建立 **Adapter** class（繼承 `RecyclerView.Adapter`）
5. 主程式設定 `setLayoutManager` + `setAdapter`
6. （選配）`ItemTouchHelper` 滑動刪除（Day 3 範例用）

> 建議：Day 2 先用 ListView 熟概念，Day 3 範例再用 RecyclerView，兩者 Model-Adapter 思維一致。

---

# AI 動手做｜提示 6：RecyclerView 六步驟（指南 §7）

```
我是 Android Java 初學者，請用 Step by Step 教我 RecyclerView 的 6 個步驟：
1. XML 放 <RecyclerView>
2. 建立單列佈局 row_item.xml
3. 建立 ViewHolder
4. 建立 Adapter（繼承 RecyclerView.Adapter）
5. 主程式 setLayoutManager(new LinearLayoutManager(this)) + setAdapter
6. （選配）ItemTouchHelper 滑動刪除

請解釋 onCreateViewHolder / onBindViewHolder / getItemCount 各自何時被呼叫，
並說明為何 onBindViewHolder 是「方法覆寫」不能用 lambda。
用一支「顯示水果清單」的最小可編譯範例示範（記得要加 recyclerview 依賴）。
```

> Day 2 先熟概念；完整 RecyclerView 實作在第 12 章顏色選擇器、Day 3 記帳 App。

---

# 第 8 章　資料容器：ArrayList（取代陣列）

```java
ArrayList<String> todoList = new ArrayList<>();
todoList.add("寫 Day2 筆記");
todoList.add("練習 Intent");

// 改動資料後 → 通知畫面重繪
adapter.notifyDataSetChanged();
```

- `ArrayList` 可動態增刪、方便與 `ArrayAdapter` 搭配，是清單 App 的主角
- **記憶口訣：「改容器 → `notifyDataSetChanged()`」**——不管新增或刪除，最後都要呼叫，畫面才會更新
- ⚡ 對照 Swing `DefaultListModel.add()` 後自動更新；Android 要**手動**呼叫

---

# ⭐ 第 8 章　完整範例：可增刪的待辦清單（arraydemo）

```java
btnAdd.setOnClickListener(v -> {
    String text = etInput.getText().toString().trim();
    if (text.isEmpty()) { Toast.makeText(this, "請先輸入文字", Toast.LENGTH_SHORT).show(); return; }
    data.add(text);
    adapter.notifyDataSetChanged();   // 通知畫面重繪
    etInput.setText("");
});

listView.setOnItemLongClickListener((parent, view, position, id) -> {
    String item = data.get(position);
    new AlertDialog.Builder(this)
            .setTitle("確認刪除")
            .setMessage("確定要刪除「" + item + "」嗎？")
            .setPositiveButton("確定", (dialog, which) -> {
                data.remove(position);
                adapter.notifyDataSetChanged();
            })
            .setNegativeButton("取消", null)
            .show();
    return true;   // 已處理長按事件
});
```

- 佈局：水平列（`EditText` 用 `0dp + weight=1` 撐滿 + 新增鈕）＋下方 `ListView`
- 關鍵三行：`data.add(...)`、`data.remove(...)`、`adapter.notifyDataSetChanged()`
- 長按刪除用到 `AlertDialog` → 就是第 9 章主題

---

# 第 9 章　Dialog：AlertDialog（取代 JOptionPane 彈窗）

```java
new AlertDialog.Builder(this)
        .setTitle("確認")
        .setMessage("確定要刪除嗎？")
        .setPositiveButton("確定", (dialog, which) -> {
            // 按確定要做的事
        })
        .setNegativeButton("取消", null)
        .show();
```

- **流式（Builder）寫法**：一行串一行「組裝」，最後 `.show()` 才彈出
- `setPositiveButton("確定", (dialog, which) -> {...})`：第二參數是 `DialogInterface.OnClickListener`（**單一方法介面 → lambda**）
- `setNegativeButton("取消", null)`：`null` = 按下直接關閉、不做任何事
- ⚡ ≈ Swing 的 `JOptionPane`

---

# AI 動手做｜提示 7：學習 AlertDialog（指南 §8）

```
請用 JFrame 的 JOptionPane 對照，教我 Android 的 AlertDialog：
- Builder 流式寫法（setTitle / setMessage / setPositiveButton / setNegativeButton / show）
- setPositiveButton 的回呼為什麼能用 lambda（DialogInterface.OnClickListener 是單一方法介面）
- setNegativeButton("取消", null) 的 null 代表甚麼
給我一個「確認刪除」的迷你範例。
```

> 現在你已備齊所有元件：跳轉、傳值、回傳、列表、彈窗。接著是三支整合範例。

---

# 第 10 章　完整範例一：待辦事項 Todo App

> 套件 `com.example.todoapp`，2 支檔案。把「ArrayList + ArrayAdapter + AlertDialog」整合成正式小專案。

**功能需求**：`EditText`+`Button` 新增；`ListView` 顯示；**點擊待辦 → AlertDialog 確認後刪除**；資料存記憶體（重開 App 會消失）。

**佈局**：上方水平列（`etTodo` 用 `0dp + weight=1` 撐滿 + `btnAdd`「新增」）＋下方 `ListView`。

**程式核心**：

```java
adapter = new ArrayAdapter<>(this, android.R.layout.simple_list_item_1, todoList);
listView.setAdapter(adapter);

btnAdd.setOnClickListener(v -> {
    String text = etTodo.getText().toString().trim();
    if (text.isEmpty()) { Toast...; return; }
    todoList.add(text);
    adapter.notifyDataSetChanged();
    etTodo.setText("");
});
```

**驗證**：新增出現、點列刪除、空白 Toast；**滑掉重開，資料消失** → Day 3 用 Room 解決。

---

# AI 動手做｜9-1 待辦事項 Todo App 提示（指南 §9-1）

```
我學到「待辦事項 Todo App」，套件 com.example.todoapp，請幫我產出 2 支檔案：

1. activity_main.xml：上方水平列（EditText etTodo 用 0dp+weight=1 + 按鈕 btnAdd「新增」），下方 ListView listView
2. MainActivity.java：
   - private final ArrayList<String> todoList；adapter = new ArrayAdapter<>(this, android.R.layout.simple_list_item_1, todoList)
   - 新增按鈕：檢查空白→todoList.add→adapter.notifyDataSetChanged→清空輸入框（lambda）
   - 點擊列：setOnItemClickListener 4 參數 lambda，用 AlertDialog 確認刪除，setPositiveButton 裡 todoList.remove + notifyDataSetChanged
請用 lambda。
```

**練習擴充**：`請幫 Todo App 加上「長按列刪除」（setOnItemLongClickListener）替代點擊刪除。`

**驗證**：新增空白會 Toast、新增會出現、點列可刪、**重開 App 資料會消失**（Day 3 解決）。

---

# 第 11 章　完整範例二：商品編輯傳值（shopapp）

> 套件 `com.example.shopapp`，4 支檔案。練習「A 開 B、B 回傳、A 顯示」的**雙向閉環**。

**閉環流程**：A `putExtra` 帶初值 → B `getStringExtra` 初始化欄位 → B 改完 `putExtra` → `setResult` + `finish` → A 的 `result` 回呼更新顯示。

**A 端（新版 Result API）**：

```java
ActivityResultLauncher<Intent> resultLauncher = registerForActivityResult(
        new ActivityResultContracts.StartActivityForResult(),
        result -> {
            if (result.getResultCode() == RESULT_OK && result.getData() != null) {
                goodsName = result.getData().getStringExtra("name");
                goodsPrice = result.getData().getStringExtra("price");
                tvInfo.setText("商品：" + goodsName + " / 價格：" + goodsPrice);
            }
        });

private void openEdit() {
    Intent intent = new Intent(MainActivity.this, EditActivity.class);
    intent.putExtra("name", goodsName);      // 帶初值過去
    intent.putExtra("price", goodsPrice);
    resultLauncher.launch(intent);
}
```

**B 端**：`getStringExtra("name"/"price")` 初始化（`if (x != null)`）；儲存時空白檢查 → 空 `Intent` + `putExtra` → `setResult(RESULT_OK, data)` → `finish()`。

| 寫法 | 適用 | 備註 |
|---|---|---|
| `registerForActivityResult` | **新版推薦** | lambda `result -> {...}` |
| 舊 `onActivityResult` | 較舊專案 | 方法覆寫，**不能** lambda |

---

# AI 動手做｜9-2 商品編輯傳值提示（指南 §9-2）

```
我學到「商品編輯傳值」，套件 com.example.shopapp，請幫我產出 4 支檔案：

1. activity_main.xml：TextView tvInfo「商品：手機 / 價格：9999」、按鈕 btnEdit「編輯商品」
2. MainActivity.java：
   - 欄位 goodsName="手機"、goodsPrice="9999"
   - 用新版 Result API：ActivityResultLauncher resultLauncher 接收 EditActivity 回傳的 name、price，更新 tvInfo
   - openEdit()：intent.putExtra("name", goodsName)、putExtra("price", goodsPrice)，resultLauncher.launch
3. activity_edit.xml：EditText etName(商品名稱)、etPrice(inputType="number")、按鈕 btnSave「儲存並返回」
4. EditActivity.java：
   - getIntent().getStringExtra("name"/"price") 初始化欄位（若非 null）
   - 按儲存：檢查空白→new Intent() 空袋 putExtra 回傳→setResult(RESULT_OK, data)→finish()
請用 lambda，並說明「A→B 帶初值、B→A 回修改」的完整閉環。
```

**驗證**：A 顯示「手機/9999」→ 編輯改「平板/12900」→ A 更新。

---

# 第 12 章　完整範例三：顏色選擇器（RecyclerView + 回傳）

> 套件 `com.example.colorpick`，需加 `androidx.recyclerview:recyclerview` 依賴（改 `build.gradle` 後 Sync Now）。

**RecyclerView 三要素分工**：XML 只放「容器」；`row_color.xml` 決定「每列長相」；Java 的 `LayoutManager` 決定「排放方向」。

**重點程式**：

```java
// ColorData：資料模型（name + hex，final 唯讀）
// OnColorClick：單一方法介面 → functional interface，可用 lambda
public class ColorAdapter extends RecyclerView.Adapter<ColorAdapter.ColorViewHolder> {
    // onCreateViewHolder：建立單列模板（inflate row_color）
    // onBindViewHolder：把 colors.get(position) 綁到該列（可 lambda 的 itemView 點擊）
    @Override public int getItemCount() { return colors.size(); }
    static class ColorViewHolder extends RecyclerView.ViewHolder { ... }
}

// ColorListActivity：setLayoutManager(new LinearLayoutManager(this)) + setAdapter
ColorAdapter adapter = new ColorAdapter(colors, color -> {
    Intent data = new Intent();
    data.putExtra("name", color.name);
    data.putExtra("hex", color.hex);
    setResult(RESULT_OK, data);   // 點某色 → 回傳並關閉
    finish();
});
```

**A 端**：`resultLauncher` 收到 `name`/`hex` → `colorBlock.setBackgroundColor(Color.parseColor(hex))` + 更新文字。

**驗證**：A 灰塊「尚未選擇」→ 選「紅色」→ 色塊變紅、文字「紅色 (#FF0000)」。

---

# AI 動手做｜9-3 顏色選擇器提示（指南 §9-3）

```
我學到「顏色選擇器」，套件 com.example.colorpick，需要 recyclerview 依賴，請幫我產出 5 支 Java + 3 個 layout：

1. build.gradle 依賴：androidx.recyclerview:recyclerview
2. activity_main.xml：標籤「目前選色：」、View colorBlock(80dp 背景 #888888)、TextView tvName「尚未選擇」、按鈕 btnPick「選擇顏色」
3. row_color.xml：水平 LinearLayout，View swatch(40dp) + TextView tvColorName
4. ColorData.java：public final String name / hex，建構子填值
5. ColorAdapter.java：繼承 RecyclerView.Adapter
   - 自訂 interface OnColorClick { void onColorClick(ColorData color); }（單一方法→functional interface）
   - onCreateViewHolder inflate row_color、onBindViewHolder setText + setBackgroundColor + itemView.setOnClickListener(lambda)、getItemCount
   - 內部 static ColorViewHolder
6. activity_color_list.xml：只放一個 RecyclerView
7. MainActivity.java：新版 Result API 接收 name/hex 更新色塊與文字
8. ColorListActivity.java：準備 6 個 ColorData、setLayoutManager、new ColorAdapter(colors, color -> {...}) lambda 回傳 setResult + finish
```

**驗證**：A 灰塊「尚未選擇」→ 選「紅色」→ 回 A 色塊變紅、文字「紅色 (#FF0000)」。

---

# AI 動手做｜遇到錯誤，讓 AI 幫你除錯（指南 §10）

| 常見錯誤 | 你可以這樣問 |
|---|---|
| 跳到 B 黑屏 / 崩潰 | 「SecondActivity 沒出現，可能是 AndroidManifest 沒註冊嗎？請說明並教我檢查」 |
| `onActivityResult` 編譯錯誤 | 「onActivityResult 不能寫成 lambda，請幫我改回正確的 @Override 寫法」 |
| `getIntExtra` 拿不到值 | 「B 端 getIntExtra('age') 拿到 0，但 A 有 putExtra，為什麼？預設值是甚麼意思？」 |
| RecyclerView 空白 | 「Adapter 的 getItemCount 回傳多少？幫我檢查 onCreateViewHolder / onBindViewHolder」 |
| 找不到 RecyclerView import | 「我沒加 recyclerview 依賴，請告訴我 build.gradle 要加甚麼並呼叫 Sync」 |

> 貼上**完整錯誤訊息**（含 Logcat）與**你的程式碼**，AI 才能精準除錯。

---

# 第 13 章　自我測驗（先寫再對答案）

1. `startActivity(intent)` 和 `startActivityForResult(intent, code)` 差別在哪？
2. `getIntExtra("age", 0)` 的第二個參數 `0` 是什麼意思？
3. `onActivityResult` 的 `requestCode` 與 `resultCode` 分別代表什麼？
4. Adapter 在 ListView 中扮演什麼角色？
5. 為什麼用 RecyclerView 取代 ListView？
6. `onActivityResult(...)` 為什麼「不能」寫成 lambda？那 `setOnClickListener(v -> ...)` 為什麼可以？

---

# 測驗解答

| # | 解答 |
|---|---|
| 1 | `startActivity`：fire-and-forget 不等待；`startActivityForResult`：等待回傳（新版用 `registerForActivityResult`） |
| 2 | **預設值**——找不到該 key 就回傳 `0`，避免 null 崩潰 |
| 3 | `requestCode`：發送端自己給的辨識碼（如 1001）；`resultCode`：接收端 `setResult(RESULT_OK, ...)` 回的狀態 |
| 4 | 資料與 UI 的橋樑——把資料轉成列 View（≈ Swing ListModel + ListCellRenderer） |
| 5 | 有 ViewHolder 回收 + LayoutManager，捲動效能更好、支援多種佈局與動畫；官方建議 |
| 6 | `onActivityResult` 是 Activity **已定義的方法**，只能 `@Override` 覆寫；lambda 只能實作**未實作的單一抽象方法介面**（`OnClickListener` 符合） |

> 判斷準則：**要覆寫既有方法 → 只能寫方法；要實作單一方法的介面 → 可用 lambda**。

---

# AI 動手做｜提示寫作重點回顧 + 複習流程（指南 §11）

| 重點 | 做法 |
|---|---|
| 多 Activity 要講清楚 | 每個畫面的 XML 和 Java 分開描述、指定檔案名 |
| 套件名要指定 | `com.example.resultdemo` 等，避免 `<activity>` 註冊對不上 |
| 指定新版 / 舊版 | 明確說要用 `registerForActivityResult` 還是 `onActivityResult` |
| lambda 界線 | 明確要求「只有單一方法介面用 lambda，覆寫方法用 @Override」 |
| 提醒依賴 | 用到 RecyclerView 要提醒 AI 附上 build.gradle 依賴 |

**複習流程**：自己實作 → 用提示讓 AI 產生同一支 → 比對差異（新舊/API、lambda vs anonymous）→ 故意灌錯考 AI → 用擴充提示加功能。

> 下一篇：Day 3（Room / SQLite / SharedPreferences 持久化 + 記帳 App 總成果）。

---

# 本日小結

今天你完成了：

- `Intent` 啟動新 Activity、`putExtra`/`getExtra` 畫面間傳值
- 回傳結果給前一畫面（**新版 Result API + 舊 startActivityForResult 對照**）
- 系統功能 Intent（撥號、開網頁）
- `ListView` + `ArrayAdapter`、`RecyclerView` + ViewHolder + Adapter
- `AlertDialog` 彈窗
- 四支小範例：**兩頁面跳轉**、**A→B 傳值**、**A↔B 回傳**、**系統功能**
- 三支整合範例：**Todo App**（第 10 章）、**商品編輯**（第 11 章）、**顏色選擇器**（第 12 章）

**明天（Day 3）**：用 SharedPreferences、檔案、SQLite/Room 把資料「永久存起來」，完成記帳 App。

> 延伸閱讀：`Appendix_B_Lambda.md`（Lambda 對照）、`Appendix_G_Lifecycle.md`（生命週期）、`Appendix_H_Swing_vs_Android.md`。