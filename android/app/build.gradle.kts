plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.sky.flutter_penguin"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

//    sourceSets {
//        main.java.srcDirs += 'src/main/kotlin'
//    }
//    signingConfigs {
//        penguin {
//            storeFile file("${rootDir}/keyStore/sky.jks")
//            storePassword localProperties.getProperty('storePassword')
//            keyAlias localProperties.getProperty('keyAlias')
//            keyPassword localProperties.getProperty('keyPassword')
//        }
//    }

    defaultConfig {
        applicationId = "com.sky.flutter_penguin"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
//        ndk {
//            abiFilters "armeabi-v7a", "arm64-v8a"
//        }
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }

//    buildTypes {
//        debug {
//            minifyEnabled false
//            signingConfig signingConfigs.penguin
//        }
//        release {
////            signingConfig signingConfigs.debug
//            minifyEnabled true
//            zipAlignEnabled true
//            signingConfig signingConfigs.penguin
//        }
//    }
}

flutter {
    source = "../.."
}
dependencies {

}
