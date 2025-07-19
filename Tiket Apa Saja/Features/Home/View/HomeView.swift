//
//  HomeView.swift
//  Tiket Apa Saja
//
//  Created by Intan Saliya Utomo on 07/07/25.
//

import SwiftUI

struct HomeView: View {
    @State var text: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: AppSizing.spacing0) {
            TopAppBar(text: $text)
            Divider()
                .frame(height: AppSizing.borderWidth25)
                .background(.gray4)
            
            Spacer()
        }
        .background(.gray1)
    }
}

struct TopAppBar: View {
    @Binding var text: String
    
    private let locationPrefix: String = "Near To"
    var locationName: String = "Balikpapan"
    
    var body: some View {
        VStack(alignment: .leading, spacing: AppSizing.spacing0) {
            HStack(alignment: .center, spacing: AppSizing.spacing200) {
                TASSearchBar(text: text)
                
                Image("product")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 24, height: 24)
                    .foregroundColor(.gray10)
                
                Image("notifications")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 24, height: 24)
                    .foregroundColor(.gray10)
            }
            .padding(.vertical, AppSizing.spacing200)
            .padding(.horizontal, AppSizing.spacing400)
            
            HStack(alignment: .center, spacing: AppSizing.spacing100) {
                Text(locationPrefix)
                    .font(.Caption1())
                    .foregroundColor(.gray10)
                
                Text(locationName)
                    .font(.Label2())
                    .foregroundColor(.gray11)
                
                Image("expand-more")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 16, height: 16)
                    .foregroundColor(.gray11)
            }
            .padding(.top, AppSizing.spacing150)
            .padding(.horizontal, AppSizing.spacing400)
            .padding(.bottom, AppSizing.borderRadius300)
        }
        .background(.gray3)
    }
}


#Preview {
    HomeView()
}
