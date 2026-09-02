# Appendix B：Lambda vs Anonymous Class 完整對照

> 所有文件中的「lambda 對照」皆引用此表。

---

## 核心原則

| 情況 | 可用 Lambda？ | 說明 |
|---|---|---|
| **Functional Interface（單一抽象方法介面）** | ✅ | 如 `View.OnClickListener`、`DialogInterface.OnClickListener`、`Runnable` |
| **多個抽象方法的介面** | ❌ | 必須用 Anonymous Class 或具名類別 |
| **覆寫既有類別的方法（override）** | ❌ | 如 `onCreate`、`onActivityResult`、`onBindViewHolder` |

---

## 常見 Android Functional Interfaces

| 介面 | 單一方法 | Lambda 寫法範例 |
|---|---|---|
| `View.OnClickListener` | `onClick(View v)` | `v -> { ... }` |
| `DialogInterface.OnClickListener` | `onClick(DialogInterface d, int w)` | `(d, w) -> { ... }` |
| `AdapterView.OnItemClickListener` | `onItemClick(parent, view, pos, id)` | `(p, v, pos, id) -> { ... }` |
| `CompoundButton.OnCheckedChangeListener` | `onCheckedChanged(button, checked)` | `(b, c) -> { ... }` |
| `TextView.OnEditorActionListener` | `onEditorAction(v, actionId, event)` | `(v, a, e) -> false` |
| `Runnable` | `run()` | `() -> { ... }` |

---

## 程式碼對照表

### 1. Button 點擊

```java
// Anonymous Class（傳統）
btn.setOnClickListener(new View.OnClickListener() {
    @Override public void onClick(View v) { doSomething(); }
});

// Lambda（推薦）
btn.setOnClickListener(v -> doSomething());

// 方法參考（若已有私有方法）
btn.setOnClickListener(this::doSomething);
```

### 2. AlertDialog 按鈕

```java
// Anonymous
.setPositiveButton("確定", new DialogInterface.OnClickListener() {
    @Override public void onClick(DialogInterface d, int w) { save(); }
});

// Lambda
.setPositiveButton("確定", (d, w) -> save());
```

### 3. ListView 項目點擊（4 參數）

```java
// Anonymous
list.setOnItemClickListener(new AdapterView.OnItemClickListener() {
    @Override public void onItemClick(AdapterView<?> p, View v, int pos, long id) { ... }
});

// Lambda（參數名稱可自訂，順序不可變）
list.setOnItemClickListener((p, v, pos, id) -> { ... });

// 單行
list.setOnItemClickListener((p, v, pos, id) -> doSomething(items[pos]));
```

### 3. CheckBox 狀態改變

```java
// Anonymous
cb.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
    @Override public void onCheckedChanged(CompoundButton b, boolean c) { ... }
});

// Lambda
cb.setOnCheckedChangeListener((b, c) -> { ... });
```

### 4. RecyclerView ViewHolder 綁定

```java
// onBindViewHolder 是「方法覆寫」—不能用 Lambda
@Override
public void onBindViewHolder(@NonNull VH holder, int pos) { ... }

// 但 itemView.setOnClickListener 是介面—可用 Lambda
holder.itemView.setOnClickListener(v -> listener.onItemClick(data.get(pos)));
```

### 5. Thread / Runnable

```java
new Thread(new Runnable() { public void run() { work(); } }).start();
new Thread(() -> work()).start();
```

---

## 何時「不能」用 Lambda

| 程式碼 | 原因 |
|---|---|
| `@Override protected void onCreate(Bundle s) {}` | 覆寫父類別方法，非介面實作 |
| `new MemoAdapter(new OnMemoClickListener() { onClick(); onLongClick(); })` | 介面有兩個方法，非 Functional Interface |
| `@Override public void onBindViewHolder(VH h, int p) {}` | 覆寫 RecyclerView.Adapter 方法 |

> 解法：把多方法介面拆成多個單一方法介面（如 `OnClick`、`OnLongClick` 分開），即可各自用 Lambda。

---

## Java 8 需求

- Android Studio 3.0+ 內建 **desugaring**，專案預設支援 Lambda，**無需額外設定**。
- `build.gradle` 確認 `compileOptions` 有 `sourceCompatibility JavaVersion.VERSION_1_8` 即可（新專案預設皆有）。