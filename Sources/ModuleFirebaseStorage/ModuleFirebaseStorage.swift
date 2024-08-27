import FirebaseStorage

@available(iOS 15.0, *)
public enum ModuleFirebaseStorage {
    public static func helloWorlds(){
        Task {
            await ModuleFirebaseStorage.listRootFiles()
        }
    }
    
    private static func listRootFiles() async {
        let storage = Storage.storage()
        let reference = storage.reference()
        
        do {
            let result = try await reference.listAll()
            for item in result.items {
                print(item)
            }
        } catch {
            
        }
    }
}
