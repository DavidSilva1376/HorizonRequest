import SwiftUI

class CrearPostViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var colonia: String = ""
    @Published var calle: String = ""
    @Published var tipo: PostType = .request
    @Published var imagen: UIImage?
    @Published var errorMessage: String?

    // Ahora, se espera que "autor" sea un String
    func crearPost(autor: String) -> Post? {
        guard !title.isEmpty, !description.isEmpty, !colonia.isEmpty, !calle.isEmpty else {
            errorMessage = "Todos los campos son obligatorios."
            return nil
        }

        let nuevoPost = Post(
            title: title,
            contenido: description,
            autor: autor,
            colonia: colonia,
            calle: calle,
            tipo: tipo,
            imagen: imagen
        )
        
        return nuevoPost
    }
}
