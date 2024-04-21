# snypix_flutter

Snypix App with Flutter 3.

## android packages

This app requires the following packages for the android development.

Path                                                  | Version | Description                                | Location
-------                                               | ------- | -------                                    | -------
build-tools;34.0.0                                    | 34.0.0  | Android SDK Build-Tools 34                 | build-tools\34.0.0
emulator                                              | 33.1.24 | Android Emulator                           | emulator
platform-tools                                        | 35.0.0  | Android SDK Platform-Tools                 | platform-tools
platforms;android-34                                  | 3       | Android SDK Platform 34                    | platforms\android-34
system-images;android-34;google_apis_playstore;x86_64 | 12      | Google Play Intel x86_64 Atom System Image | system-images\android-34\google_apis_playstore\x86_64

## android emulator

### avd

```
avdmanager.bat list avd
Available Android Virtual Devices:
    Name: flutter_emulator
  Device: pixel (Google)
  Target: Google Play (Google Inc.)
          Based on: Android 14.0 ("UpsideDownCake") Tag/ABI: google_apis_playstore/x86_64
  Sdcard: 512 MB
```

### hypervisor

The latest AEHD hypervisor is recommanded on windows. It can be downloaded from the following URL:
https://github.com/google/android-emulator-hypervisor-driver/releases

```
emulator-check.exe accel
accel:
0
AEHD (version 2.1) is installed and usable.
```