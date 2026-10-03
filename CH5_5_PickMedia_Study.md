# 第 5.5 章　常用系統互動畫面（選擇器家族）實作學習文件

> 本文件是 `02_Day2_Complete.md` 第 5.5 章中「選圖 / 選檔案 / 拍照」三個主題的完整實作學習文件。
> 對應第 5.5.1 節快速對照表的三列：
>
> | 需求 | 用法 |
> |---|---|
> | 選圖 | PickVisualMedia（新版） |
> | 選檔案 | OpenDocument |
> | 拍照 | TakePicture + FileProvider |

---

## 5.5.A　核心觀念：Activity Result API

Android 現代的「啟動系統畫面並取回結果」統一使用 **Activity Result API**。它的好處是：

- 用「合約（Contract）」描述要做什麼，例如 `PickVisualMedia`、`OpenDocument`、`TakePicture`。
- 用 `registerForActivityResult(...)` 註冊一個 `ActivityResultLauncher`，結果會回到你指定的 callback。
- 取代舊的 `startActivityForResult` + `onActivityResult`，更安全、也更好維護。

> ⚠️ **最重要規則**：`registerForActivityResult(...)` **必須在 Activity/Fragment 生命週期進入 `RESUMED` 之前註冊**。
> 實務上就是在**欄位宣告時**或 **`onCreate()` 內建立**。若在按鈕點擊事件裡才呼叫，會拋出
> `IllegalStateException: LifecycleOwner ... is attempting to register while current state is RESUMED`。

**標準寫法（欄位宣告）**：

```java
public class MainActivity extends AppCompatActivity {
    // 宣告成欄位 → 在 onCreate 之前（建構階段）就完成註冊
    private final ActivityResultLauncher<PickVisualMediaRequest> pickMediaLauncher =
        registerForActivityResult(new ActivityResultContracts.PickVisualMedia(), uri -> {
            if (uri != null) { /* 使用 uri */ }
        });

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        // 按鈕只負責「啟動」，不負責「註冊」
    }
}
```

**啟動方式**：在按鈕事件呼叫 `launcher.launch(...)`。

```java
btnPick.setOnClickListener(v -> pickMediaLauncher.launch(request));
```

---

## 5.5.B　選圖：PickVisualMedia（新版 Photo Picker）

### B-1　用途

`PickVisualMedia` 是 Android 13（API 33）引入、並透過 AndroidX 向下支援的 **Photo Picker**。
它讓使用者從系統挑選照片/影片，**App 不需要 `READ_MEDIA_IMAGES` 權限**，兼顧隱私與方便。

### B-2　環境需求

在 `app/build.gradle`（或 `build.gradle.kts`）加入：

```gradle
dependencies {
    // 至少 1.7.0，建議 1.9.3 以上
    implementation "androidx.activity:activity:1.9.3"
}
```

### B-3　判斷是否支援 Photo Picker

較舊裝置沒有系統 Photo Picker，需準備備援（fallback）：

```java
import androidx.activity.result.contract.ActivityResultContracts.PickVisualMedia;

boolean available = PickVisualMedia.isPhotoPickerAvailable(this);
```

### B-4　完整程式碼（含備援）

因為 `registerForActivityResult` 必須在生命週期安全時註冊，**兩個 launcher 都要寫成欄位**，
等點擊時再用 `isPhotoPickerAvailable` 決定要啟動哪一個。

```java
package com.example.pickimagedemo;

import android.net.Uri;
import android.os.Bundle;
import android.widget.Button;
import android.widget.ImageView;

import androidx.activity.result.ActivityResultLauncher;
import androidx.activity.result.PickVisualMediaRequest;
import androidx.activity.result.contract.ActivityResultContracts.GetContent;
import androidx.activity.result.contract.ActivityResultContracts.PickVisualMedia;
import androidx.appcompat.app.AppCompatActivity;

public class MainActivity extends AppCompatActivity {

    private ImageView ivPhoto;

    // ① 新版 Photo Picker
    private final ActivityResultLauncher<PickVisualMediaRequest> pickMediaLauncher =
        registerForActivityResult(new PickVisualMedia(), uri -> {
            if (uri != null) {
                ivPhoto.setImageURI(uri);
            }
        });

    // ② 舊版備援（系統無 Photo Picker 時使用）
    private final ActivityResultLauncher<String> getContentLauncher =
        registerForActivityResult(new GetContent(), uri -> {
            if (uri != null) {
                ivPhoto.setImageURI(uri);
            }
        });

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        ivPhoto = findViewById(R.id.ivPhoto);
        Button btnPick = findViewById(R.id.btnPickImage);

        btnPick.setOnClickListener(v -> {
            if (PickVisualMedia.isPhotoPickerAvailable(this)) {
                // 只挑圖片
                pickMediaLauncher.launch(new PickVisualMediaRequest.Builder()
                    .setMediaType(PickVisualMedia.ImageOnly.INSTANCE)
                    .build());
            } else {
                getContentLauncher.launch("image/*");
            }
        });
    }
}
```

`activity_main.xml`：

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:gravity="center"
    android:padding="16dp">

    <Button
        android:id="@+id/btnPickImage"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="選一張圖片" />

    <ImageView
        android:id="@+id/ivPhoto"
        android:layout_width="220dp"
        android:layout_height="220dp"
        android:layout_marginTop="16dp"
        android:scaleType="centerCrop"
        android:background="#DDDDDD" />

</LinearLayout>
```

### B-5　重點整理

| 項目 | 說明 |
|---|---|
| 合約 | `ActivityResultContracts.PickVisualMedia` |
| 啟動參數 | `PickVisualMediaRequest`（可設 `ImageOnly` / `VideoOnly` / `ImageAndVideo`） |
| 回傳 | `Uri?`（未選取為 `null`） |
| 權限 | **不需要**讀取權限 |
| 備援 | `GetContent`（`"image/*"`） |
| 版本 | `androidx.activity:activity >= 1.7.0`（建議 1.9.3+） |

### B-6　練習題

1. 把 `ImageOnly` 改成 `ImageAndVideo`，觀察選擇器變化。
2. 選圖後，用 `Toast` 顯示 `uri.toString()`。
3. 想一想：為何兩個 launcher 都要寫成欄位，而不能寫在 `setOnClickListener` 裡？

---

## 5.5.C　選檔案：OpenDocument

### C-1　用途

`OpenDocument` 用於挑選**任意文件**（PDF、Word、圖片…），回傳可讀取的 `content://` Uri。
與 `GetContent` 相比，`OpenDocument` 會取得**持久化存取權**（可搭配 `takePersistableUriPermission`）。

### C-2　完整程式碼

```java
package com.example.opendocdemo;

import android.net.Uri;
import android.os.Bundle;
import android.widget.Button;
import android.widget.TextView;

import androidx.activity.result.ActivityResultLauncher;
import androidx.activity.result.contract.ActivityResultContracts.OpenDocument;
import androidx.appcompat.app.AppCompatActivity;

public class MainActivity extends AppCompatActivity {

    private TextView tvFile;

    // OpenDocument 的輸入型別是 String[]（MIME types）
    private final ActivityResultLauncher<String[]> openDocLauncher =
        registerForActivityResult(new OpenDocument(), uri -> {
            if (uri != null) {
                // 取得持久化讀取權限（可選）
                getContentResolver().takePersistableUriPermission(
                    uri, android.content.Intent.FLAG_GRANT_READ_URI_PERMISSION);
                tvFile.setText("已選擇：\n" + uri.toString());
            }
        });

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        tvFile = findViewById(R.id.tvFile);
        Button btnOpen = findViewById(R.id.btnOpenDoc);

        btnOpen.setOnClickListener(v ->
            // 只顯示 PDF 與圖片
            openDocLauncher.launch(new String[]{"application/pdf", "image/*"})
        );
    }
}
```

### C-3　重點整理

| 項目 | 說明 |
|---|---|
| 合約 | `ActivityResultContracts.OpenDocument` |
| 啟動參數 | `String[]`（MIME types，例如 `{"application/pdf"}`） |
| 回傳 | `Uri?`（未選取為 `null`） |
| 權限 | 不需權限；可選用 `takePersistableUriPermission` 持久化 |
| 常見 MIME | `application/pdf`、`image/*`、`text/plain`、`*/*` |

### C-4　PickVisualMedia 與 OpenDocument 的差異

| 比較 | PickVisualMedia | OpenDocument |
|---|---|---|
| 目的 | 挑照片/影片（媒體庫） | 挑任意文件 |
| 介面 | 系統 Photo Picker | 系統文件瀏覽器 |
| 輸入 | `PickVisualMediaRequest` | `String[]`（MIME） |
| 持久權限 | 由系統處理 | 可 `takePersistableUriPermission` |

### C-5　練習題

1. 把 MIME 改成 `{"*/*"}`，觀察能否選到所有檔案。
2. 選檔後用 `ContentResolver.openInputStream(uri)` 讀出前 10 個位元組。
3. 比較 `OpenDocument` 與 `GetContent` 在「重開 App 後還能不能存取」上的差別。

---

## 5.5.D　拍照：TakePicture + FileProvider

### D-1　用途

`TakePicture` 會啟動相機 App 拍照，並把照片寫入**你提供的 Uri**。
因為 App 私有目錄（`getExternalFilesDir`）不能直接給相機寫入，必須透過 **FileProvider** 產生一個安全的 `content://` Uri。

### D-2　步驟總覽

1. 建立 `res/xml/file_paths.xml`（宣告可分享的目錄）。
2. 在 `AndroidManifest.xml` 註冊 `<provider>`。
3. 程式：建立暫存檔 → 用 `FileProvider.getUriForFile` 取得 Uri → 啟動 `TakePicture`。
4. 在 callback 用該 Uri 顯示圖片。

### D-3　`res/xml/file_paths.xml`

```xml
<?xml version="1.0" encoding="utf-8"?>
<paths xmlns:android="http://schemas.android.com/apk/res/android">
    <!-- 對應 getExternalFilesDir(Environment.DIRECTORY_PICTURES) -->
    <external-files-path name="my_images" path="Pictures/" />
</paths>
```

### D-4　`AndroidManifest.xml` 註冊 FileProvider

```xml
<application ...>

    <provider
        android:name="androidx.core.content.FileProvider"
        android:authorities="com.example.takepicturedemo.fileprovider"
        android:exported="false"
        android:grantUriPermissions="true">
        <meta-data
            android:name="android.support.FILE_PROVIDER_PATHS"
            android:resource="@xml/file_paths" />
    </provider>

</application>
```

> ⚠️ `android:authorities` 必須與程式碼中 `FileProvider.getUriForFile(..., "此字串", ...)` **完全一致**，
> 否則會拋 `IllegalArgumentException: Failed to find configured root`。

### D-5　完整程式碼

```java
package com.example.takepicturedemo;

import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.widget.Button;
import android.widget.ImageView;

import androidx.activity.result.ActivityResultLauncher;
import androidx.activity.result.contract.ActivityResultContracts.TakePicture;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.content.FileProvider;

import java.io.File;

public class MainActivity extends AppCompatActivity {

    private ImageView ivPhoto;
    private Uri pendingPhotoUri;   // 拍照要寫入的目標 Uri

    private final ActivityResultLauncher<Uri> takePictureLauncher =
        registerForActivityResult(new TakePicture(), success -> {
            if (success && pendingPhotoUri != null) {
                ivPhoto.setImageURI(pendingPhotoUri);
            }
        });

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        ivPhoto = findViewById(R.id.ivPhoto);
        Button btnTake = findViewById(R.id.btnTakePhoto);

        btnTake.setOnClickListener(v -> {
            try {
                // 1. 在私有圖片目錄建立一個暫存檔
                File photoFile = File.createTempFile(
                    "IMG_", ".jpg",
                    getExternalFilesDir(Environment.DIRECTORY_PICTURES));

                // 2. 換成 FileProvider 的安全 Uri（authorities 必須與 Manifest 一致）
                pendingPhotoUri = FileProvider.getUriForFile(
                    this,
                    "com.example.takepicturedemo.fileprovider",
                    photoFile);

                // 3. 啟動相機
                takePictureLauncher.launch(pendingPhotoUri);
            } catch (Exception e) {
                e.printStackTrace();
            }
        });
    }
}
```

### D-6　重點整理

| 項目 | 說明 |
|---|---|
| 合約 | `ActivityResultContracts.TakePicture` |
| 啟動參數 | `Uri`（照片輸出位置） |
| 回傳 | `boolean`（`true` 表拍照成功） |
| 必要設定 | `FileProvider` + `res/xml/file_paths.xml` |
| 一致性 | `android:authorities` ↔ `getUriForFile` 的 authorities |
| 存檔位置 | `getExternalFilesDir(Environment.DIRECTORY_PICTURES)` |

### D-7　練習題

1. 拍照成功後，用 `Toast` 顯示照片的實際檔案路徑。
2. 把存檔位置改成 `getCacheDir()`，並調整 `file_paths.xml` 為 `<cache-path>`。
3. 想一想：為什麼不能直接 `Uri.fromFile(photoFile)` 交給相機？（提示：`FileUriExposedException`）

---

## 5.5.E　三合一整合範例

以下 Activity 同時具備「選圖 / 選檔案 / 拍照」三個按鈕，是本章的整合練習。
版面沿用 `ivPhoto`、`tvFile` 與三個按鈕。

```java
package com.example.mediapickerdemo;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.activity.result.ActivityResultLauncher;
import androidx.activity.result.PickVisualMediaRequest;
import androidx.activity.result.contract.ActivityResultContracts.GetContent;
import androidx.activity.result.contract.ActivityResultContracts.OpenDocument;
import androidx.activity.result.contract.ActivityResultContracts.PickVisualMedia;
import androidx.activity.result.contract.ActivityResultContracts.TakePicture;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.content.FileProvider;

import java.io.File;

public class MainActivity extends AppCompatActivity {

    private ImageView ivPhoto;
    private TextView tvFile;
    private Uri pendingPhotoUri;

    // ① 選圖（新版）
    private final ActivityResultLauncher<PickVisualMediaRequest> pickMediaLauncher =
        registerForActivityResult(new PickVisualMedia(), uri -> {
            if (uri != null) ivPhoto.setImageURI(uri);
        });

    // ①' 選圖備援
    private final ActivityResultLauncher<String> getContentLauncher =
        registerForActivityResult(new GetContent(), uri -> {
            if (uri != null) ivPhoto.setImageURI(uri);
        });

    // ② 選檔案
    private final ActivityResultLauncher<String[]> openDocLauncher =
        registerForActivityResult(new OpenDocument(), uri -> {
            if (uri != null) {
                getContentResolver().takePersistableUriPermission(
                    uri, Intent.FLAG_GRANT_READ_URI_PERMISSION);
                tvFile.setText("已選擇檔案：\n" + uri);
            }
        });

    // ③ 拍照
    private final ActivityResultLauncher<Uri> takePictureLauncher =
        registerForActivityResult(new TakePicture(), success -> {
            if (success && pendingPhotoUri != null) {
                ivPhoto.setImageURI(pendingPhotoUri);
            }
        });

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        ivPhoto = findViewById(R.id.ivPhoto);
        tvFile  = findViewById(R.id.tvFile);

        findViewById(R.id.btnPickImage).setOnClickListener(v -> {
            if (PickVisualMedia.isPhotoPickerAvailable(this)) {
                pickMediaLauncher.launch(new PickVisualMediaRequest.Builder()
                    .setMediaType(PickVisualMedia.ImageOnly.INSTANCE).build());
            } else {
                getContentLauncher.launch("image/*");
            }
        });

        findViewById(R.id.btnOpenDoc).setOnClickListener(v ->
            openDocLauncher.launch(new String[]{"application/pdf", "image/*"}));

        findViewById(R.id.btnTakePhoto).setOnClickListener(v -> takePhoto());
    }

    private void takePhoto() {
        try {
            File photoFile = File.createTempFile(
                "IMG_", ".jpg",
                getExternalFilesDir(Environment.DIRECTORY_PICTURES));
            pendingPhotoUri = FileProvider.getUriForFile(
                this, "com.example.mediapickerdemo.fileprovider", photoFile);
            takePictureLauncher.launch(pendingPhotoUri);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
```

---

## 5.5.F　常見錯誤排查表

| 症狀 | 可能原因 | 解法 |
|---|---|---|
| `IllegalStateException: register while RESUMED` | 在點擊事件內才註冊 launcher | 改為欄位宣告或於 `onCreate` 註冊 |
| `Failed to find configured root` | `file_paths.xml` 沒對應目錄 | 補上正確的 `<external-files-path>` 等標籤 |
| `IllegalArgumentException`（拍照） | authorities 不一致 | Manifest 與 `getUriForFile` 字串需完全相同 |
| 選不到圖片 | 裝置無 Photo Picker 且未做備援 | 用 `isPhotoPickerAvailable` 切換 `GetContent` |
| 重開 App 讀不到檔案 | 未取持久化權限 | 呼叫 `takePersistableUriPermission` |
| `FileUriExposedException` | 直接使用 `Uri.fromFile` | 改用 `FileProvider.getUriForFile` |

---

## 5.5.G　驗收清單

- [ ] 選圖按鈕：Android 13+ 顯示系統 Photo Picker，舊機種自動退回 `GetContent`
- [ ] 選檔案按鈕：可挑 PDF / 圖片，並顯示 `content://` Uri
- [ ] 拍照按鈕：相機開啟、拍完照片顯示於 `ImageView`
- [ ] `file_paths.xml` 與 `AndroidManifest.xml` 的 provider 設定正確
- [ ] 無任何 `IllegalStateException` / `FileUriExposedException`

---

## 5.5.H　對照 Day 2 主教材

本章對應 `02_Day2_Complete.md`：

- 第 5 章「Intent 的其它用法」→ 系統 Intent（撥號、開網頁）
- **第 5.5 章「常用系統互動畫面（選擇器家族）」→ 本文件三支實作（選圖 / 選檔 / 拍照）**
- 第 6 章起 → `ListView` / `RecyclerView` 列表
