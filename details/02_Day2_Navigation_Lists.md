# Day 2 — 頁面跳轉與列表：多畫面 App

> 目標：用 Intent 跳轉多個畫面、畫面間傳資料、用 ListView/RecyclerView 顯示資料
> 時間：約 6–8 小時
> 完成實作：**待辦事項清單 App（暫存於記憶體）**
> ⚡ = 與 JFrame 對照

---

## 1. 認識 Activity（多個畫面）

一個 Activity = 一個畫面。要建第二個畫面：

1. 在套件資料夾按右鍵 → **New → Activity → Empty Views Activity**
2. 命名 `SecondActivity` → 會自動產生 `SecondActivity.java` + `activity_second.xml`

> ⚡ **對照**：`SecondActivity` 就等於你另外設計的第二個 `JFrame`。

### 1.1 AndroidManifest.xml 必須註冊 Activity

```xml
<activity android:name=".SecondActivity" />
```

> Android Studio 建立 Activity 時會**自動註冊**到 `AndroidManifest.xml`，但你自己手動建 class 時別忘了註冊，否則會跳錯。

---

## 2. Intent：啟動新的 Activity

```java
// 在 MainActivity.java 中
Button btnGo = findViewById(R.id.btnGo);
btnGo.setOnClickListener(v -> {
    Intent intent = new Intent(MainActivity.this, SecondActivity.class);
    startActivity(intent);   // 啟動並跳轉
});
```

### 2.1 為什麼用 `MainActivity.this`？

因為在匿名/button 回呼中，`this` 可能不是 Activity。用 `MainActivity.this` 明確指定。

> ⚡ **對照**：JFrame 是 `new SecondFrame().setVisible(true)`；Android 是 `startActivity(intent)`。

**Lambda 對照**：上面 `v -> { ... }` 的完整面貌（如果你還不習慣 lambda）是：

```java
// 等價的傳統寫法
btnGo.setOnClickListener(new View.OnClickListener() {
    @Override
    public void onClick(View v) {
        Intent intent = new Intent(MainActivity.this, SecondActivity.class);
        startActivity(intent);
    }
});
```

兩者完全等價。lambda 只是把「單一方法的匿名類別」縮寫：`(參數) -> { 方法體 }`，參數型別自動推斷。

---

## 3. 畫面間傳遞資料（取代 showInputDialog 的回傳值）

### 3.1 傳資料過去（putExtra）

```java
// MainActivity 想傳名字給 SecondActivity
Intent intent = new Intent(MainActivity.this, SecondActivity.class);
intent.putExtra("name", "張三");
intent.putExtra("age", 30);          // int
intent.putExtra("isStudent", true);  // boolean
startActivity(intent);
```

### 3.2 在 SecondActivity 接收（getExtra）

```java
// SecondActivity.java 的 onCreate 中
String name = getIntent().getStringExtra("name");
int age = getIntent().getIntExtra("age", 0);
boolean isStudent = getIntent().getBooleanExtra("isStudent", false);

TextView tvShow = findViewById(R.id.tvShow);
tvShow.setText("你好，" + name + "，今年 " + age + " 歲");
```

> 注意 `getIntExtra` 第二個參數是**預設值**（若沒拿到該 key 時回傳）。

---

## 4. 回傳結果給前一個畫面（startActivityForResult）

這是畫面間「溝通回應」的重點，也比 JFrame 的 modal dialog 更明確。

```java
// MainActivity：啟動並等待結果
btnPick.setOnClickListener(v -> {
    Intent intent = new Intent(MainActivity.this, SecondActivity.class);
    startActivityForResult(intent, 1001);   // 1001 是 request code
});

// 覆寫接收結果
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
// SecondActivity：把結果回傳並關閉
Button btnSendBack = findViewById(R.id.btnSendBack);
btnSendBack.setOnClickListener(v -> {
    Intent data = new Intent();
    data.putExtra("result", "這是回傳的資料");
    setResult(RESULT_OK, data);   // 設定回傳結果
    finish();                     // 關閉目前 Activity
});
```

**Lambda 對照**：
- `btnPick` / `btnSendBack` 的 `setOnClickListener(v -> {...})` 一樣可以寫回 anonymous class（見 2.1）。
- 但 `onActivityResult(...)` 是 **Activity 生命週期的「方法覆寫 (override)」**，不是 listener 介面，**不能**用 lambda 簡寫。lambda 只能用在「單一抽象方法的介面/抽象類別」，不能用來覆寫「已定義好的方法」。

> ⚡ **對照**：類似 JOptionPane.showInputDialog 回傳使用者輸入，但 Android 拆成「發送端」與「接收端」兩邊，更靈活。

---

## 5. Intent 的其它用法

```java
// 撥號
Intent dial = new Intent(Intent.ACTION_DIAL, Uri.parse("tel:0912345678"));
startActivity(dial);

// 開啟網頁
Intent web = new Intent(Intent.ACTION_VIEW, Uri.parse("https://www.google.com"));
startActivity(web);
```

這表示 `Intent` 不只是跳 Activity，也能呼叫系統功能。

---

## 6. 顯示列表：ListView（入門）

> ⚡ **對照**：ListView 類似 JList / JComboBox 的選項清單，但 Android 用 **Adapter** 串接資料與畫面。

### 6.1 在 XML 加入 ListView
```xml
<ListView
    android:id="@+id/listView"
    android:layout_width="match_parent"
    android:layout_height="match_parent" />
```

### 6.2 用 ArrayAdapter 顯示文字陣列

```java
ListView listView = findViewById(R.id.listView);

String[] items = {"蘋果", "香蕉", "柳橙", "葡萄"};

ArrayAdapter<String> adapter = new ArrayAdapter<>(
        this,
        android.R.layout.simple_list_item_1,  // 內建單行樣式
        items);

listView.setAdapter(adapter);

// 點擊事件
listView.setOnItemClickListener((parent, view, position, id) -> {
    String selected = items[position];
    Toast.makeText(this, "你選了：" + selected, Toast.LENGTH_SHORT).show();
});
```

**Lambda 對照**：這裡的 lambda 有 **4 個參數**，與 `onItemClick(AdapterView<?> parent, View view, int position, long id)` 一一對應：

```java
// 等價的傳統寫法
listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
    @Override
    public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
        String selected = items[position];
        Toast.makeText(MainActivity.this, "你選了：" + selected, Toast.LENGTH_SHORT).show();
    }
});

// lambda 版本：參數型別可省略，位置對應不變
// (parent, view, position, id) -> { ... }
// 用不到的參數可用底線風格省略，例如只留 (parent, view, position, id) 中需要的：
listView.setOnItemClickListener((parent, view, position, id) ->
        Toast.makeText(this, "你選了：" + items[position], Toast.LENGTH_SHORT).show());
```

> 重點：**參數個數與順序必須跟介面方法一致**，只是型別（`AdapterView<?>`、`View`、`int`、`long`）可以省略不寫。

### 6.3 Adapter 是什麼？

`Adapter` 是把「資料」轉換成「畫面 View」的橋樑。
- **資料**：陣列 / List / Cursor
- **Adapter**：決定每一列長什麼樣
- **ListView**：負責顯示與捲動

> ⚡ 概念上很像 Swing 的 `ListModel` + `ListCellRenderer` 分離。

---

## 7. 顯示列表：RecyclerView（常用進階）

ListView 較舊、效能不佳。現代 App 用 **RecyclerView**（需要 ViewHolder，較多程式碼但彈性大）。

RecyclerView 步驟較多（6 步），稍後在範例中完整示範：

1. XML 加入 `<RecyclerView>`
2. 建立**單列佈局** `row_item.xml`
3. 建立 **ViewHolder** class
4. 建立 **Adapter** class（繼承 `RecyclerView.Adapter`)
5. 主程式設定 LayoutManager + setAdapter
6. **ItemTouchHelper** 可做滑動刪除（Day 3 範例用）

> 建議：Day 2 先用 ListView 熟概念，Day 3 範例再用 RecyclerView，兩者 Model-Adapter 思維一致。

---

## 8. 資料容器：ArrayList（取代陣列）

```java
ArrayList<String> todoList = new ArrayList<>();
todoList.add("寫 Day2 筆記");
todoList.add("練習 Intent");
```

搭配 `ArrayAdapter` + `notifyDataSetChanged()` 更新畫面：

```java
ArrayAdapter<String> adapter;
ArrayList<String> data = new ArrayList<>();

adapter = new ArrayAdapter<>(this, android.R.layout.simple_list_item_1, data);
listView.setAdapter(adapter);

// 新增一筆
data.add("新待辦");
adapter.notifyDataSetChanged();   // 通知畫面重新繪製
```

> ⚡ 這就像 Swing 的 `DefaultListModel.add()` 後自動更新，但 Android 要手動呼叫 `notifyDataSetChanged()`。

---

## 9. Dialog：AlertDialog（取代 JOptionPane 彈窗）

```java
new AlertDialog.Builder(this)
        .setTitle("確認")
        .setMessage("確定要刪除嗎？")
        .setPositiveButton("確定", (dialog, which) -> {
            // 按確定時
        })
        .setNegativeButton("取消", null)
        .show();
```

**Lambda 對照**：`setPositiveButton` 的第二個參數是 `DialogInterface.OnClickListener`（單一方法 `onClick(DialogInterface dialog, int which)`），所以可用 lambda：

```java
// 等價的傳統寫法
new AlertDialog.Builder(this)
        .setTitle("確認")
        .setMessage("確定要刪除嗎？")
        .setPositiveButton("確定", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                // 按確定時
            }
        })
        .setNegativeButton("取消", null)   // null = 按下後直接關閉，不做任何事
        .show();

// lambda 版本：兩個參數 (dialog, which)，不用的參數名稱可自行省略在意義
.setPositiveButton("確定", (d, w) -> /* 按確定時 */)
```

---

## 10. 小實作：待辦事項清單 App

功能需求：
- 一個 `EditText` + `Button` 新增待辦
- 一個 `ListView` 顯示清單
- 點擊待辦項目 → `AlertDialog` 確認後刪除
- 資料存在 `ArrayList`（記憶體，**重開 App 會消失**）
- Day 3 將改用資料庫持久化，讓重開 App 後資料還在

> 完整可編譯的待辦清單雙檔 → `07_Complete_Guide.md` 的 **Part 2**。

### Day 2 完整範例清單（每一步都可直接編譯執行）

| 範例 | 檔案 | 重點技能 |
|---|---|---|
| 待辦清單 App | `07_Complete_Guide.md` (Part 2) | ListView + ArrayAdapter、點列刪除 |
| 商品編輯傳值 | `12_Day2_ProductEdit.md` | 雙 Activity、Intent 跳轉、A→B→A 雙向傳值 |
| 顏色選擇器 | `13_Day2_ColorPicker.md` | RecyclerView + Adapter、Intent 回傳結果、lambda |

> 一起做：先做待辦清單（各 ListView），再做商品編輯傳值（練 Intent+傳值），最後做顏色選擇器（把列表+跳轉+回傳整合起來）。

---

## 11. 自我測驗

1. `startActivity(intent)` 和 `startActivityForResult(intent, code)` 差別在哪？
2. `getIntExtra("age", 0)` 的第二個參數 `0` 是什麼意思？
3. `onActivityResult` 的 `requestCode` 與 `resultCode` 分別代表什麼？
4. Adapter 在 ListView 中扮演什麼角色？
5. 為什麼用 RecyclerView 取代 ListView？
6. `onActivityResult(...)` 為什麼「不能」寫成 lambda？那 `setOnClickListener(v -> ...)` 為什麼可以？

（解答在 `06_Quiz_Answers.md`）

---

下一份文件 → [Day 3：資料持久化](03_Day3_Persistence.md)
