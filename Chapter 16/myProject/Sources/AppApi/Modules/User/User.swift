public enum User: ApiModuleInterface {
    
    public enum Account: ApiModelInterface {
        public typealias Module = User
    }
    
    public enum Token: ApiModelInterface {
        public typealias Module = User
    }
}
