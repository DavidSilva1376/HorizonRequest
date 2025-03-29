import Foundation
import SwiftUI

class FeedViewModel: ObservableObject {
    @Published var postsPorMunicipio: [String: [Post]] = [:]
    @Published var searchText: String = ""
    private let storageKey = "savedPosts"
    
    init() {
        cargarPosts()
    }
    
    func obtenerPostsParaMunicipio(_ municipio: Municipio) -> [Post] {
        return postsPorMunicipio[municipio.nombre] ?? []
    }
    
    func agregarPost(_ post: Post, en municipio: Municipio) {
        postsPorMunicipio[municipio.nombre, default: []].append(post)
        guardarPosts()
    }
    
    private func guardarPosts() {
        if let encoded = try? JSONEncoder().encode(postsPorMunicipio) {
            UserDefaults.standard.set(encoded, forKey: storageKey)
        }
    }
    
    private func cargarPosts() {
        if let savedData = UserDefaults.standard.data(forKey: storageKey),
           let decodedPosts = try? JSONDecoder().decode([String: [Post]].self, from: savedData) {
            postsPorMunicipio = decodedPosts
        }
    }
    
    func agregarComentario(_ comentario: Comentario, al postID: UUID, en municipio: Municipio) {
        if var posts = postsPorMunicipio[municipio.nombre] {
            if let index = posts.firstIndex(where: { $0.id == postID }) {
                posts[index].comentarios.append(comentario)
                postsPorMunicipio[municipio.nombre] = posts
                guardarPosts()
            }
        }
    }
}

