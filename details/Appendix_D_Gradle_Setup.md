# Appendix D：Gradle 設定細節

> 所有範例專案的 `build.gradle` 共用設定說明。

---

## 專案層 `build.gradle`（根目錄）

```groovy
// 通常不需動，僅定義 repositories
plugins {
    id 'com.android.application' version '8.2.0' apply false
    id 'org.jetbrains.kotlin.android' version '1.9.0' apply false
}
```

---

## 模組層 `app/build.gradle`（重點）

```groovy
plugins {
    id 'com.android.application'
}

android {
    namespace 'com.example.你的專案名'
    compileSdk 34

    defaultConfig {
        applicationId "com.example.你的專案名"
        minSdk 24
        targetSdk 34
        versionCode 1
        versionName "1.0"
        testInstrumentationRunner "androidx.test.runner.AndroidJUnitRunner"
    }

    buildTypes {
        release {
            minifyEnabled false
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
    }

    // ★★★ Java 8 支援（Lambda 必須）★★★
    compileOptions {
        sourceCompatibility JavaVersion.VERSION_1_8
        targetCompatibility JavaVersion.VERSION_1_8
    }

    // 如用 Kotlin 才需要 kapt；Java 專案用 annotationProcessor
    // kotlinOptions { jvmTarget = '1.8' }
}

dependencies {
    // ★ 基礎 UI ★
    implementation 'androidx.appcompat:appcompat:1.6.1'
    implementation 'com.google.android.material:material:1.9.0'
    implementation 'androidx.constraintlayout:constraintlayout:2.1.4'

    // ★ RecyclerView（列表）★
    implementation 'androidx.recyclerview:recyclerview:1.3.0'

    // ★ Room 資料庫（含編譯器）★
    def room_version = "2.6.1"
    implementation "androidx.room:room-runtime:$room_version"
    annotationProcessor "androidx.room:room-compiler:$room_version"
    // 如需 LiveData/RxJava 整合可再加：
    // implementation "androidx.room:room-rxjava3:$room_version"

    // ★ Activity Result API（新版 startActivityForResult）★
    implementation 'androidx.activity:activity:1.8.0'

    // 測試
    testImplementation 'junit:junit:4.13.2'
    androidTestImplementation 'androidx.test.ext:junit:1.1.5'
    androidTestImplementation 'androidx.test.espresso:espresso-core:3.5.1'
}
```

---

## 關鍵設定對照

| 設定 | 用途 | 範例值 |
|---|---|---|
| `namespace` | 程式碼產生的 R 類別套件 | `com.example.bmiapp` |
| `applicationId` | 安裝到裝置上的唯一 ID | 同上（可不同） |
| `minSdk` | 最低支援 Android 版本 | `24` (Android 7.0) |
| `targetSdk` | 針對哪個版本編譯/測試 | `34` (Android 14) |
| `compileOptions` | **Lambda 必須** | `VERSION_1_8` |
| `room_version` | 統一版本號，避免不一致 | `2.6.1` |
| `annotationProcessor` | Java 專案 Room 編譯器 | **不是** `kapt` |

---

## 常見依賴版本（2024/09 穩定版）

| 庫 | 版本 | 備註 |
|---|---|---|
| AppCompat | 1.6.1 | 基礎 Activity/Theme |
| Material | 1.9.0 | Material Design 元件 |
| RecyclerView | 1.3.0 | 列表 |
| Room | 2.6.1 | 資料庫 |
| Activity | 1.8.0 | Result API |
| ConstraintLayout | 2.1.4 | 佈局（非本教學重點） |

> 版本號會隨時間更新，建議在 Android Studio → **File → Project Structure → Dependencies** 搜尋最新穩定版。

---

## 專案建立後的檢查步驟

1. 開啟 `app/build.gradle` → 確認上述 dependencies 都在
2. 點右上角 **Sync Now**
3. 若出現「Gradle sync failed」：
   - `File → Invalidate Caches / Restart`
   - 或刪除 `.gradle`、`build` 資料夾再 Sync