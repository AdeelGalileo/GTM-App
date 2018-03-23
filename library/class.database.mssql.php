<?php
class database
{
	public $db;
	private $_result;
	private $_total_rows;
	private $_affected_rows;
	
	function __construct($host, $user, $pass, $name){
		$this->user = $user;
		$this->pass = $pass;
		$this->host = $host;
		$this->dbname = $name;
		$this->connect();
	}
	
	function connect()
  	{
		$this->db = @mssql_connect($this->host, $this->user, $this->pass);
		if(!$this->db) {
			trigger_error('Can\'t Connect to MS Sql Database Server: '. $this->host .' With User Name: '. $this->user, E_USER_ERROR);
		}
		mssql_select_db($this->dbname, $this->db);
  	}
	
	function query($qry)
	{
		if(!$this->db) {
			$this->connect();
		}
		$result = mssql_query($qry);
		if(!$result) {
			trigger_error('Error in the Query: <b>'. $qry.'</b>' , E_USER_ERROR);
		}
		$this->_affected_rows = @mssql_rows_affected($this->db);
		$this->_total_rows = @mssql_num_rows($result);
		return $result;
	}
	function getTableFields($table)
	{
		$qry = 'sp_columns '.$table;
		$rslt = $this->getResultSet($qry);
		$fields = array();
		if(!$rslt) return false;
		foreach($rslt as $row){
			$fields[$row['COLUMN_NAME']] = array('dataType'=>$row['TYPE_NAME'], 'length'=>$row['DATA_TYPE']);
		}
		return $fields;
	}
	
	function getResultSet($queryString, $returnType = MSSQL_ASSOC) 
	{
		$result = $this->query($queryString);
		$rsltSet = array();
		$xx = 0 ;
		while ( $row = mssql_fetch_array($result, $returnType) ) {
			$rsltSet[$xx] = $row;
			$xx++;
		}
		mssql_free_result($result);
		return $rsltSet; 
	}
	
	function getSingleRow($queryString, $returnType = MSSQL_ASSOC)	//Retrieves a single record based on the query
  	{
		$result = $this->query($queryString);
		$row = mssql_fetch_array($result, $returnType);
   		mssql_free_result($result);
   		return $row;
  	}
	
	function insertDataId($queryString)
 	{
		$result = $this->query($queryString);
 		$idQry = 'SELECT @@IDENTITY';
		$idRslt = $this->query($idQry);
		$id = mssql_fetch_array($idRslt, MSSQL_NUM);
  		return $id[0];
	}
	
	function prepareQuery()
	{
		if(!$this->db) {
			$this->connect();
		}
		$args = func_get_args();
		//Arguments are passed from another function
		if(is_array($args[0])) {
			$args = $args[0];
		}
		if( count($args) == 0 ) {
			trigger_error('Query Must not empty to execute', E_USER_WARNING);
		}
		$qry = $args[0];
		//Shift the queue
		array_shift($args);
		//Make the arguments to be sql safe.
		$args = array_map(array($this, 'sqlSafe'), $args);
		
		array_unshift($args, $qry);
		//Make the Query using sprintf function.
		$qry = call_user_func_array('sprintf', $args);
		return $qry;
	}
	
	function sqlSafe($value, $quote="") 
	{
		if(is_array($value)) {
			array_map(array($this, 'sqlSafe'), $value);
		}
		// Stripslashes
		if (get_magic_quotes_gpc()) {
			$value = stripslashes($value);
		}
		$value = str_replace("'", "''", $value);
		return $value;
	}
	
	function get_affected_rows()
	{
		return $this->_affected_rows;
	}
	
	function get_total_rows()
	{
		return $this->_total_rows;
	}
	
	/* Make the fields to safe*/
	function fieldQuote($value)
	{
		return ('['.$value.']');
	}
	
	function __destruct()
	{
		if($this->db)
			mssql_close($this->db);
	}
}  //end of class database


?>
