class Section:Element {//Unlike Container, section can have a style applied
    init(_ width: Int, _ height: Int, _ style: IStyle) {
        <#code#>
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // this class exists because one shouldnt use the Element class as a holder of content
}