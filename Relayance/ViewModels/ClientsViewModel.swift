//
//  ClientsViewModel.swift
//  Relayance
//
//  Created by Jaouad on 23/05/2026.

// ViewModel unique — ObservableObject — gardien de la liste clients

import Foundation

final class ClientsViewModel: ObservableObject {
    @Published var clients: [Client]

    init(clients: [Client] = ModelData.chargement("clients.json")) {
        self.clients = clients
    }

    // MARK: - Validation

    func estEmailValide(_ email: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: email)
    }

    // MARK: - Ajout

    func ajouterClient(nom: String, email: String) {
        guard estEmailValide(email) else { return }
        let nouveauClient = Client.creerNouveauClient(nom: nom, email: email)
        guard !nouveauClient.clientExiste(clientsList: clients) else { return }
        clients.append(nouveauClient)
    }

    // MARK: - Suppression

    func supprimerClient(_ client: Client) {
        clients.removeAll { $0 == client }
    }
}
