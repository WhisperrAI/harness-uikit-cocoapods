# PodsShop (Whisperr harness fixture)

A small UIKit app with classic Xcode groups, CocoaPods (SnapKit) and a Gemfile.
It is one row of the nightly PR-agent harness in `WhisperrAI/whisperr-pr-agent-verify`.
Sign in, browse three products, check out, sign out. Not a real shop.

Build: `pod install`, then `xcodebuild build -workspace PodsShop.xcworkspace -scheme PodsShop -destination 'generic/platform=iOS Simulator' CODE_SIGNING_ALLOWED=NO`.
