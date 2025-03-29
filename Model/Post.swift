import Foundation
import UIKit

struct Post: Identifiable, Codable {
    let id: UUID
    let title: String
    let contenido: String
    let fecha: Date
    let autor: String       // Ahora es un String
    let colonia: String
    let calle: String
    let tipo: PostType
    var imagenData: Data?
    var comentarios: [Comentario]

    var imagen: UIImage? {
        if let imagenData = imagenData {
            return UIImage(data: imagenData)
        }
        return nil
    }

    init(id: UUID = UUID(),
         title: String,
         contenido: String,
         fecha: Date = Date(),
         autor: String,
         colonia: String,
         calle: String,
         tipo: PostType,
         imagen: UIImage? = nil,
         comentarios: [Comentario] = []) {
        self.id = id
        self.title = title
        self.contenido = contenido
        self.fecha = fecha
        self.autor = autor
        self.colonia = colonia
        self.calle = calle
        self.tipo = tipo
        self.imagenData = imagen?.jpegData(compressionQuality: 0.8)
        self.comentarios = comentarios
    }
}

