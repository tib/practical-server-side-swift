enum User: ApiModuleInterface {
    
    enum Account: ApiModelInterface {
        typealias Module = User
    }
    
    enum Token: ApiModelInterface {
        typealias Module = User
    }
}
