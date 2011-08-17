package saz.collections {
	
	/**
	 * IdCollection.getInstance().getItemのショートカット. 
	 * @copy	IdCollection#getItem
	 */
	public function getItemById( id:String ):Object {
		return IdCollection.getInstance().getItem(id);
	}

}