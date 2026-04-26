# APK Parser 
[![Maven Central](https://maven-badges.herokuapp.com/maven-central/com.jaredrummler/apk-parser/badge.svg)](https://maven-badges.herokuapp.com/maven-central/com.jaredrummler/apk-parser) [![Software License](https://img.shields.io/badge/license-BSD%203%20Clause-blue.svg)](LICENSE.txt) [![Twitter Follow](https://img.shields.io/twitter/follow/jrummy16.svg?style=social)](https://twitter.com/jrummy16)

#### Features
* Retrieve basic `.apk` metas, such as `title`, `icon`, package `name`, `version`, etc...
* Parse and convert binary `.xml` file(s) to text 
* `Class`es from `.dex` file(s)
* Get certificate metas and verify APK signature

![](sample/graphics/apk_parser_sample.png)

## Get `apk-parser`
Download [the latest `.AAR`](https://repo1.maven.org/maven2/com/jaredrummler/apk-parser/1.0.2/apk-parser-1.0.2.aar) or grab via Gradle:

```groovy
compile 'com.jaredrummler:apk-parser:1.0.2'
```

## Usage
The easiest way is to use the `ApkParser` class, which contains convenient methods to get `AndroidManifest.xml`, APK meta infos, etc.

#### APK Meta Info
`ApkMeta` contains `name(label)`, `packageName`, `version`, sdk and used features, etc...

```java
PackageManager pm = getPackageManager();
ApplicationInfo appInfo = pm.getApplicationInfo("com.facebook.katana", 0);
ApkParser apkParser = ApkParser.create(appInfo);
ApkMeta meta = apkParser.getApkMeta();
String packageName = meta.packageName;
long versionCode = meta.versionCode;
List<UseFeature> usesFeatures = meta.usesFeatures;
List<String> requestedPermissions = meta.usesPermissions;
```

#### Get binary XML and manifest XML file

```java
ApplicationInfo appInfo = getPackageManager().getApplicationInfo("some.package.name", 0);
ApkParser apkParser = ApkParser.create(appInfo);
String readableAndroidManifest = apkParser.getManifestXml();
String xml = apkParser.transBinaryXml("res/layout/activity_main.xml");
```

#### Get DEX classes

```java
ApplicationInfo appInfo = getPackageManager().getApplicationInfo("com.instagram.android", 0);
ApkParser apkParser = ApkParser.create(appInfo);
List<DexInfo> dexFiles = apkParser.getDexInfos(); // if size > 1 then app is using multidex
for (DexInfo dexInfo : dexFiles) {
  DexClass[] dexClasses = dexInfo.classes;
  DexHeader dexHeader = dexInfo.header;
}
```

#### Get certificate and verify APK signature

```java
ApplicationInfo appInfo = getPackageManager().getApplicationInfo("com.instagram.android", 0);
ApkParser apkParser = ApkParser.create(appInfo);
if (apkParser.verifyApk() == ApkParser.ApkSignStatus.SIGNED) {
  System.out.println(apkParser.getCertificateMeta().signAlgorithm);
}
```

#### Get `intent-filters` from APK manifest:

```java
ApkParser parser = ApkParser.create(getPackageManager(), "com.android.settings");
AndroidManifest androidManifest = parser.getAndroidManifest();
for (AndroidComponent component : androidManifest.getComponents()) {
  if (!component.intentFilters.isEmpty()) {
    for (IntentFilter intentFilter : component.intentFilters) {
      // Got an intent filter for activity/service/provider/receiver.
    }
  }
}
```

#### Locales
APK's may return different infos (`title`, `icon`, etc.) for different regions and languages, which is 
determined by `Locales`.
If the `locale` is not set, the `"en_US"` locale(<code>Locale.US</code>) is used. You can set the 
locale like this:

```java
ApkParser apkParser = ApkParser.create(filePath);
apkParser.setPreferredLocale(Locale.SIMPLIFIED_CHINESE);
ApkMeta apkMeta = apkParser.getApkMeta();
```

The `PreferredLocale` parameter works for `getApkMeta`, `getManifestXml`, and other binary XML's.
`ApkParser` will find the best matching languages with the `locale` you specified.

If `locale` is set to `null`, `ApkParser` will not translate resource tag, just give the resource ID.
For example, APK's `title` will be `'@string/app_name'` instead of `'WeChat'`.

___

`ApkParser` is based on [`apk-parser`](https://github.com/CaoQianLi/apk-parser)
