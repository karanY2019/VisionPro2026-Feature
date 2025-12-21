//
//  TermsOfServiceView.swift
//  Floor
//
//  Created by Ryan Zhang on 2024/12/21.
//

import SwiftUI

struct TermsOfServiceView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var isPresented: Bool
    
    let termsOfService = """
        Last Updated: 2025.7.28
        
        Welcome to [Open 4 Home]. By using our app, you agree to these Terms of Service ("Terms"). Please read them carefully.
        
        1. User Eligibility
        You must be at least 13 years old to use the App. If you’re using the App on behalf of an organization, you confirm you have the authority to bind that organization to these Terms.
        
        2. Our Services
        [Open 4 Home] provides [e.g., a photo-sharing platform where you can upload, share, and comment on photos]. We may update, suspend, or discontinue any part of the App’s services at any time without prior notice.
        
        3. Your Account  
        - Keep your account credentials confidential and do not share them with others.  
        - You’re responsible for all activities under your account.  
        - We may suspend or terminate your account if we detect unauthorized use or violations of these Terms.
        
        4. Your Content  
        - License: When you upload content (e.g., photos, text), you grant us a non-exclusive, worldwide, royalty-free license to use, reproduce, distribute, and display it to provide and improve our services.  
        - Ownership: You confirm you own the rights to your content or have permission to upload it.  
        - Restrictions: Do not upload content that is illegal, defamatory, pornographic, or violates anyone’s rights.

        5. Prohibited Actions
        You may not:  
        - Disrupt the App’s functionality or servers.  
        - Engage in spamming, phishing, or malicious activities.  
        - Attempt unauthorized access to other users’ accounts.

        6. Our Liability 
        - We’re not responsible for damages, losses, or harm from your use of the App, including issues with content, service disruptions, or other users’ actions.  
        - Our liability is limited to the fees you paid for the App (if any) in the 12 months before any claim, to the extent allowed by law.

        7. Termination  
        - These Terms apply as soon as you use the App.  
        - We may terminate your access at any time, with or without notice, for any reason.  
        - Upon termination, your right to use the App ends immediately.

        8. Governing Law
        These Terms are governed by the laws of the jurisdiction where [Open 4 Home] is based. Any disputes will be resolved in the courts of that jurisdiction.
        
        9. Changes to These Terms
        We may update these Terms at any time. Changes will be posted in the App, and your continued use of the App means you accept the updated Terms.

        """
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                // xmark button
                Button(action: {
                    isPresented.toggle()
                }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.primary)
                }
                .frame(width: 44, height: 44)
                .background(Color.gray.opacity(0.1))
                .clipShape(Circle())
                
                Spacer()
                
                Text("Terms of Service")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
            }
            
            ScrollView {
                Text(termsOfService)
                    .font(.body)
                    .lineSpacing(4)
            }
        }
        .padding(24)
        
    }
}

#Preview {
    TermsOfServiceView(isPresented: Binding.constant(true))
}
