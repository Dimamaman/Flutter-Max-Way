package com.example.flutter_max_way

import io.flutter.embedding.android.FlutterActivity
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import com.yandex.mapkit.MapKitFactory

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
//        MapKitFactory.setLocale("2d64ed60-01a7-469b-b432-89a61d1c35c0") // Your preferred language. Not required, defaults to system language
        MapKitFactory.setApiKey("2d64ed60-01a7-469b-b432-89a61d1c35c0") // Your generated API key
        super.configureFlutterEngine(flutterEngine)
    }
}
