import FirebaseStorage

@available(iOS 15.0, *)
public enum ModuleFirebaseStorage {
    /**
     List root files
     */
    public static func listRootFiles() async -> [StorageReference]{
        let storage = Storage.storage()
        let reference = storage.reference()
        
        do {
            let result = try await reference.listAll()
            return result.items
        } catch {
            return []
        }
    }
}
