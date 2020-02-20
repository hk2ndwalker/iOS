//
//  FontListView.swift
//  LearnSwiftUI
//
//  Created by KITANO on 2020/02/18.
//  Copyright © 2020 kitano. All rights reserved.
//

import SwiftUI
import Combine
import UIKit

struct FontData: Identifiable {
    var id: String = UUID().uuidString
    var fontName: String
}

class FontListViewModel: ObservableObject {
    
    @Published var filterText = ""
    @Published var sampleText = "あア亜aＡ"
    @Published var fontSize: CGFloat = 16.0
    @Published var fonts: Array<FontData> = []

    var strFontSize: String {
        get {
            return String(format: "%.1f", Double(fontSize))
        }
    }

    private var allFonts: Array<FontData> = []
    private var cancellables: [AnyCancellable] = []
    
    init() {
        UIFont.familyNames.forEach {
            print("\($0)")
            UIFont.fontNames(forFamilyName: $0).forEach {
                print(" - \($0)")
                allFonts.append(FontData(fontName: $0))
            }
        }
        
        fonts = allFonts
        
        $filterText
            .collect(.byTime(DispatchQueue.global(), 1.0))
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] value in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.fonts = strongSelf.filterList(with: value.last!)
            })
            .store(in: &cancellables)
    }
    
    func filterList(with text: String) -> [FontData] {
        if text.count > 0 {
            return allFonts.filter {
                $0.fontName.range(of: text, options: .caseInsensitive) != nil
            }
        }
        else {
            return allFonts
        }
    }
}

struct FontListView: View {
    
    @ObservedObject var model: FontListViewModel
    
    var body: some View {
        VStack {
            VStack {
                HStack(alignment: .center, spacing: 8) {
                    Image(systemName: "magnifyingglass")
                        .frame(width: 32, height: 32)
                    TextField("Search", text: $model.filterText)
                }
                
                HStack(alignment: .center, spacing: 8) {
                    Image(systemName: "text.bubble")
                        .frame(width: 32, height: 32)
                    TextField("Sample", text: $model.sampleText)
                }
                
                HStack(alignment: .center, spacing: 8) {
                    Image(systemName: "textformat.size")
                        .frame(width: 32, height: 32)
                    Text(self.model.strFontSize)
                        .frame(width: 48, alignment: .center)
                    Slider(value: $model.fontSize, in: 5.0...50.0, step: 1.0)
                }
            }
            .padding(.horizontal, 16)

            List(model.fonts) {
                Text("\(self.model.sampleText) - \($0.fontName)")
                    .font(Font(UIFont(name: $0.fontName, size: self.model.fontSize)!))
            }
        }
    }
}

struct FontListView_Previews: PreviewProvider {
    static var previews: some View {
        FontListView(model: FontListViewModel())
    }
}
