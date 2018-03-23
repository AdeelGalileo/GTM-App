<?php
class database
{
	public $db;
	private static $instance;
	public $_total_rows;
	public $_affected_rows;
	public $host;
	public $user;
	public $pass;
	public $dbname;
	
	public static function getInstance($host, $user, $pass, $name)
    {
        if (!self::$instance) { // If no instance then make one
            self::$instance = new self($host, $user, $pass, $name);
        }
        return self::$instance;
    }
	
	// Magic method clone is empty to prevent duplication of connection
    private function __clone()
    {
    }
	
	function __construct($host, $user, $pass, $name){
		$this->user   = $user;
		$this->pass   = $pass;
		$this->host   = $host;
		$this->dbname = $name;
		$this->connect();
	}
	/* Connect Database */
	function connect()
  	{
		$this->db = new mysqli($this->host, $this->user, $this->pass, $this->dbname);
		if(!$this->db) {
			trigger_error('Can\'t Connect to Mysql Database Server: '. $this->host .' With User Name: '. $this->user, E_USER_ERROR);
		}
		$this->db->query("SET NAMES 'utf8'");
  	}
	/* Execute the database query */
	function query($qry)
	{
		if(!$this->db) {
			$this->connect();
		}
		$result = @$this->db->query($qry);
		if(!$result) {
			trigger_error('Error in the Query: <b>'. $qry.'</b> with <br />Error: '. $this->db->error , E_USER_ERROR);
		}
		$this->_affected_rows = @$this->db->affected_rows;
		$this->_total_rows = @$result->num_rows;
		return $result;
	}
	/* Multi Query to get multi selects in a stored procedure */
	function multiQuery($qry)
	{
		if(!$this->db) {
			$this->connect();
		}
		$rslt = array();
		$cnt = 0;
		if ($this->db->multi_query($qry)) {
			do {
				/* store first result set */
				if ($result = $this->db->store_result()) {
					$rslt[$cnt] = array();
					while ($row = $result->fetch_assoc()) {
						array_push($rslt[$cnt], $row);
					}
					$result->close();
					$cnt++;
				}
			} while ($this->db->more_results() && $this->db->next_result());
		}
		array_walk_recursive($rslt, array('database','avoidSlashes'));
		return $rslt;
	}
	/* Get table fields */
	function getTableFields($table)
	{
		$qry = 'SHOW FIELDS FROM '.$table;
		//$rslt = $this->getResultSet($qry);
		$rslt = $this->getResultSet($qry);
		$fields = array();
		if(!$rslt) return false;
		//$expTypeSize = '/([a-z]+)\((\d+\))?|([a-z]+)/';
		$expTypeSize = '/([a-z]+)(\(\w+\))?/';
		foreach($rslt as $row){
			//$fields[$row['COLUMN_NAME']] = array('dataType'=>$row['TYPE_NAME'], 'length'=>$row['DATA_TYPE']);
			$matches = array();
			preg_match($expTypeSize, $row['Type'], $matches);
			//printInfo($matches);
			if(isset($matches[1])) {
				$fields[$row['Field']]['dataType'] = $matches[1];
			} 
			if(isset($matches[2])) {
				$fields[$row['Field']]['length'] = trim(trim($matches[2], ')'), '(');
			}
		}
		return $fields;
	}
	/* Get Result set as two dimensional array */
	function getResultSet($queryString, $returnType = MYSQL_ASSOC)
	{
		$recSet = $this->multiQuery($queryString);
		$result = $recSet[0];
		return $result;
	}
	
	/* Strip the slashed in data items */
	function avoidSlashes(&$item, $key)
	{
			$item = stripslashes($item);
	}
	/* Get Total number of rows for the given query excluding the limit condition */
	function getTotalRows($qry)
	{
		//Replace select clause with count function
		$qry = substr($qry, stripos($qry, 'FROM '));
		$qry = 'SELECT COUNT(1) as total '. $qry;
		//Remove the order by and Limit clauses
		$qry = preg_replace('/ORDER BY (.)*/', '', $qry);
		$qry = preg_replace('/LIMIT (.)*/', '', $qry);
		$result = $this->getSingleRow($qry);
      	return $result['total'];
	}
	/* Get Single Row of a record like array('title'=>'test', 'id' => 1) */
	function getSingleRow($queryString, $returnType = MYSQL_ASSOC)
  	{
		$recSet = $this->multiQuery($queryString);
		$row = $recSet[0][0];
   		return $row;
  	}
	
	/* Get the Insert Id for last insert query */
	function insertDataId($queryString = '')
 	{
		if($queryString) {
			$result = $this->query($queryString);
		}
 		$rslt = @$this->db->insert_id;
  		return $rslt;
	}
	/* Get total no. of affected rows in update/delete */
	function get_affected_rows()
	{
		return $this->_affected_rows;
	}
	/* Get total no. of rows in given select query*/
	function get_total_rows()
	{
		return $this->_total_rows;
	}
	/* Prepare the query string from given arguments */
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
		//If query arguments passed an array then make the array to sql safe.
		if(is_array($args[0])){
			$args = $args[0];
		}
		//Make the arguments to be sql safe.
		$args = array_map(array($this, 'sqlSafe'), $args);
		
		array_unshift($args, $qry);
		//Make the Query using sprintf function.
		$qry = call_user_func_array('sprintf', $args);
		return $qry;
	}
	/* avoid database hacking set data as safe */
	function sqlSafe($value, $quote="") 
	{
		if(is_array($value)) {
			array_map(array($this, 'sqlSafe'), $value);
		}
		//$value = str_replace(array("\'","'"),"&#39;",$value);
		// Stripslashes
		if(defined('get_magic_quotes_gpc')) {
			if (get_magic_quotes_gpc()) {
				$value = stripslashes($value);
			}
		}

		$value = $this->db->real_escape_string($value);
		$value = $quote . $value . $quote;
		return $value;
	}
	
	/* Make the fields to safe*/
	function fieldQuote($value)
	{
		return ('`'.$value.'`');
	}
	
	/* Destroy the database object */
	function __destruct()
	{
		if($this->db) 
			$this->db->close();
		$this->db = null;
	}
}  //end of class database
?>