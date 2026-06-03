//
//  ClientsViewModel.swift
//  Relayance
//
//  Created by Jaouad on 23/05/2026.

// ViewModel unique — ObservableObject — gardien de la liste clients

import Foundation

final class ClientsViewModel: ObservableObject {
    @Published var clients: [Client]

    init(clients: [Client] = ModelData.chargement("Source.json")) {
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
        guard !clientDejaExistant(nom: nom, email: email) else { return }
        let nouveauClient = Client.creerNouveauClient(nom: nom, email: email)
        clients.append(nouveauClient)
    }

    func clientDejaExistant(nom: String, email: String) -> Bool {
        clients.contains { client in
            client.nom.lowercased() == nom.lowercased() &&
            client.email.lowercased() == email.lowercased()
        }
    }

    // MARK: - Suppression

    func supprimerClient(_ client: Client) {
        clients.removeAll { $0 == client }
    }
}
