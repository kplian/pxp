<?php
/***
Name: ClienteSiga
Description: 
Autor:	Kplian (RAC) basado en PxpRestClient de  JRR 
Fecha:	01/09/2017
 */
class ClienteSiga
{
    private $_host = null;
    private $_base_url = null;
    private $_port = null;
    private $_user = null;
    private $_pass = null;
    private $_protocol = null;
    private $_pxp = false;
    private $_request_number = 1;
    private $_first_connection = true;
    private $_error_number = 0;
    private $_cookie_file = '';
	private $retval = '';
	

    const HTTP  = 'http';
    const HTTPS = 'https';


    private $_connMultiple = false;
    /**
     * Factory of the class. Lazy connect
     *
     * @param string $host
     * @param integer $port
     * @param string $user
     * @param string $pass
     * @return Http
     */
    static public function connect($host, $base_url='', $port = 80, $protocol = self::HTTPS)
    {
        return new self($host, $base_url, $port, $protocol);
    }
	
	protected function __construct($host, $base_url='', $port, $protocol)
    {    	
    	if ( !function_exists('sys_get_temp_dir'))
			$this->_cookie_file = "/tmp/cookie_" . uniqid('siga') . ".txt";
		else 
			$this->_cookie_file = sys_get_temp_dir() . "/cookie_" . uniqid('pxp') . ".txt";			
    	
    	if (is_readable($this->_cookie_file))
    		unlink($this->_cookie_file);     
        $this->_host     = $host;
        $this->_port     = $port;
        $this->_protocol = $protocol;
		$this->_base_url = $base_url;		
    }
	
	
   


    const POST   = 'POST';
    const GET    = 'GET';
    const DELETE = 'DELETE';
    const PUT    = 'PUT';


    /**
     * PUT request
     *
     * @param string $url
     * @param array $params
     * @return string
     */
    public function doPut($url, $params=array())
    {
        return $this->_exec(self::PUT, $this->_url($url), $params);
    }

    /**
     * POST request
     *
     * @param string $url
     * @param array $params
     * @return string
     */
    public function doPost($url, $params=array(), $typeForm='json')
    {
        return $this->_exec(self::POST, $this->_url($url), $params, $typeForm);
    }
	
	/**
     * POST request
     *
     * @param string $url
     * @param array $params
     * @return string
     */
    public function doPostMultipart($url, $boundary)
    {
        return $this->_exec(self::POST, $this->_url($url), $params, 'multipart2', $boundary);
    }

    /**
     * GET Request
     *
     * @param string $url
     * @param array $params
     * @return string
     */
    public function doGet($url, $params=array())
    {
        return $this->_exec(self::GET, $this->_url($url), $params);
    }

    /**
     * DELETE Request
     *
     * @param string $url
     * @param array $params
     * @return string
     */
    public function doDelete($url, $params=array())
    {
        return $this->_exec(self::DELETE, $this->_url($url), $params);
    }

    private $_headers = array();
    /**
     * setHeaders
     *
     * @param array $headers
     * @return Http
     */
    public function setHeaders($headers)
    {
        $this->_headers = $headers;
        return $this;
    }

    /**
     * setHeaders
     *
     * @param array $headers
     * @return Http
     */
    public function addHeader($header)
    {
        array_push($this->_headers,$header);
        return $this;
    }
	
	public function clearHeader()
    {
        $this->_headers = array();
        return $this;
    }
	

    /**
     * Builds absolute url
     *
     * @param unknown_type $url
     * @return unknown
     */
    private function _url($url=null)
    {
        return "{$this->_protocol}://{$this->_host}/{$this->_base_url}{$url}";
    }
	
	function getPart($name, $value, $boundary)
	{
	  $eol = "\r\n";
	
	  $part = '--'. $boundary . $eol;
	  $part .= 'Content-Disposition: form-data; name="' . $name . '"' . $eol;
	  $part .= 'Content-Length: ' . strlen($value) . $eol . $eol;
	  $part .= $value . $eol;
	
	  return $part;
	}

	
	function getBody2($boundary)
	{
	  $eol = "\r\n";
	
	  $body = getPart('a', 'b', $boundary);
	  $body .= getPart('c', 'd', $boundary);
	  $body .= '--'. $boundary . '--' . $eol;
	
	  return $body;
	}
	

	function multipart_build_query($fields, $boundary){
	  $retval = '';
	  $eol = "\r\n";
	  foreach($fields as $key => $value){
	    $retval .= "--$boundary".$eol."Content-Disposition: form-data; name=\"$key\"".$eol.$eol.$value.$eol;
	  }
	  $retval .= "--$boundary--".$eol;
	  return $retval;
	}
	
	function clearRetval(){
		$this->retval = '';
	}
	
	function addParamMultipart($boundary, $key,$value){
		$eol = "\r\n";
		$this->retval.=$retval .= "--$boundary".$eol."Content-Disposition: form-data; name=\"$key\"".$eol.$eol.$value.$eol;
	}
	function getBody($boundary){
		$this->retval.= "--$boundary--".$eol;
		//echo "<BR>".$this->retval."<BR>";
		return  $this->retval;
	}

    const HTTP_OK = 200;
    const HTTP_CREATED = 201;
    const HTTP_ACEPTED = 202;

    /**
     * Performing the real request
     *
     * @param string $type
     * @param string $url
     * @param array $params
     * @return string
     */
    private function _exec($type, $url, $params = array(),$typeForm='json',$boundary='')
    {

        $headers = $this->_headers;

        $s = curl_init();


        switch ($type) {
            case self::DELETE:
                curl_setopt($s, CURLOPT_URL, $url . '?' . http_build_query($params), $type='json');
                curl_setopt($s, CURLOPT_CUSTOMREQUEST, self::DELETE);
                break;
            case self::PUT:
                curl_setopt($s, CURLOPT_URL, $url);
                curl_setopt($s, CURLOPT_CUSTOMREQUEST, self::PUT);
                curl_setopt($s, CURLOPT_POSTFIELDS, json_encode($params));
                break;
            case self::POST:
                curl_setopt($s, CURLOPT_URL, $url);
                if($typeForm =='json'){
                	
					curl_setopt($s, CURLOPT_POST, true);
				    curl_setopt($s, CURLOPT_POSTFIELDS, json_encode($params));
		        }
				else if($typeForm =='multipart'){
					
					curl_setopt($s, CURLOPT_CUSTOMREQUEST, 'POST');
				    $boundary = md5(time());
                    $body = $this->multipart_build_query($params, $boundary);
					curl_setopt($s, CURLOPT_POSTFIELDS, $body);
					array_push($headers,"Content-Type: multipart/form-data; boundary=$boundary");
					
		        }
				else{
					curl_setopt($s, CURLOPT_CUSTOMREQUEST, 'POST');
				    curl_setopt($s, CURLOPT_POSTFIELDS, $this->getBody($boundary));
					array_push($headers,"Content-Type: multipart/form-data; boundary=$boundary");
					
				}
                
                
                break;
            case self::GET:
                curl_setopt($s, CURLOPT_URL, $url . '?' . http_build_query($params));

                break;
        }

        curl_setopt($s, CURLOPT_RETURNTRANSFER, true);
		
		curl_setopt($s, CURLOPT_HTTPHEADER, $headers);
		
		
		/*curl_setopt($s, CURLOPT_HTTPHEADER, array('Content-Type: application/json',
            'Content-Length: ' . strlen(json_encode($params))));*/
		
		curl_setopt ($s, CURLOPT_COOKIEJAR, $this->_cookie_file);		
		curl_setopt ($s, CURLOPT_COOKIEFILE, $this->_cookie_file);
        curl_setopt($s, CURLINFO_HEADER_OUT, true);
       

        $_out = curl_exec($s);


        $status = curl_getinfo($s, CURLINFO_HTTP_CODE);


        curl_close($s);

        switch ($status) {

            case self::HTTP_ACEPTED:
                $out = $_out;
                break;
            default:
                $out = $_out;
                break;
        }

        return $out;
    }
}
?>