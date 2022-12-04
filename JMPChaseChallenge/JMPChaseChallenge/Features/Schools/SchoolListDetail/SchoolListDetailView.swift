//
//  SchoolListDetailView.swift
//  JMPChaseChallenge
//
//  Created by Yangbin Wen on 12/3/22.
//

import SwiftUI

struct SchoolListDetailView: View {
    @ObservedObject var viewModel: SchoolListDetailViewModel
    
    var body: some View {
        Spacer(minLength: 50)
        VStack(alignment: .center, spacing: UIConstants.marginExtraBig) {
            Text(viewModel.schoolName)
                .font(.system(size: UIConstants.fontSizeTitle, weight: .bold))
            
            Text("Number of SAT testers: \(viewModel.numberOfTesters)")
                .font(.system(size: UIConstants.fontSizeContent, weight: .regular))
            
            HStack {
                VStack(spacing: UIConstants.mrginMedium) {
                    Text("Math Avg")
                        .font(.system(size: UIConstants.fontSizeContent, weight: .regular))
                    Text(viewModel.mathAvg)
                        .font(.system(size: UIConstants.fontSizeContent, weight: .regular))
                }
                .padding([.all], UIConstants.mrginSmall)
                .frame(width: 100)
                .borderedCaption()
                
                VStack(spacing: UIConstants.mrginMedium) {
                    Text("Reading Avg")
                        .font(.system(size: UIConstants.fontSizeContent, weight: .regular))
                    Text(viewModel.readingAvg)
                        .font(.system(size: UIConstants.fontSizeContent, weight: .regular))
                }
                .padding([.all], UIConstants.mrginSmall)
                .frame(width: 100)
                .borderedCaption()
                
                VStack(spacing: UIConstants.mrginMedium) {
                    Text("Writing Avg")
                        .font(.system(size: UIConstants.fontSizeContent, weight: .regular))
                    Text(viewModel.writingAvg)
                        .font(.system(size: UIConstants.fontSizeContent, weight: .regular))
                }
                .padding([.all], UIConstants.mrginSmall)
                .frame(width: 100)
                .borderedCaption()
            }
            
            Spacer()
        }
    }
}

struct SchoolListDetailView_Previews: PreviewProvider {
    static let viewModel = SchoolListDetailViewModel(schoolModel: .init())
    
    static var previews: some View {
        SchoolListDetailView(viewModel: viewModel)
    }
}

