# Day 1 搭配 AI 的提示互動指南

> 這份文件教你「如何把我（AI）當成工具，產生 `01_Day1_Complete.md` 裡每一段程式碼」。
> 使用方法：把下方每個「提示範例」複製貼給 AI，就能得到對應的 Android 程式碼。
> 核心心法：**你決定要做什麼（需求），AI 幫你寫「怎麼做」（程式碼）**，但你要能「看懂、改、驗證」AI 給的程式碼。

---

## 目錄

- [0. 與 AI 互動的基本原則](#0-與-ai-互動的基本原則)
- [1. 環境建置（不需要 AI）](#1-環境建置)
- [2. 建立專案與專案結構](#2-建立第一個專案)
- [3. 第一個畫面 XML 佈局](#3-第一個畫面-xml-佈局)
- [4. 綁定元件與事件](#4-綁定元件與事件)
- [5. Toast 與 Log](#5-toast-與-log)
- [6. 四個完整範例（核心）](#6-四個完整範例核心)
  - [6-1 BMI 計算機](#6-1-bmi-計算機)
  - [6-2 溫度轉換器](#6-2-溫度轉換器)
  - [6-3 登入表單](#6-3-登入表單)
  - [6-4 常用 View 互動展示](#6-4-常用-view-互動展示)
- [7. 讓 AI 幫你除錯](#7-讓-ai-幫你除錯)
- [8. 讓 AI 幫你「擴充」與「解釋」](#8-讓-ai-幫你擴充與解釋)
- [9. 提示寫作五大技巧](#9-提示寫作五大技巧)

---

## 0. 與 AI 互動的基本原則

| 原則 | 說明 |
|---|---|
| **講清楚背景** | 開頭就說「我是 Java 開發者，熟悉 Swing，正在學 Android (Java + XML)」 |
| **指定檔案** | 「請給 `activity_main.xml`」或「請給 `MainActivity.java`」，AI 才知道要給哪個格式 |
| **指定套件名** | 「套件名用 `com.example.bmicalc`」 |
| **明確需求** | 列出畫面有哪些元件、按鈕按下去要做什麼 |
| **要求關鍵字** | 需要時補上「用 lambda」「用 `findViewById`」「不阻塞 UI」等 |
| **驗證後再問下一步** | 拿到程式碼 → 照貼跑一次 → 有問題再貼錯誤訊息給 AI |

> 凡是我給的範例提示，都可直接複製使用；橘色 `[ ... ]` 是你要自己填的部分。

---

## 1. 環境建置

這部分**不需要 AI**，直接看 `01_Day1_Complete.md` 第 1、2 章做：
1. 安裝 Android Studio + 建立模擬器（AVD）
2. File → New → New Project → **Empty Views Activity**，Language 選 **Java**

之後每個範例都回到「**New Project**」或「**複製既有專案**」建立，再覆蓋 XML 與 Java。

---

## 2. 建立第一個專案

建立空的 Java 專案後，AI 可以幫你產出「Hello World 來源物件」。

**提示 1：產生第一個畫面**
```
我是 Java 開發者，熟悉 Swing/JFrame，正在用 Android Studio 學 Android（Empty Views Activity，Java，XML 佈局）。
請幫我產生「顯示輸入文字」的第一個 App：
1. activity_main.xml：一個 TextView 標題、一個 EditText、一個 Button、一個 TextView 結果
2. MainActivity.java：用 findViewById 綁定，點擊按鈕後用 lambda 把 EditText 的文字顯示到結果 TextView，並用 Toast 提示
套件名用 com.example.myfirstapp
請用 lambda 寫法
```

---

## 3. 第一個畫面 XML 佈局

若你想「只」要佈局檔（練習自己寫 Java）：

**提示 2：只產生 XML**
```
請幫我寫一個 Android XML 佈局（activity_main.xml）：
- LinearLayout，垂直排列，padding 24dp
- 一個標題 TextView「我的第一個 App」24sp 粗體
- 一個 EditText（id=etInput），hint「請輸入文字」，match_parent
- 一個 Button（id=btnShow）「顯示輸入」，match_parent
- 一個 TextView（id=tvResult）「結果：」18sp
請用 XML code block 輸出，不用解說
```

**你可以反過來用 AI 學習**：直接問
```
請用 JFrame 的角度跟我解釋 LinearLayout 的 match_parent 和 wrap_content 各是什麼？
```

---

## 4. 綁定元件與事件

**提示 3：專講 lambda vs anonymous class**
```
Android 的 View.OnClickListener 何時可以用 lambda？何時不能用？
請用 JFrame 的 addActionListener 對照，分別給我 lambda 和 anonymous class 兩種寫法。
順便說明 onActivityResult、OnItemSelectedListener 為何不能用 lambda。
```

> 這正是 `Appendix_B_Lambda.md` 的內容——用 AI 重問一遍當複習。

---

## 5. Toast 與 Log

**提示 4：產生 Toast + Log 展示 App**（對應 Day1 6.1）
```
請幫我寫一個 Android Java App（叫 ToastLogDemo，套件 com.example.toastlog）：
- activity_main.xml：一個 EditText（輸入訊息）、三顆按鈕「短 Toast / 長 Toast / 置中 Toast」、五顆小按鈕 V D I W E（水平均分寬度）、一個 TextView 顯示最後動作
- MainActivity.java：
  - Toast.LENGTH_SHORT / LENGTH_LONG、setGravity 置中
  - 五顆按鈕分別寫 Log.v/d/i/w/e，TAG 用 "ToastLogDemo"
  - 顯示「我剛做了什麼」到 TextView
請用 lambda，並把 Log 五個層級的意思說明一下
```
> 實作後請自己在 Logcat 搜尋 `ToastLogDemo` 驗證。

---

## 6. 四個完整範例（核心）

以下每個範例都是「你給需求 → AI 產出 XML + Java → 你照貼 → Run → 驗證」。

區塊說明：**「需求提示」** 是給 AI 的完整提示；**「練習擴充提示」** 是交給你之後自己發問用的。

---

### 6-1 BMI 計算機

**需求提示**
```
我是 Java 開發者（熟悉 Swing），正在學 Android（Java + XML）。
請幫我完成「BMI 計算機」App，套件名 com.example.bmicalc：

1. activity_main.xml：
   - 標題「BMI 計算機」28sp 粗體
   - 兩個 EditText：身高 (cm) 用 inputType="numberDecimal"，體重 (kg) 用 numberDecimal
   - 一個按鈕「計算 BMI」
   - 一個結果 TextView

2. MainActivity.java：
   - findViewById 綁定元件
   - 點擊按鈕用 lambda 呼叫 calculateBMI()
   - 空值或 <=0 時用 Toast 提示
   - BMI = 體重 / (身高m)^2，分類：<18.5 過輕、<24 正常、<27 過重、否則肥胖
   - String.format 顯示 BMI 一位小數 + 分類

請用 lambda 寫法。
```

**練習擴充提示**（抄 `01_Day1_Complete.md` 9-4）
```
請幫 BMI 計算機加上「Reset 清空」按鈕，並在畫面顯示「標準體重範圍」。
```

**驗證**：輸入 170 / 60 → 應顯示「BMI = 20.8 分類：正常」。

---

### 6-2 溫度轉換器

**需求提示**
```
我學到「溫度轉換器」，套件 com.example.tempconvert，請幫我產出：

1. activity_main.xml：
   - 標題「溫度轉換器」
   - EditText（etTemp），inputType="numberDecimal|numberSigned"
   - RadioGroup 水平，兩個 RadioButton：「攝氏→華氏」預設選中、「華氏→攝氏」
   - 轉換按鈕、結果 TextView

2. MainActivity.java：
   - 用 TextUtils.isEmpty 檢查空值（Toast 提示）
   - radioGroup.getCheckedRadioButtonId() 判斷方向
   - C→F: value*9/5+32；F→C: (value-32)*5/9
   - String.format 顯示兩位小數
```

**練習擴充提示**
```
請把溫度轉換器的 RadioButton 改成 Spinner 下拉選方向，兩個刻度都顯示。
```

**驗證**：100 & 攝氏→華氏 → `212.00`；32 & 華氏→攝氏 → `0.00`。

---

### 6-3 登入表單

**需求提示**
```
我學到「登入表單」，套件 com.example.loginform，請幫我產出：

1. activity_main.xml：
   - 標題「會員登入」
   - EditText 帳號（inputType="text"）、EditText 密碼（inputType="textPassword"）
   - CheckBox「顯示密碼」
   - 登入按鈕、狀態 TextView（初始「尚未登入」）

2. MainActivity.java：
   - CheckBox 勾選時用 setInputType 切換密碼明文/遮蔽
   - 登入判斷帳密是否 admin / 1234，成功 Toast「登入成功」+ 顯示歡迎詞
   - 失敗用 AlertDialog 彈出「帳號或密碼錯誤」
   - 點擊用 lambda；OnCheckedChangeListener 用 lambda
```

**練習擴充提示**
```
請幫登入表單用 SharedPreferences 記住上次的帳號，並在輸入三次錯誤後鎖定按鈕。
```
> 註：SharedPreferences 是 Day 3 主題，這裡當預習，順便讓 AI 一起教。

**驗證**：admin/1234 → 成功；admin/123 → AlertDialog。

---

### 6-4 常用 View 互動展示

**需求提示**（對應 Day1 12 章）
```
我學到 Android 常用 View，套件 com.example.viewdemo，請幫我產出一個「常用 View 互動展示」App：

1. activity_main.xml：
   - ImageView（120dp，src 用 @android:drawable/ic_menu_gallery）
   - Button「換圖」
   - Spinner（選項：蘋果、香蕉、柳橙）
   - Switch「開關狀態」
   - SeekBar（max=100，progress=50）
   - RatingBar（numStars=5，rating=3）
   - Button「全部更新」、結果 TextView

2. MainActivity.java：
   - Spinner 用 ArrayAdapter，OnItemSelectedListener 用 anonymous class（兩個方法）
   - 換圖按鈕在 gallery / camera 間切換（lambda）
   - Switch 用 OnCheckedChangeListener（lambda）
   - SeekBar 用 anonymous class（三個方法）
   - RatingBar 用 setOnRatingBarChangeListener（lambda）
   - 「全部更新」一次讀取：spinner.getSelectedItem()（轉 String）、isChecked()（boolean）、getProgress()（int）、getRating()（float）

請特別標明哪些用 lambda、哪些要用 anonymous class。
```

**練習擴充提示**
```
請把這個 View 展示 App 的 Switch 換成 ToggleButton 和 CheckBox 三種比較。
```

**驗證**：換圖、選單、開關、進度條、星等、全部更新都要能即時顯示。

---

## 7. 讓 AI 幫你除錯

拿到程式碼、照貼後，若「編譯錯誤」或「Run 失敗」，**把完整錯誤訊息貼給 AI**：

```
我在 Android Studio (Java) 遇到下面錯誤，幫忙找出原因並給我修正後的完整程式碼：
[貼上錯誤訊息，例如：
Caused by: android.os.NetworkOnMainThreadException
或 compiler error: 找不到符號 變數 tvResult]

這是我的程式碼：
[貼整段 MainActivity.java 或 activity_main.xml]
```

> 給 AI 的錯誤訊息越完整越好（包含 Logcat 的 stacktrace、是哪一支檔案）。**不要只說「壞了」**。

---

## 8. 讓 AI 幫你「擴充」與「解釋」

### 擴充自己會的功能（把想法變成程式）
```
我 Day 1 已會用 findViewById + lambda + Toast。
請教我「怎麼」把 BMI 結果在按下按鈕時也彈出 AlertDialog 顯示，並說明每一行在做什麼。
```

### 解釋不懂的程式碼
```
請逐行解釋這段 Android Java 程式碼是做什麼的（用 JFrame 對照）：
[貼程式碼]
```

### 用對話讓 AI 出練習題
```
請出 3 題 about Android LinearLayout match_parent / wrap_content 的小測驗，附解答。
```
> 對照 `01_Day1_Complete.md` 第 13 章自我測驗，把它當成互動版。

---

## 9. 提示寫作五大技巧

| 技巧 | 做法 | 範例 |
|---|---|---|
| 1. 先給身分背景 | 開頭就說自己會什麼 | 「我是 Swing Java 開發者」 |
| 2. 一次只做一件事 | 一個畫面、一個功能、一個檔案 | 「先給我 activity_main.xml」 |
| 3. 明確要格式 | 要求「用 XML code block」「用 lambda」 | 「請用 lambda 寫 MainActivity」 |
| 4. 給套件名 | 避免自動產生的名字對不上 | 「套件 com.example.bmicalc」 |
| 5. 驗證後再迭代 | 跑失敗 → 貼錯誤訊息 → 修 → 再跑 | 「這是 error，怎麼改」 |

---

## 建議複習流程（把 AI 變成互動練習）

1. **先自己照教材做一遍**（不看 AI）
2. **再用上面的提示讓 AI 產生同一支程式**
3. **比對你寫的 vs AI 寫的**，看哪裡不同、為什麼
4. **讓 AI 出測驗**，驗證你真的懂
5. **用「練習擴充提示」新增功能**，挑戰自己

> 這樣做，AI 不是幫你抄作業，而是幫你「反覆練習 + 理解差異」，這是最有效的學法。
