# Appendix H：JFrame (Swing) ↔ Android 完整對照表

> 針對熟悉 Swing/JFrame 的開發者，一張表看懂兩者對應。

---

## 核心架構對照

| 概念 | Swing (JFrame) | Android | 關鍵差異 |
|---|---|---|---|
| **主視窗** | `JFrame` | `Activity` | Activity 有生命週期、可被系統回收重建 |
| **容器面板** | `JPanel` | `ViewGroup` (LinearLayout, RelativeLayout, ConstraintLayout) | Android 佈局是 ViewGroup 子類 |
| **元件** | `JButton`、`JLabel`、`JTextField` | `Button`、`TextView`、`EditText` | Android 元件全繼承 `View` |
| **佈局管理** | `setLayout(new BorderLayout())` | XML 宣告 `android:orientation`、`layout_constraint` | Android 採**宣告式 XML**，不寫 Java 佈局代碼 |
| **事件監聽** | `addActionListener(e -> {})` | `setOnClickListener(v -> {})` | 介面名不同，Lambda 寫法相同 |
| **顯示視窗** | `frame.setVisible(true)` | `startActivity(intent)` | Android 用 Intent 啟動、需在 Manifest 註冊 |
| **關閉視窗** | `frame.dispose()` / `System.exit(0)` | `finish()` / 按 Back | 不要呼叫 `System.exit()` |
| **主程式進入點** | `public static void main()` | 無（由系統啟動 `MainActivity`） | Android 由 Launcher/Intent 啟動 |
| **執行緒模型** | EDT (Event Dispatch Thread) | Main Thread (UI Thread) | 同樣不能在主執行緒做耗時操作 |

---

## 元件一對一對照

| Swing 元件 | Android 元件 | XML 標籤 | 備註 |
|---|---|---|---|
| `JButton` | `Button` | `<Button>` | 文字用 `android:text` |
| `JLabel` | `TextView` | `<TextView>` | 純顯示文字 |
| `JTextField` | `EditText` | `<EditText>` | `inputType` 控制鍵盤 |
| `JPasswordField` | `EditText` (`inputType="textPassword"`) | 同上 | 密碼顯示 ●●● |
| `JTextArea` | `EditText` (`inputType="textMultiLine"`) | 同上 | 多行輸入 |
| `JComboBox` | `Spinner` | `<Spinner>` | 需配合 Adapter |
| `JList` | `ListView` / `RecyclerView` | `<ListView>` / `<RecyclerView>` | RecyclerView 效能較好 |
| `JTable` | `RecyclerView` (多欄) | 同上 | 需自訂 ViewHolder |
| `JCheckBox` | `CheckBox` | `<CheckBox>` | 狀態 `isChecked()` |
| `JRadioButton` | `RadioButton` | `<RadioButton>` | 需包在 `RadioGroup` |
| `JScrollPane` | `ScrollView` / `NestedScrollView` | `<ScrollView>` | 只能包一個直接子元素 |
| `JOptionPane.showMessageDialog` | `Toast` / `AlertDialog` | — | Toast 不阻塞、Dialog 阻塞 |
| `JFileChooser` | `Intent.ACTION_OPEN_DOCUMENT` | — | Android 用系統選單 |
| `JProgressBar` | `ProgressBar` | `<ProgressBar>` | 樣式 `style="?android:attr/progressBarStyleHorizontal"` |
| `JSlider` | `SeekBar` | `<SeekBar>` | 進度條拖曳 |
| `JTabbedPane` | `TabLayout` + `ViewPager2` | — | 需 Fragment 配合 |
| `JMenuBar` / `JMenu` | `Toolbar` + `Menu` | `menu/main.xml` | `onCreateOptionsMenu` |
| `JDialog` | `AlertDialog` / `DialogFragment` | — | 彈窗 |

---

## 佈局對照

| Swing LayoutManager | Android 佈局 | XML 關鍵屬性 |
|---|---|---|
| `BorderLayout` | `ConstraintLayout` / `RelativeLayout` | `layout_constraintTop_toTopOf` 等 |
| `FlowLayout` | `LinearLayout` (horizontal) | `orientation="horizontal"` |
| `BoxLayout` (Y_AXIS) | `LinearLayout` (vertical) | `orientation="vertical"` |
| `GridLayout` | `GridLayout` / `RecyclerView` (GridLayoutManager) | `columnCount`、`rowCount` |
| `CardLayout` | `ViewPager2` + Fragment | — |
| `GridBagLayout` | `ConstraintLayout` | 约束鏈、比例、鏈式 |

> **心法轉換**：Swing 是「Java 代碼 new Layout + add(component)」，Android 是「XML 宣告屬性、Java 只綁定邏輯」。

---

## 事件模型對照

| Swing | Android | Lambda 寫法 |
|---|---|---|
| `ActionListener` → `actionPerformed(ActionEvent e)` | `View.OnClickListener` → `onClick(View v)` | `v -> { ... }` |
| `MouseListener` → `mouseClicked(MouseEvent e)` | `View.OnClickListener` / `OnLongClickListener` | 同上 |
| `KeyListener` → `keyPressed(KeyEvent e)` | `View.OnKeyListener` → `onKey(View v, int keyCode, KeyEvent e)` | `(v, k, e) -> false` |
| `FocusListener` → `focusGained/lost(FocusEvent e)` | `View.OnFocusChangeListener` → `onFocusChange(View v, boolean hasFocus)` | `(v, has) -> { ... }` |
| `DocumentListener` → `insertUpdate/removeUpdate` | `TextWatcher` → `beforeTextChanged/onTextChanged/afterTextChanged` | 需實作介面（三方法） |
| `ListSelectionListener` | `AdapterView.OnItemClickListener` | `(p, v, pos, id) -> { ... }` |
| `ChangeListener` (Slider) | `SeekBar.OnSeekBarChangeListener` | 需實作介面（三方法） |

---

## 資料綁定 / Adapter 對照

| Swing | Android |
|---|---|
| `ListModel` + `JList.setModel()` | `RecyclerView.Adapter` + `recyclerView.setAdapter()` |
| `TableModel` + `JTable.setModel()` | `RecyclerView.Adapter` (多 ViewType) |
| `ComboBoxModel` + `JComboBox.setModel()` | `ArrayAdapter` + `spinner.setAdapter()` |
| `DefaultListModel.addElement()` | `list.add(item)` + `adapter.notifyItemInserted(pos)` |
| `ListCellRenderer` | `ViewHolder` + `onBindViewHolder()` |

---

## 資料持久化對照

| Swing/JDBC | Android |
|---|---|
| `DriverManager.getConnection()` + `PreparedStatement` | `SQLiteOpenHelper` + `execSQL("... ? ...", params)` |
| `ResultSet` + `next()` / `getString()` | `Cursor` + `moveToNext()` / `getString(idx)` |
| 連線池 | 不需要（SQLite 是檔案、單連線） |
| ORM (Hibernate/JPA) | **Room** (Google 官方 ORM) |
| Properties 檔 | `SharedPreferences` (key-value) |
| 檔案 I/O (`FileReader/Writer`) | `openFileInput/Output` (內部儲存) / `Context.getExternalFilesDir()` |

---

## 視覺/樣式對照

| Swing | Android |
|---|---|
| `UIManager.setLookAndFeel()` | `themes.xml` 定義 `Theme.AppCompat` / `Theme.Material3` |
| `setFont(new Font(...))` | `android:textSize="16sp"` `android:fontFamily="@font/xxx"` |
| `setBackground(Color)` | `android:background="@color/xxx"` 或 `setBackgroundResource()` |
| `setBorder(BorderFactory...)` | `android:background="@drawable/shape_xml"` (shape drawable) |
| `setToolTipText()` | 無直接對應（可用長按顯示 Toast/Dialog） |

---

## 除錯/日誌對照

| Swing | Android |
|---|---|
| `System.out.println()` | `Log.d(TAG, "msg")` (Logcat) |
| `e.printStackTrace()` | `Log.e(TAG, "msg", e)` |
| 遠端除錯 (JPDA) | Android Studio Debugger (USB/WiFi) |
| VisualVM / JConsole | Android Profiler (CPU/Memory/Network) |

---

## 部署對照

| Swing | Android |
|---|---|
| `jar` / `exe` (Launch4j) | `APK` / `AAB` (Google Play) |
| 雙擊執行 | 點選桌面圖示 / 應用程式清單 |
| JRE 需安裝 | 系統內建 Android Runtime (ART) |
| 版本更新：替換 jar | 版本更新：上傳 AAB 到 Play Console、用戶自動更新 |

---

## 心法轉換總結

| 思維 | Swing | Android |
|---|---|---|
| **UI 定義** | Java 代碼 `new` + `add()` | **XML 宣告** |
| **元件參考** | 直接持有 `JButton btn` | `findViewById(R.id.btn)` 取得參考 |
| **事件** | `addXxxListener(new XxxListener() {...})` | `setOnXxxListener(v -> {...})` (Lambda) |
| **多視窗** | `new JFrame()` | `startActivity(Intent)` + Manifest 註冊 |
| **資料庫** | JDBC + 外部 DB | **SQLite (內建檔案)** + **Room** |
| **生命週期** | 無（手動控制） | **系統管理**，須覆寫 `onCreate/Start/Resume/Pause/Stop/Destroy` |
| **記憶體回收** | GC 自動 | GC + **系統可殺掉背景 Activity** → 必須 `onSaveInstanceState` |

---

## 常用類別名稱對照速查

| Swing (javax.swing) | Android (android.widget / androidx) |
|---|---|
| `JFrame` | `Activity` / `AppCompatActivity` |
| `JPanel` | `LinearLayout` / `ConstraintLayout` / `FrameLayout` |
| `JButton` | `Button` / `MaterialButton` |
| `JLabel` | `TextView` |
| `JTextField` | `EditText` / `TextInputEditText` |
| `JComboBox` | `Spinner` / `AutoCompleteTextView` |
| `JList` | `RecyclerView` + `ListAdapter` |
| `JTable` | `RecyclerView` (多 ViewType) |
| `JScrollPane` | `ScrollView` / `NestedScrollView` |
| `JOptionPane` | `Toast` / `AlertDialog` / `MaterialAlertDialogBuilder` |
| `JFileChooser` | `ActivityResultContracts.OpenDocument` |
| `JProgressBar` | `ProgressBar` |
| `JSlider` | `SeekBar` |
| `JTabbedPane` | `TabLayout` + `ViewPager2` |
| `JMenuBar` | `Toolbar` / `ActionBar` |
| `BorderFactory` | `@drawable/shape_*.xml` (GradientDrawable) |