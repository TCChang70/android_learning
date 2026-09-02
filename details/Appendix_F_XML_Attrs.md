# Appendix F：常用 XML 屬性速查

---

## 尺寸與間距

| 屬性 | 說明 | 典型值 |
|---|---|---|
| `layout_width` / `layout_height` | 寬/高 | `match_parent`、`wrap_content`、`200dp` |
| `layout_margin` | 外距（四邊） | `16dp` |
| `layout_marginStart/End/Top/Bottom` | 單邊外距 | `8dp` |
| `padding` | 內距（四邊） | `12dp` |
| `paddingStart/End/Top/Bottom` | 單邊內距 | `4dp` |
| `layout_gravity` | **子元件在父容器中的對齊** | `center`、`center_horizontal`、`end` |
| `gravity` | **元件內容（文字/子元件）的對齊** | `center`、`start` |

> 記憶口訣：**layout_gravity = 我要站在哪；gravity = 我的內容要站在哪**。

---

## 文字與外觀

| 屬性 | 說明 | 典型值 |
|---|---|---|
| `text` | 文字內容 | `"Hello"`、`@string/app_name` |
| `textSize` | 字體大小 | `16sp`、`18sp` |
| `textColor` | 字體顏色 | `#FF0000`、`@color/primary` |
| `textStyle` | 粗體/斜體 | `bold`、`italic`、`bold\|italic` |
| `hint` | 輸入提示（灰字） | `"請輸入帳號"` |
| `inputType` | 輸入法類型 | `text`、`textPassword`、`number`、`numberDecimal`、`phone`、`textEmailAddress`、`textMultiLine` |
| `maxLines` / `minLines` | 最大/最小行數 | `1`、`3` |
| `ellipsize` | 文字過長省略 | `end`、`middle`、`marquee` |

---

## 背景與邊框

| 屬性 | 說明 | 典型值 |
|---|---|---|
| `background` | 背景圖/色 | `@drawable/bg`、`#FFFFFF`、`@color/surface` |
| `backgroundTint` | 背景著色（Material 元件） | `@color/primary` |
| `drawableStart/End/Top/Bottom` | 文字旁圖示 | `@drawable/ic_search` |
| `drawablePadding` | 圖示與文字間距 | `8dp` |

---

## 可見度與啟用

| 屬性 | 說明 | 值 |
|---|---|---|
| `visibility` | 可見/隱藏/佔位隱藏 | `visible`、`invisible`、`gone` |
| `enabled` | 是否可互動 | `true`、`false` |
| `clickable` / `focusable` | 可點擊/可取得焦點 | `true`、`false` |

---

## LinearLayout 專用

| 屬性 | 說明 | 值 |
|---|---|---|
| `orientation` | 排列方向 | `vertical`、`horizontal` |
| `weightSum` | 權重總和 | `1.0`、`100` |
| `layout_weight` | 子元件權重 | `1`、`0.5` |
| `baselineAligned` | 基準線對齊 | `true`、`false` |

---

## RelativeLayout / ConstraintLayout 常用

| 屬性 | 說明 |
|---|---|
| `layout_below` / `layout_above` | 在某 id 下方/上方 |
| `layout_toStartOf` / `layout_toEndOf` | 在某 id 左/右 |
| `layout_alignParentTop/Bottom/Start/End` | 靠父容器邊緣 |
| `layout_centerInParent` | 置中 |
| `layout_centerHorizontal/Vertical` | 水平/垂直置中 |

> 新專案建議直接用 **ConstraintLayout**（預設），RelativeLayout 較舊。

---

## 單位對照

| 單位 | 全名 | 用途 |
|---|---|---|
| `dp` / `dip` | Density-independent Pixels | 佈局寬高、margin、padding（螢幕密度無關） |
| `sp` | Scale-independent Pixels | **文字大小**（會隨系統字體縮放） |
| `px` | Pixels | 實體像素（避免直接用） |
| `pt` | Points | 1/72 吋（印刷用，少用） |
| `mm` / `in` | 公釐/吋 | 實體尺寸（極少用） |

---

## 字串資源引用

```xml
<!-- strings.xml -->
<string name="app_name">BMI 計算機</string>
<string name="welcome">歡迎，%1$s！</string>

<!-- XML 引用 -->
android:text="@string/app_name"

<!-- Java 取得 -->
getString(R.string.welcome, "小明")  // → "歡迎，小明！"
```

---

## 顏色資源引用

```xml
<!-- colors.xml -->
<color name="primary">#6200EE</color>
<color name="surface">#FFFFFF</color>

<!-- XML 引用 -->
android:background="@color/primary"
android:textColor="@color/surface"

<!-- Java 取得（API 23+） -->
ContextCompat.getColor(this, R.color.primary)
```

---

## 典型元件屬性組合（複製即用）

```xml
<!-- 標準按鈕 -->
<Button
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:text="@string/submit"
    android:textSize="16sp" />

<!-- 輸入框（密碼） -->
<EditText
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:hint="@string/password_hint"
    android:inputType="textPassword"
    android:maxLines="1" />

<!-- 文字顯示 -->
<TextView
    android:layout_width="wrap_content"
    android:layout_height="wrap_content"
    android:text="@string/result"
    android:textSize="18sp"
    android:textColor="@color/primary" />

<!-- 圖片 -->
<ImageView
    android:layout_width="100dp"
    android:layout_height="100dp"
    android:src="@drawable/ic_launcher"
    android:contentDescription="@string/app_name" />
```