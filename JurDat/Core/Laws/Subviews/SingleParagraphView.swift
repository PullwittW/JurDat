//
//  SingleParagraphView.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 14.01.24.
//

import SwiftUI

struct SingleParagraphView: View {
    
    var paragraph: SpecificLawbook
    @State var formattedHTML: String = ""
    
    var body: some View {
        VStack {
            if !paragraph.content.isEmpty && paragraph.order == 0 {
                Text(formattedHTML)
                    .lineSpacing(2.0)
                    .font(.system(size: 18))
                    .fontWeight(.semibold)
                Divider()
            }
            if !paragraph.content.isEmpty && paragraph.order != 0 {
                VStack(alignment: .leading) {
                    Text("\(paragraph.section) - \(paragraph.title)")
                        .fontWeight(.heavy)
                        .padding(.bottom, 5)
                    
                    Text(formattedHTML)
                        .lineSpacing(2.0)
                        .font(.system(size: 18))
                        .fontWeight(.medium)
                    Divider()
                }
            }
        }
        .onAppear {
            formattedHTML = paragraph.content.html2String
        }
    }
}

