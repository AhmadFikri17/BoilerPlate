plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    
    // TAMBAHKAN DI SINI
    id("com.google.gms.google-services")
}

android {
    namespace = "com.example.flutter_boilerplate_project"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.example.flutter_boilerplate_project"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

// TAMBAHKAN BLOK INI DI PALING BAWAH
dependencies {
    // Import the Firebase BoM (Gunakan tanda kurung untuk .kts)
    implementation(platform("com.google.firebase:firebase-bom:34.13.0"))

    // Add the dependencies for Firebase products
    implementation("com.google.firebase:firebase-analytics")
}