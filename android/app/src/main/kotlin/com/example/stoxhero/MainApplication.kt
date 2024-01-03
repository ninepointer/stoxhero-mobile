package com.stoxhero.app;
import io.flutter.app.FlutterApplication;
import com.webengage.webengage_plugin.WebengageInitializer;
import com.webengage.sdk.android.WebEngageConfig;
import com.webengage.sdk.android.WebEngage;

class MainApplication : FlutterApplication() {

override fun onCreate() {
        super.onCreate()
        val webEngageConfig = WebEngageConfig.Builder()
            .setWebEngageKey("in~~c2ab36a9")
            .setAutoGCMRegistrationFlag(false)
            .setDebugMode(true) // only in development mode
            .build()
        WebengageInitializer.initialize(this, webEngageConfig)
    }
}