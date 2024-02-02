//
//  SingleParagraphView.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 14.01.24.
//

import SwiftUI

struct SingleParagraphView: View {
    
    var paragraph: Paragraph
    @State var formattedHTML: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            if !paragraph.content.isEmpty && paragraph.order != 0 && paragraph.section != "Inhaltsübersicht" {
                VStack(alignment: .leading) {
                    Text(paragraph.title.isEmpty ? "\(paragraph.section)" : "\(paragraph.section) - \(paragraph.title)")
                        .fontWeight(.heavy)
                    
                    Divider()
                        .padding(.bottom, 5)
                    
                    Text(formattedHTML)
                        .lineSpacing(2.0)
                        .font(.system(size: 18))
                        .fontWeight(.medium)
                }
            }
        }
        .onAppear {
            formattedHTML = paragraph.content.html2String
        }
    }
}

