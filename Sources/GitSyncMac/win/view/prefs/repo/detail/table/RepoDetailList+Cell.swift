/**
 * Cell
 */
extension RepoDetailList {
	/**
    * ReCycle cell
    */
	func onReuseCell(idx: Int) -> NSTableCell{
		let data: CellDataKind = rows[idx]
		let cell: CellKind = {
			if data is TextInputData {
				return TextInputCell()
			} else if data is ComboBoxInputData {
				return ComboboxInputCell()
			} else if data is CheckBoxInputData {
				return CheckBoxInputCell()
			}
		}()
		cell.data = data
	}
}
