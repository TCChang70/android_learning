# TakePictureDemo 程式說明文件

> 對應教材：`Day2_Slides_Marp.md` →「5.5｜拍照：TakePicture + FileProvider」
> 專案路徑：`android_projects\TakePictureDemo`
> 套件名稱：`com.example.takepicturedemo`

---

## 1. 專案簡介

本專案示範 Android 最標準的拍照流程：

1. App 建立一個空白的照片檔案。
2. 用 `FileProvider` 把該檔案轉成安全的 `content://` Uri。
3. 透過 `ActivityResultContracts.TakePicture` 啟動**系統相機 App**。
4. 相機 App 把照片寫入該 Uri。
5. 拍攝成功後回到 App，將照片顯示在 `ImageView`。

這樣的做法**不需要 `CAMERA` 權限**，因為實際操作相機的是系統相機 App，我們的 App 只負責提供輸出檔案的位置。

### 功能一覽

| 功能 | 說明 |
|---|---|
| 拍照 | 開啟系統相機，指定輸出檔案的 Uri |
| 預覽 | 拍攝成功後以 `ImageView` 顯示照片 |
| 狀態顯示 | 以 `TextView` 顯示「尚未拍照 / 相機已開啟 / 拍照成功路徑 / 已取消」 |
| 取消清理 | 使用者取消拍照時，刪除尚未寫入的空檔案 |
| 狀態還原 | Activity 被系統重建後，仍能接續處理拍照結果 |
| 錯誤提示 | 目錄、建檔、啟動相機失敗時以 Toast 顯示原因 |

---

## 2. 專案結構

```text
TakePictureDemo/
├── settings.gradle                  ← 宣告模組與倉庫
├── build.gradle                     ← AGP 版本
├── gradle.properties                ← AndroidX、編碼、中文路徑允許
├── gradlew / gradlew.bat            ← Gradle Wrapper
├── local.properties                 ← 本機 SDK 路徑（不進版控）
├── README.md                        ← 快速上手說明
├── 程式說明.md                      ← 本文件
└── app/
    ├── build.gradle                 ← 套件、SDK 版本、相依套件
    ├── proguard-rules.pro
    └── src/main/
        ├── AndroidManifest.xml      ← Activity 與 FileProvider 註冊
        ├── java/com/example/takepicturedemo/
        │   └── MainActivity.java    ← 主程式
        └── res/
            ├── layout/activity_main.xml   ← 畫面佈局
            ├── xml/file_paths.xml         ← FileProvider 可分享的目錄
            ├── values/strings.xml         ← 字串資源
            ├── values/themes.xml          ← App 主題
            └── drawable/ic_launcher.xml   ← 向量 App 圖示
```

---

## 3. 執行流程

```text
使用者點擊「拍照」
        │
        ▼
MainActivity.takePhoto()
        │
        ├─ 取得 getExternalFilesDir(DIRECTORY_PICTURES)
        │      └─ 若目錄不存在 → 建立目錄
        │
        ├─ File.createTempFile("IMG_", ".jpg", dir)
        │      └─ 建立空白照片檔
        │
        ├─ FileProvider.getUriForFile(this, AUTHORITY, photoFile)
        │      └─ 產生 content://com.example.takepicturedemo.fileprovider/...
        │
        ├─ 記錄 pendingPhotoFile / pendingPhotoUri
        │
        └─ takePictureLauncher.launch(photoUri)
                    │
                    ▼
            系統相機 App 開啟
                    │
          ┌─────────┴─────────┐
          │                   │
       按下快門             按返回取消
          │                   │
          ▼                   ▼
   寫入照片到 Uri        success = false
          │                   │
          └─────────┬─────────┘
                    ▼
        ActivityResult 回呼
                    │
        ┌───────────┴───────────┐
        │ success = true        │ success = false
        ▼                       ▼
 ivPhoto.setImageURI()     deletePendingPhoto()
 顯示「拍照成功：路徑」      顯示「未拍照或已取消」
        │                       │
        └───────────┬───────────┘
                    ▼
        pendingPhotoUri / pendingPhotoFile 清空
```

---

## 4. 檔案逐一說明

### 4.1 `AndroidManifest.xml`

```xml
<application
    android:allowBackup="true"
    android:icon="@drawable/ic_launcher"
    android:label="@string/app_name"
    android:supportsRtl="true"
    android:theme="@style/Theme.TakePictureDemo">

    <activity
        android:name=".MainActivity"
        android:exported="true">
        <intent-filter>
            <action android:name="android.intent.action.MAIN" />
            <category android:name="android.intent.category.LAUNCHER" />
        </intent-filter>
    </activity>

    <provider
        android:name="androidx.core.content.FileProvider"
        android:authorities="${applicationId}.fileprovider"
        android:exported="false"
        android:grantUriPermissions="true">
        <meta-data
            android:name="android.support.FILE_PROVIDER_PATHS"
            android:resource="@xml/file_paths" />
    </provider>

</application>
```

| 設定 | 作用 |
|---|---|
| `android:name=".MainActivity"` | 開頭的 `.` 代表「目前套件」，即 `com.example.takepicturedemo.MainActivity` |
| `android:exported="true"` | 含 launcher intent-filter 的 Activity 必須設為 `true`，否則 Android 12+ 無法啟動 |
| `android:authorities` | FileProvider 的唯一識別碼，展開後為 `com.example.takepicturedemo.fileprovider` |
| `android:exported="false"` | provider 不對外公開，只允許取得授權的 App 存取 |
| `android:grantUriPermissions="true"` | 允許把單一 Uri 的讀寫權限暫時授予相機 App |
| `@xml/file_paths` | 指向 `res/xml/file_paths.xml`，定義可分享的資料夾 |

> ⚠️ `authorities` 必須與 `MainActivity.AUTHORITY` 常數**完全相同**，否則會拋出
> `IllegalArgumentException: Failed to find configured root` 或
> `Couldn't find meta-data for provider`。

### 4.2 `res/xml/file_paths.xml`

```xml
<?xml version="1.0" encoding="utf-8"?>
<paths xmlns:android="http://schemas.android.com/apk/res/android">
    <external-files-path
        name="my_images"
        path="Pictures/" />
</paths>
```

| 屬性 | 說明 |
|---|---|
| `<external-files-path>` | 對應 `Context.getExternalFilesDir(...)` 回傳的 App 專屬外部目錄 |
| `path="Pictures/"` | 只開放 `.../files/Pictures/` 這個子目錄 |
| `name="my_images"` | 產生 Uri 時使用的路徑代稱（不影響功能，方便辨識） |

實際對應的裝置路徑：

```text
/storage/emulated/0/Android/data/com.example.takepicturedemo/files/Pictures/
```

可使用的其他標籤：

| 標籤 | 對應位置 |
|---|---|
| `<files-path>` | `getFilesDir()` |
| `<cache-path>` | `getCacheDir()` |
| `<external-files-path>` | `getExternalFilesDir(null)` |
| `<external-cache-path>` | `getExternalCacheDir()` |
| `<external-path>` | 外部儲存根目錄（**不建議**，範圍過大） |

### 4.3 `res/layout/activity_main.xml`

```xml
<LinearLayout
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:gravity="center"
    android:padding="16dp">

    <Button
        android:id="@+id/btnTakePhoto"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="@string/btn_take_photo" />

    <ImageView
        android:id="@+id/ivPhoto"
        android:layout_width="220dp"
        android:layout_height="220dp"
        android:layout_marginTop="16dp"
        android:background="#DDDDDD"
        android:contentDescription="@string/photo_desc"
        android:scaleType="centerCrop" />

    <TextView
        android:id="@+id/tvStatus"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_marginTop="12dp"
        android:text="尚未拍照"
        android:textSize="14sp" />

</LinearLayout>
```

| 元件 | 用途 |
|---|---|
| `btnTakePhoto` | 觸發 `takePhoto()` |
| `ivPhoto` | 顯示拍攝結果；`scaleType="centerCrop"` 讓照片填滿正方形且不變形 |
| `tvStatus` | 顯示目前狀態與照片路徑，方便教學時觀察流程 |
| `background="#DDDDDD"` | 尚未拍照時顯示灰色佔位區 |

### 4.4 `MainActivity.java`

#### (1) 常數與欄位

```java
private static final String AUTHORITY = "com.example.takepicturedemo.fileprovider";
private static final String STATE_PHOTO_URI = "photo_uri";
private static final String STATE_PHOTO_PATH = "photo_path";

private ImageView ivPhoto;
private TextView tvStatus;
private Uri pendingPhotoUri;
private File pendingPhotoFile;
```

| 成員 | 說明 |
|---|---|
| `AUTHORITY` | 與 Manifest 的 `android:authorities` 一致 |
| `STATE_PHOTO_URI` / `STATE_PHOTO_PATH` | `onSaveInstanceState` 使用的 key |
| `ivPhoto` / `tvStatus` | 對應佈局元件 |
| `pendingPhotoUri` | 本次交給相機的輸出 Uri |
| `pendingPhotoFile` | 對應的檔案物件，用於取消時刪除 |

> 為什麼要保留 `pendingPhotoFile`？因為 `Uri` 只能定位檔案，要刪除檔案仍需要 `File` 物件。

#### (2) 註冊 launcher

```java
private final ActivityResultLauncher<Uri> takePictureLauncher =
    registerForActivityResult(new TakePicture(), success -> {
        if (success && pendingPhotoUri != null) {
            ivPhoto.setImageURI(pendingPhotoUri);
            tvStatus.setText("拍照成功：" + pendingPhotoFile.getAbsolutePath());
        } else {
            deletePendingPhoto();
            tvStatus.setText("未拍照或已取消");
            Toast.makeText(this, "未拍照或已取消", Toast.LENGTH_SHORT).show();
        }
        pendingPhotoUri = null;
        pendingPhotoFile = null;
    });
```

| 重點 | 說明 |
|---|---|
| `ActivityResultContracts.TakePicture` | 合約型別為 `Uri`，回傳 `boolean`（是否成功） |
| `registerForActivityResult(...)` | 必須在 Activity 進入 `STARTED` 前註冊，因此寫成**欄位初始化** |
| `success && pendingPhotoUri != null` | 雙重檢查，避免 Activity 重建或資料異常時發生 NPE |
| 成功後不清除檔案 | 照片要保留在 `Pictures/` 供後續使用 |
| 失敗時 `deletePendingPhoto()` | 刪除相機沒有寫入內容的空檔案 |

**為什麼不能寫在點擊事件裡？**

```java
// ❌ 錯誤：按下按鈕時 Activity 已在 RESUMED，會拋例外
btnTakePhoto.setOnClickListener(v -> {
    ActivityResultLauncher<Uri> launcher =
        registerForActivityResult(new TakePicture(), result -> { ... });
    launcher.launch(uri);
});
```

會得到：

```text
java.lang.IllegalStateException: LifecycleOwner ... is attempting to register
while the current state is RESUMED. ActivityResultCaller are only allowed to
register before the LifecycleOwner reaches STARTED.
```

正確做法就是本範例：**宣告成 `private final` 欄位**。

#### (3) `onCreate()`

```java
@Override
protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    setContentView(R.layout.activity_main);

    ivPhoto = findViewById(R.id.ivPhoto);
    tvStatus = findViewById(R.id.tvStatus);

    if (savedInstanceState != null) {
        String uri = savedInstanceState.getString(STATE_PHOTO_URI);
        String path = savedInstanceState.getString(STATE_PHOTO_PATH);
        if (uri != null) pendingPhotoUri = Uri.parse(uri);
        if (path != null) pendingPhotoFile = new File(path);
    }

    findViewById(R.id.btnTakePhoto).setOnClickListener(v -> takePhoto());
}
```

流程：

1. 載入佈局。
2. 取得元件參照。
3. 若 Activity 被重建，還原「拍照進行中」的 Uri 與檔案路徑。
4. 綁定按鈕事件。

> 為什麼需要還原？拍照時我們的 Activity 會進入背景，若記憶體不足被系統回收，
> 回來時會建立新的 Activity 實例。若沒有還原 `pendingPhotoUri`，
> 相機回傳成功後就不知道照片應該顯示在哪裡。

#### (4) `onSaveInstanceState()`

```java
@Override
protected void onSaveInstanceState(Bundle outState) {
    if (pendingPhotoUri != null) {
        outState.putString(STATE_PHOTO_URI, pendingPhotoUri.toString());
    }
    if (pendingPhotoFile != null) {
        outState.putString(STATE_PHOTO_PATH, pendingPhotoFile.getAbsolutePath());
    }
    super.onSaveInstanceState(outState);
}
```

- 只保存「拍照進行中」的暫存狀態，不是保存照片本身。
- `Uri` 與 `File` 都可轉成字串放入 `Bundle`。
- 成功或取消後會把欄位設為 `null`，因此不會殘留舊資料。

#### (5) `takePhoto()`

```java
private void takePhoto() {
    File dir = getExternalFilesDir(Environment.DIRECTORY_PICTURES);
    if (dir == null || (!dir.isDirectory() && !dir.mkdirs())) {
        Toast.makeText(this, "找不到可儲存的圖片目錄", Toast.LENGTH_SHORT).show();
        return;
    }

    File photoFile = null;
    try {
        photoFile = File.createTempFile("IMG_", ".jpg", dir);
        Uri photoUri = FileProvider.getUriForFile(this, AUTHORITY, photoFile);
        pendingPhotoFile = photoFile;
        pendingPhotoUri = photoUri;
        takePictureLauncher.launch(photoUri);
        tvStatus.setText("相機已開啟，請拍攝…");
    } catch (IOException | IllegalArgumentException | ActivityNotFoundException
            | SecurityException e) {
        if (photoFile != null && photoFile.exists() && !photoFile.delete()) {
            Toast.makeText(this, "無法清除未完成的照片檔", Toast.LENGTH_SHORT).show();
        }
        pendingPhotoFile = null;
        pendingPhotoUri = null;
        tvStatus.setText("開啟相機失敗");
        Toast.makeText(this, "開啟相機失敗：" + e.getMessage(), Toast.LENGTH_LONG).show();
    }
}
```

分段說明：

| 步驟 | 說明 |
|---|---|
| `getExternalFilesDir(DIRECTORY_PICTURES)` | 取得 App 專屬的 `Pictures` 目錄，不需要儲存權限 |
| `dir == null` | 外部儲存不可用（例如未掛載） |
| `!dir.isDirectory() && !dir.mkdirs()` | 目錄不存在且無法建立 |
| `File.createTempFile("IMG_", ".jpg", dir)` | 建立 `IMG_<隨機碼>.jpg` 空檔，避免檔名衝突 |
| `FileProvider.getUriForFile(...)` | 把 `file://` 轉成可授權的 `content://` |
| `takePictureLauncher.launch(photoUri)` | 開啟系統相機並指定輸出位置 |
| `IOException` | 建檔或取得 Uri 失敗 |
| `IllegalArgumentException` | authorities 與 `file_paths.xml` 設定不符 |
| `ActivityNotFoundException` | 裝置沒有可處理拍照的相機 App |
| `SecurityException` | 權限或授權異常 |

> `File.createTempFile` 建立的檔案**必須先存在**，FileProvider 才能產生 Uri；
> 相機會直接覆寫這個檔案。

#### (6) `deletePendingPhoto()`

```java
private void deletePendingPhoto() {
    if (pendingPhotoFile != null && pendingPhotoFile.exists()
            && !pendingPhotoFile.delete()) {
        Toast.makeText(this, "無法清除未完成的照片檔", Toast.LENGTH_SHORT).show();
    }
}
```

- 只在「取消」或「啟動失敗」時呼叫。
- 刪除失敗（例如檔案被鎖定）時提示使用者，不會讓流程中斷。
- 成功拍照時**不會**呼叫，照片會保留。

---

## 5. 核心觀念

### 5.1 為什麼一定要用 FileProvider？

Android 7.0（API 24）之後，直接把 `file://` Uri 交給其他 App 會拋出：

```text
android.os.FileUriExposedException: file:///... exposed beyond app through ClipData.Item.getUri()
```

原因：`file://` 會暴露完整檔案路徑，且無法精細控制授權範圍。
`FileProvider` 會產生 `content://` Uri，並可**只授權這一次、這一個檔案**的讀寫權限。

### 5.2 `content://` Uri 長什麼樣子？

```text
content://com.example.takepicturedemo.fileprovider/my_images/IMG_123456.jpg
          └──────────── authorities ────────────┘ └─ name ─┘ └─ 檔名 ─┘
```

- `authorities`：Manifest 中註冊的識別碼。
- `my_images`：`file_paths.xml` 中的 `name`。
- 最後是實際檔名。

### 5.3 為什麼不需要 `CAMERA` 權限？

| 做法 | 權限 |
|---|---|
| 使用 `CameraX` / `Camera2` 自己開相機 | 需要 `CAMERA` 執行時權限 |
| 用 `TakePicture` 交給系統相機 App | **不需要**任何相機權限 |

因為真正存取鏡頭的是相機 App，我們的 App 只是提供一個輸出檔案的 Uri。

### 5.4 照片存在哪裡？解除安裝會不見嗎？

```text
/storage/emulated/0/Android/data/com.example.takepicturedemo/files/Pictures/
```

- 這是 **App 專屬外部目錄**，其他 App 不一定能直接讀取。
- 不需要 `READ/WRITE_EXTERNAL_STORAGE` 或 `READ_MEDIA_IMAGES`。
- **解除安裝 App 時會一併刪除**。
- 若要存到相簿（MediaStore），必須另外設計，並非本範例範圍。

### 5.5 生命週期與 Activity 重建

```text
MainActivity（拍照前）
      │  launch 相機
      ▼
onSaveInstanceState()  ← 保存 pendingPhotoUri / pendingPhotoFile
      │
      ▼
系統相機 App（我們的 Activity 可能在背景被回收）
      │  拍攝完成
      ▼
MainActivity（可能是一個全新的實例）
      │  onCreate() 還原 pending 狀態
      ▼
ActivityResult 回呼 → 顯示照片
```

`registerForActivityResult` 的註冊會由 `ActivityResultRegistry` 保存，
即使 Activity 重建，結果仍會派送給新實例中「同一個註冊位置」的回呼。

---

## 6. 權限與設定整理

| 項目 | 是否需要 | 說明 |
|---|---|---|
| `CAMERA` 權限 | ❌ | 由系統相機 App 執行 |
| `READ_MEDIA_IMAGES` | ❌ | 不讀取使用者的媒體庫 |
| `WRITE_EXTERNAL_STORAGE` | ❌ | 使用 App 專屬目錄 |
| `FileProvider` | ✅ | 產生 `content://` Uri |
| `file_paths.xml` | ✅ | 宣告可分享目錄 |
| `<queries>`（Android 11+） | ❌ | `TakePicture` 由系統解析，不需要查詢相機 App |

---

## 7. 建置與執行

### Android Studio

1. **File → Open** → 選擇 `TakePictureDemo` 資料夾。
2. 等待 Gradle Sync。
3. 選擇模擬器或實機 → **Run ▶**。

### 命令列

```bat
gradlew.bat assembleDebug
gradlew.bat installDebug
```

### 產出位置

```text
app\build\outputs\apk\debug\app-debug.apk
```

---

## 8. 測試案例

| # | 操作 | 預期結果 |
|---|---|---|
| 1 | 啟動 App | 顯示「拍照」按鈕、灰色預覽區、「尚未拍照」 |
| 2 | 點「拍照」 | 開啟系統相機，App 狀態顯示「相機已開啟，請拍攝…」 |
| 3 | 按快門 | 返回 App，預覽區顯示照片，狀態顯示「拍照成功：<路徑>」 |
| 4 | 拍照後按返回 | 狀態顯示「未拍照或已取消」，`Pictures/` 內不留空檔 |
| 5 | 拍照途中旋轉螢幕 | 不崩潰，結果仍能正確顯示 |
| 6 | 裝置沒有相機 App | 顯示「開啟相機失敗：…」，不留暫存檔 |
| 7 | 重新啟動 App | 不顯示上一次的照片（僅本次流程有效） |

實際測試（Android 17 / API 37 模擬器）：

```text
拍照成功：/storage/emulated/0/Android/data/com.example.takepicturedemo/
          files/Pictures/IMG_1410001886150923924.jpg
檔案大小：63,644 bytes
取消拍照：狀態顯示「未拍照或已取消」，暫存檔已刪除
```

---

## 9. 常見錯誤排查

| 症狀 | 可能原因 | 解法 |
|---|---|---|
| `register while RESUMED` | launcher 寫在點擊事件中 | 改成 `private final` 欄位 |
| `Failed to find configured root` | `file_paths.xml` 沒有對應目錄 | 補上正確的 `<external-files-path>` |
| `IllegalArgumentException`（啟動相機） | authorities 不一致 | Manifest 與 `AUTHORITY` 常數需完全相同 |
| `FileUriExposedException` | 使用 `Uri.fromFile()` | 改用 `FileProvider.getUriForFile()` |
| 照片顯示空白 | 相機沒有寫入檔案 | 檢查 `TakePicture` 是否回傳 `true`、Uri 是否正確 |
| 取消後留下 0 KB 檔案 | 沒有清理暫存檔 | 在失敗分支呼叫 `deletePendingPhoto()` |
| 旋轉後結果遺失 | 沒有保存 pending 狀態 | 實作 `onSaveInstanceState()` |
| `ActivityNotFoundException` | 裝置無相機 App | 提示使用者或改用其他方案 |
| Sync 失敗（中文路徑） | AGP 阻擋非 ASCII 路徑 | 已設 `android.overridePathCheck=true`，或移到全英文路徑 |

---

## 10. 驗收清單

- [ ] 點「拍照」能開啟系統相機
- [ ] 拍完照片顯示在 `ImageView`
- [ ] 狀態列顯示實際照片路徑
- [ ] 照片檔案存在於 `Pictures/`
- [ ] 取消拍照後不留下空檔案
- [ ] 不需要任何相機或儲存權限
- [ ] 沒有 `IllegalStateException` / `FileUriExposedException`
- [ ] Manifest 的 `authorities` 與程式碼一致
- [ ] `file_paths.xml` 位於 `res/xml/`

---

## 11. 延伸練習

1. **加上「重新拍攝」按鈕**：再呼叫一次 `takePhoto()`。
2. **顯示照片資訊**：檔名、檔案大小、拍攝時間。
3. **分享照片**：用 `ACTION_SEND` + `FileProvider` 分享 `content://` Uri。
4. **存到相簿**：改用 `MediaStore.Images` 輸出，讓照片出現在系統相簿。
5. **限制檔案大小**：拍照後檢查 `length()`，過大時壓縮或提示。
6. **改用 CameraX**：比較「自己開相機」與「交給系統相機」的差異與權限需求。

---

## 12. 與教材對照

| 教材位置 | 本專案對應 |
|---|---|
| `Day2_Slides_Marp.md` 5.5 拍照 | `MainActivity.takePhoto()` |
| `file_paths.xml` 範例 | `res/xml/file_paths.xml` |
| Manifest provider 範例 | `AndroidManifest.xml` 的 `<provider>` |
| `activity_main.xml` 範例 | `res/layout/activity_main.xml`（另加狀態 `TextView`） |
| 錯誤排查表 | 本文件第 9 節 |
| 驗收清單 | 本文件第 10 節 |

---

## 附錄：完整程式碼

### `MainActivity.java`

```java
package com.example.takepicturedemo;

import android.content.ActivityNotFoundException;
import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import androidx.activity.result.ActivityResultLauncher;
import androidx.activity.result.contract.ActivityResultContracts.TakePicture;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.content.FileProvider;

import java.io.File;
import java.io.IOException;

public class MainActivity extends AppCompatActivity {

    private static final String AUTHORITY = "com.example.takepicturedemo.fileprovider";
    private static final String STATE_PHOTO_URI = "photo_uri";
    private static final String STATE_PHOTO_PATH = "photo_path";

    private ImageView ivPhoto;
    private TextView tvStatus;
    private Uri pendingPhotoUri;
    private File pendingPhotoFile;

    // 必須是欄位：registerForActivityResult 只能在 STARTED 之前註冊
    private final ActivityResultLauncher<Uri> takePictureLauncher =
        registerForActivityResult(new TakePicture(), success -> {
            if (success && pendingPhotoUri != null) {
                ivPhoto.setImageURI(pendingPhotoUri);
                tvStatus.setText("拍照成功：" + pendingPhotoFile.getAbsolutePath());
            } else {
                deletePendingPhoto();
                tvStatus.setText("未拍照或已取消");
                Toast.makeText(this, "未拍照或已取消", Toast.LENGTH_SHORT).show();
            }
            pendingPhotoUri = null;
            pendingPhotoFile = null;
        });

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        ivPhoto = findViewById(R.id.ivPhoto);
        tvStatus = findViewById(R.id.tvStatus);

        // Activity 被系統重建時，把拍照中的暫存狀態還原
        if (savedInstanceState != null) {
            String uri = savedInstanceState.getString(STATE_PHOTO_URI);
            String path = savedInstanceState.getString(STATE_PHOTO_PATH);
            if (uri != null) pendingPhotoUri = Uri.parse(uri);
            if (path != null) pendingPhotoFile = new File(path);
        }

        findViewById(R.id.btnTakePhoto).setOnClickListener(v -> takePhoto());
    }

    @Override
    protected void onSaveInstanceState(Bundle outState) {
        if (pendingPhotoUri != null) {
            outState.putString(STATE_PHOTO_URI, pendingPhotoUri.toString());
        }
        if (pendingPhotoFile != null) {
            outState.putString(STATE_PHOTO_PATH, pendingPhotoFile.getAbsolutePath());
        }
        super.onSaveInstanceState(outState);
    }

    private void takePhoto() {
        File dir = getExternalFilesDir(Environment.DIRECTORY_PICTURES);
        if (dir == null || (!dir.isDirectory() && !dir.mkdirs())) {
            Toast.makeText(this, "找不到可儲存的圖片目錄", Toast.LENGTH_SHORT).show();
            return;
        }

        File photoFile = null;
        try {
            photoFile = File.createTempFile("IMG_", ".jpg", dir);
            Uri photoUri = FileProvider.getUriForFile(this, AUTHORITY, photoFile);
            pendingPhotoFile = photoFile;
            pendingPhotoUri = photoUri;
            takePictureLauncher.launch(photoUri);
            tvStatus.setText("相機已開啟，請拍攝…");
        } catch (IOException | IllegalArgumentException | ActivityNotFoundException
                | SecurityException e) {
            if (photoFile != null && photoFile.exists() && !photoFile.delete()) {
                Toast.makeText(this, "無法清除未完成的照片檔", Toast.LENGTH_SHORT).show();
            }
            pendingPhotoFile = null;
            pendingPhotoUri = null;
            tvStatus.setText("開啟相機失敗");
            Toast.makeText(this, "開啟相機失敗：" + e.getMessage(), Toast.LENGTH_LONG).show();
        }
    }

    private void deletePendingPhoto() {
        if (pendingPhotoFile != null && pendingPhotoFile.exists()
                && !pendingPhotoFile.delete()) {
            Toast.makeText(this, "無法清除未完成的照片檔", Toast.LENGTH_SHORT).show();
        }
    }
}
```
