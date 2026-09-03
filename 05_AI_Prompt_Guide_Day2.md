# Day 2 搭配 AI 的提示互動指南

> 這份文件教你「如何把我（AI）當成工具，產生 `02_Day2_Complete.md` 裡每一段程式碼」。
> 使用前提：你已完成 Day 1（會 findViewById、lambda、Toast、Activity 基本概念）。
> 核心心法同 Day 1：**你決定需求，AI 寫程式，但你要看懂、能改、能驗證**。

---

## 目錄

- [0. 與 AI 互動提醒](#0-與-ai-互動提醒)
- [1. 建立第二個 Activity](#1-建立第二個-activity)
- [2. Intent 跳轉](#2-intent-跳轉)
- [3. 畫面間傳值 putExtra / getExtra](#3-畫面間傳值)
- [4. 回傳結果（新版 Result API vs 舊寫法）](#4-回傳結果)
- [5. 系統功能 Intent](#5-系統功能-intent)
- [6. ListView + ArrayAdapter](#6-listview--arrayadapter)
- [7. RecyclerView + Adapter](#7-recyclerview--adapter)
- [8. AlertDialog](#8-alertdialog)
- [9. 三個完整範例的提示](#9-三個完整範例的提示)
  - [9-1 待辦事項 Todo App](#9-1-待辦事項-todo-app)
  - [9-2 商品編輯傳值](#9-2-商品編輯傳值)
  - [9-3 顏色選擇器（RecyclerView）](#9-3-顏色選擇器)
- [10. 讓 AI 幫你除錯](#10-讓-ai-幫你除錯)
- [11. 提示寫作重點回顧（Day 2）](#11-提示寫作重點回顧)

---

## 0. 與 AI 互動提醒

| 提醒 | 說明 |
|---|---|
| **背後的陷阱** | 新版 `registerForActivityResult` 用 lambda 回呼；舊 `onActivityResult` 是**方法覆寫，不能用 lambda** |
| **多檔案** | 有的範例要 4 支檔（2 XML + 2 Java），一次跟 AI 要完整、才不會對不上 |
| **給套件名** | 不同範例套件名不同，務必指定，避免 id 或 class 對不上 |
| **驗證每一支** | 每個範例照貼後 Run 一次，確認跳轉、傳值、列表都正常 |

> 橘色 `[ ... ]` 是你要自己填的部分；凡是我給的範例提示都可直接複製。

---

## 1. 建立第二個 Activity

建立過程**通常不需要 AI**：右鍵套件 → **New → Activity → Empty Views Activity**，名稱 `SecondActivity`。
Android Studio 會自動產生 `SecondActivity.java` + `activity_second.xml`，並幫你註冊到 `AndroidManifest.xml`。

但你可以用 AI 確認「為什麼要註冊、忘了會怎樣」：

**提示**
```
我用 Android Studio 建立了 SecondActivity，但它不小心沒被註冊到 AndroidManifest.xml，
請用 JFrame 的角度跟我解釋：1) AndroidManifest.xml 是甚麼？2) 沒註冊會發生什麼錯誤？
3) 怎麼手動補上 <activity android:name=".SecondActivity" />？
```

---

## 2. Intent 跳轉

**提示 1：產生「兩頁面跳轉 App」完整範例**（對應 Day2 第 2 章）
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

## 3. 畫面間傳值

**提示 2：產生「A → B 傳值 App」完整範例**（對應 Day2 第 3 章）
```
請幫我完成「A→B 傳值 App」，套件 com.example.senddata，共 4 支檔案：

1. activity_main.xml：標題「傳資料給 B」、EditText etName(姓名)、EditText etAge(inputType="number")、按鈕 btnSend「傳送並跳到 B」
2. MainActivity.java：按鈕點擊時 intent.putExtra("name", 姓名)、putExtra("age", 年齡 int)，再 startActivity
3. activity_second.xml：一支置中 TextView tvShow「尚未收到資料」
4. SecondActivity.java：用 getIntent().getStringExtra("name") 拿姓名、getIntExtra("age", -1) 拿年齡，setText 顯示「你好，xxx，今年 x 歲」

重點：getIntExtra 的第二個參數是「預設值」。請用 lambda。
```

**用戶端自我驗證**：只填姓名不填年齡 → B 顯示「年齡 -1」（預設值生效）。

---

## 4. 回傳結果

**提示 3：產生「A ↔ B 回傳結果 App」，同時示範新舊寫法**（對應 Day2 第 4 章）
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

> 這是 Day 2 最容易混淆的地方，拿到程式後請**同時跑兩顆按鈕**比較，並問 AI 再講一次差異。

---

## 5. 系統功能 Intent

**提示 4：產生「系統功能 App」**（對應 Day2 第 5 章）
```
請幫我完成「呼叫系統功能」App，套件 com.example.sysints，一支 Activity：
1. activity_main.xml：標題、btnDial「撥號」、btnWeb「開啟網頁」
2. MainActivity.java：
   - btnDial：new Intent(Intent.ACTION_DIAL, Uri.parse("tel:0912345678")) 再 startActivity
   - btnWeb：new Intent(Intent.ACTION_VIEW, Uri.parse("https://www.google.com")) 再 startActivity
   請用 lambda，並 import android.net.Uri。
```

---

## 6. ListView + ArrayAdapter

**提示 5：學習 ListView 概念**
```
請用 JFrame 的角度解釋 Android 的 ListView 與 ArrayAdapter：
- ListView 對照 JList 的哪部分？
- ArrayAdapter 對照 Swing 的哪個（ListModel / ListCellRenderer）？
- setAdapter / notifyDataSetChanged 分別做什麼？
給我一支迷你範例（String 陣列 + ArrayAdapter + setOnItemClickListener 用 4 參數 lambda）。
```

> 對照 `02_Day2_Complete.md` 第 6、8 章。

---

## 7. RecyclerView + Adapter

**提示 6：學習 / 產生 RecyclerView 六步驟**
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

> Day 2 建議：先學會 ListView 熟概念，再到 Day 3 用 RecyclerView 實作。

---

## 8. AlertDialog

**提示 7：學習 AlertDialog**
```
請用 JFrame 的 JOptionPane 對照，教我 Android 的 AlertDialog：
- Builder 流式寫法（setTitle / setMessage / setPositiveButton / setNegativeButton / show）
- setPositiveButton 的回呼為什麼能用 lambda（DialogInterface.OnClickListener 是單一方法介面）
- setNegativeButton("取消", null) 的 null 代表甚麼
給我一個「確認刪除」的迷你範例。
```

---

## 9. 三個完整範例的提示

每個範例都是「你給需求 → AI 產出完整檔案 → 你照貼 → 驗證」。

---

### 9-1 待辦事項 Todo App

**需求提示**（對應 Day2 第 10 章，`com.example.todoapp`）
```
我學到「待辦事項 Todo App」，套件 com.example.todoapp，請幫我產出 2 支檔案：

1. activity_main.xml：上方水平列（EditText etTodo 用 0dp+weight=1 + 按鈕 btnAdd「新增」），下方 ListView listView
2. MainActivity.java：
   - private final ArrayList<String> todoList；adapter = new ArrayAdapter<>(this, android.R.layout.simple_list_item_1, todoList)
   - 新增按鈕：檢查空白→todoList.add→adapter.notifyDataSetChanged→清空輸入框（lambda）
   - 點擊列：setOnItemClickListener 4 參數 lambda，用 AlertDialog 確認刪除，setPositiveButton 裡 todoList.remove + notifyDataSetChanged
請用 lambda。
```

**練習擴充提示**
```
請幫 Todo App 加上「長按列刪除」（setOnItemLongClickListener）替代點擊刪除。
```

**驗證**：新增空白會 Toast、新增會出現、點列可刪、**重開 App 資料會消失**（因為還沒做 Room，Day 3 解決）。

---

### 9-2 商品編輯傳值

**需求提示**（對應 Day2 第 11 章，`com.example.shopapp`）
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

**驗證**：A 顯示「商品：手機/價格：9999」→ 編輯改成「平板/12900」→ A 更新。

---

### 9-3 顏色選擇器（RecyclerView + 回傳）

**需求提示**（對應 Day2 第 12 章，`com.example.colorpick`）
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
6. activity_color_list.xml：只放一個 androidx.recyclerview.widget.RecyclerView
7. MainActivity.java：新版 Result API 接收 name/hex 更新色塊與文字
8. ColorListActivity.java：準備 6 個 ColorData、setLayoutManager、new ColorAdapter(colors, color -> {...}) lambda 回傳 setResult + finish
```

**驗證**：A 灰塊「尚未選擇」→ 選「紅色」→ 回到 A 色塊變紅、文字「紅色 (#FF0000)」。

---

## 10. 讓 AI 幫你除錯

Day 2 常見錯誤與你的提問方式：

| 常見錯誤 | 你可以這樣問 |
|---|---|
| 跳到 B 卻黑屏 / 崩潰 | 「我以為跳轉成功，但 SecondActivity 沒出現，可能是 AndroidManifest 沒註冊嗎？請說明並教我檢查」 |
| `onActivityResult` 編譯錯誤 | 「onActivityResult 好像不能寫成 lambda，請幫我改回正確的 @Override 寫法」 |
| `getIntExtra` 拿不到值 | 「我在 B 端 getIntExtra('age') 拿到 0，但 A 明明有 putExtra 了，為什麼？預設值是甚麼意思？」 |
| RecyclerView 空白 | 「我的 RecyclerView 跑起來是空的，Adapter 的 getItemCount 回傳多少？幫我檢查 onCreateViewHolder / onBindViewHolder」 |
| 找不到 RecyclerView import | 「我沒加 recyclerview 依賴，import 不過，請告訴我 build.gradle 要加甚麼並呼叫 Sync」 |

> 貼上**完整錯誤訊息**（含 Logcat）與**你的程式碼**，AI 才能精準除錯。

---

## 11. 提示寫作重點回顧（Day 2）

| 重點 | 做法 |
|---|---|
| **多 Activity 要講清楚** | 每個畫面的 XML 和 Java 分開描述，指定檔案名 |
| **套件名要指定** | `com.example.resultdemo` 等，避免 `<activity>` 註冊對不上 |
| **指定新版 / 舊版** | 明確說要用 `registerForActivityResult` 還是 `onActivityResult` |
| **lambda 界線** | 明確要求「只有單一方法介面用 lambda，覆寫方法用 @Override」 |
| **提醒依賴** | 用到 RecyclerView 要提醒 AI 附上 build.gradle 依賴 |

---

## 建議複習流程（Day 2）

1. **先自己照教材實作**（不看 AI）
2. **再用上面提示讓 AI 產生同一支**
3. **比對差異**（尤其「新版 vs 舊寫法」「lambda vs anonymous class」）
4. **故意灌錯誤**看看 AI 能不能抓（例如叫它把 onActivityResult 寫成 lambda，考它）
5. **用練習擴充提示加功能**驗證你真的懂 Intent 與列表

> 下一篇：`06_AI_Prompt_Guide_Day3.md`（Room / SQLite / SharedPreferences 持久化 + 記帳 App 總成果）。
