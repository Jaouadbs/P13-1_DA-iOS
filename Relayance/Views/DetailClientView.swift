//
//  DetailClientView.swift
//  Relayance
//
//  Created by Amandine Cousin on 10/07/2024.
//

import SwiftUI

struct DetailClientView: View {
    @EnvironmentObject var viewModel: ClientsViewModel
    @Environment(\.dismiss) var dismiss
    var client: Client

    var body: some View {
        VStack {
            Image(systemName: "person.circle")
                .resizable()
                .frame(width: 150, height: 150)
                .foregroundStyle(.orange)
                .padding(50)

            Spacer()

            Text(client.nom)
                .font(.title)
                .padding()

            Text(client.email)
                .font(.title3)

            Text(client.formatDateVersString())
                .font(.title3)
            if client.estNouveauClient() {
                Label("Nouveau client", systemImage: "star.fill")
                    .foregroundStyle(.orange)
                    .padding(.top, 8)
            }
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Supprimer") {
                    // suppression
                    viewModel.supprimerClient(client)
                    dismiss()
                }
                .foregroundStyle(.red)
                .bold()
            }
        }
    }
}

#Preview {
    NavigationStack {
        DetailClientView(
            client: Client(
                nom: "Tata",
                email: "tata@email",
                dateCreationString: "20:32 Wed, 30 Oct 2019"
            )
        )
        .environmentObject(ClientsViewModel())
    }

}
