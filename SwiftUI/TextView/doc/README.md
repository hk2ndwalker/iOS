# TextView.swift
## Overview
UITextViewに以下4つの機能を加えたPlaceholderTextViewと、それをSwiftUIのView階層に載せられるようにUIViewRepresentableを実装したTextViewです。
・Placeholderが付いている
・独自ボタンが乗ったInputAccessoryView
・ハードウェアキーボードが接続された場合のInputAccessoryViewのSafe Area考慮
・TextViewから変更と終了のイベントを受けられる

Xcode 11.4.1 にて動作確認済み。

## Demo
![demo](https://github.com/hk2ndwalker/iOS/blob/master/SwiftUI/TextView/doc/textview.gif)

## Usage
プロジェクトに組み込むなり、コードをコピペするなりしてお使いください。

## Note
ご自由に使用いただいて構いませんが、問題等が生じた際の責任は当方は一切負いません。