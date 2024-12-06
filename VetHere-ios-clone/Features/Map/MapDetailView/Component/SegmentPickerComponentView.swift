//
//  SegmentPickerView.swift
//  VetHereiOS
//
//  Created by Christian Gunawan on 30/10/24.
//

import SwiftUI

struct SegmentPickerComponentView: View {
  @Binding var selectedSegment: DetailEnum
  let segments = DetailEnum.allCases

  var body: some View {
    Picker("Options", selection: $selectedSegment) {
      ForEach(segments) { segment in
        Text(segment.rawValue).tag(segment)
      }
    }
    .pickerStyle(SegmentedPickerStyle())
    .padding()
  }
}
