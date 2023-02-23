//
//  JustifedText.swift
//  TMDB
//
//  Created by jc.kim on 2/23/23.
//

import UIKit
import SwiftUI

struct JustifiedText: UIViewRepresentable {
  private let text: String
  private let font: UIFont

    init(_ text: String, font: UIFont = .preferredFont(forTextStyle: .body)) {
    self.text = text
    self.font = font
  }

  func makeUIView(context: Context) -> UITextView {
    let textView = UITextView()
    textView.font = font
    textView.textAlignment = .justified
    return textView
  }

  func updateUIView(_ uiView: UITextView, context: Context) {
    uiView.text = text
  }
}
