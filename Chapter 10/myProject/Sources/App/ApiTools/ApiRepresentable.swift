import Vapor

protocol ApiRepresentable: ListContentRepresentable,
    CreateContentRepresentable,
    UpdateContentRepresentable,
    PatchContentRepresentable,
    DeleteContentRepresentable
{}
