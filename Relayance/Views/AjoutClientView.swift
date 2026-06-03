//
//  AjoutClientView.swift
//  Relayance
//
//  Created by Amandine Cousin on 10/07/2024.
//

import SwiftUI

struct AjoutClientView: View {
    @EnvironmentObject var viewModel: ClientsViewModel
    @Binding var dismissModal: Bool
    
    @State private var nom: String = ""
    @State private var email: String = ""
    @State private var afficherErreurEmail: Bool = false
    @State private var afficherErreurDoublon: Bool = false
    
    var body: some View {
        VStack {
            Text("Ajouter un nouveau client")
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)
            
            Spacer()
            
            TextField("Nom", text: $nom)
                .font(.title2)
                .textFieldStyle(.roundedBorder)
                .onChange(of: nom) {
                    afficherErreurDoublon = false
                }
            
            TextField("Email", text: $email)
                .font(.title2)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .onChange(of: email) {
                    afficherErreurEmail = false
                    afficherErreurDoublon = false
                }
            
            if afficherErreurEmail {
                Text("Format d'email invalide. Exemple : nom@domaine.com")
                    .font(.footnote)
                    .foregroundStyle(.red)
                    .multilineTextAlignment(.center)
                    .padding(.top, 4)
            }
            
            if afficherErreurDoublon {
                Text("Ce client existe déjà dans la liste.")
                    .font(.footnote)
                    .foregroundStyle(.red)
                    .multilineTextAlignment(.center)
                    .padding(.top, 4)
            }
            
            Button("Ajouter") {
                afficherErreurEmail = false
                afficherErreurDoublon = false
                
                guard viewModel.estEmailValide(email) else {
                    afficherErreurEmail = true
                    return
                }
                guard !viewModel.clientDejaExistant(nom: nom, email: email) else {
                    afficherErreurDoublon = true
                    return
                }
                viewModel.ajouterClient(nom: nom, email: email)
                dismissModal.toggle()
            }
            .disabled(nom.isEmpty || email.isEmpty)
            .padding(.horizontal, 50)
            .padding(.vertical)
            .font(.title2)
            .bold()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(nom.isEmpty || email.isEmpty ? Color.gray : Color.orange)
            )
            .foregroundStyle(.white)
            .padding(.top, 50)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    AjoutClientView(dismissModal: .constant(false))
        .environmentObject(ClientsViewModel())
}
