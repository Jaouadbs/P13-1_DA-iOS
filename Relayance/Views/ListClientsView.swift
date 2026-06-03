//
//  ListClientsView.swift
//  Relayance
//
//  Created by Amandine Cousin on 10/07/2024.
// Jaouad, @State var clientsList → remplacé par @EnvironmentObject var viewModel
// la liste vient maintenant du ViewModel partagé, plus de chargement local.

import SwiftUI

struct ListClientsView: View {
    @EnvironmentObject var viewModel: ClientsViewModel
    @State private var showModal: Bool = false

    var body: some View {
        NavigationStack {
            List(viewModel.clients, id: \.self) { client in
                NavigationLink {
                    DetailClientView(client: client)
                } label: {
                    Text(client.nom)
                        .font(.title3)
                }
            }
            .navigationTitle("Liste des clients")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Ajouter un client") {
                        showModal.toggle()
                    }
                    .foregroundStyle(.orange)
                    .bold()
                }
            }
            .sheet(isPresented: $showModal, content: {
                AjoutClientView(dismissModal: $showModal)
            })
        }
    }

}

#Preview {
    ListClientsView()
        .environmentObject(ClientsViewModel())
}
