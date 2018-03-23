<?php
class table
{
	protected $db;
	protected $table;
	protected $fields;
	protected $intFields;
	public $params;
	/* Create table object */
	function __construct($database, $table)
	{
		$this->db = $database;
		$this->table = $table;
		$this->fields = $this->db->getTableFields($table);
		$this->intFields = array('int' , 'bigint', 'tinyint', 'smallint', 'decimal', 'float', 'numeric', 'int identity');
	}
	/* Set parameters for the tabale */
	function setParams($params)
	{
		$this->params = $params;
	}
	/* Insert a record in the table and return the insert id */
	function insertRecord($object, $table = '')
	{
		$table = $table ? $table : $this->table;
		$fmtsql = 'INSERT IGNORE INTO '. $table.' ( %s ) VALUES ( %s ) ';
		$fields = array();
		foreach ($object as $k => $v) {
			if (is_array($v) or is_object($v) or $v === NULL) {
				continue;
			}
			if ($k[0] == '_') { // internal field
				continue;
			}
			$fields[] = $this->db->fieldQuote($k);
			//Check the field is not an integer to make the value in quoutes
			if(!in_array($this->fields[$k]['dataType'], $this->intFields)){
				$values[] = "'".$this->db->sqlSafe( $v )."'";
			} else {
				$values[] = $this->db->sqlSafe( $v );
			}
		}
		$query = ( sprintf( $fmtsql, implode( ",", $fields ) ,  implode( ",", $values ) ) );
		$id = $this->db->insertDataId($query);
		return $id;
	}
	
	/* Update the record using given params and primary key */
	function updateRecord( $object, $keyName, $updateNulls=true )
	{
		$fmtsql = 'UPDATE '.$this->table.' SET %s WHERE %s';
		$tmp = array();
		foreach ($object as $k => $v) {
			if( is_array($v) or is_object($v) or $k[0] == '_' ) { // internal or NA field
				continue;
			}
			if(is_array($keyName) && in_array($k, $keyName)){
				if(in_array($this->fields[$k]['dataType'], $this->intFields)){
					$where[] = $k . '=' . $this->db->sqlSafe( $v );
				} else {
					$where[] = $k . '=' . $this->db->sqlSafe($v, "'");
				}
				continue;
			} elseif( $k == $keyName ) { // PK not to be updated
				if(in_array($this->fields[$k]['dataType'], $this->intFields)){
					$where = $k . '=' . $this->db->sqlSafe( $v );
				} else {
					$where = $k . '=' . $this->db->sqlSafe($v, "'");
				}
				continue;
			}
			if ($v === null)
			{
				if ($updateNulls) {
					$val = 'NULL';
				} else {
					continue;
				}
			} else {
				$val = $this->db->sqlSafe( $v );
			}
			if(in_array($this->fields[$k]['dataType'], $this->intFields)){
				$tmp[] = $this->db->fieldQuote($k)  . '=' . $val;
			} else {
				$tmp[] = $this->db->fieldQuote($k)  . "='" . $val ."'";
			}
		}
		if(is_array($where)){
			$where = implode(' AND ', $where);
		}
		$qry =  sprintf( $fmtsql, implode( ",", $tmp ) , $where );
		
		
		$this->db->query($qry);
		return true;
	}
	
	/* Destruct the table object */
	function __destruct()
	{
		unset($this->db);
	}
	
}  //end of class table
?>