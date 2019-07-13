/**
 * Cell
 */
extension PrefsList {
	/**
    * Recycle cell
    */
	func reuseCell(idx: Int) -> NSTableCell {
		let data: CellDataKind = rows[idx]
		let cell: CellKind = {
			if data is TextInputData {
				return TextInputCell()
			} else if data is CheckBoxInputData {
				return CheckBoxInputCell()
			}
		}()
		cell.data = data
	}
}
