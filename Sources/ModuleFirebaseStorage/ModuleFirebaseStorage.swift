import FirebaseStorage

public enum ModuleFirebaseStorage {
    public static func helloWorlds(){
        ModuleFirebaseStorage.listRootFiles()
    }
    
    private static func listRootFiles() async {
        let storage = Storage.storage()
        let reference = storage.reference()
        
        do {
            let result = try await reference.listAll()
            for item in result.items {
                print(item)
            }
        }
    }
