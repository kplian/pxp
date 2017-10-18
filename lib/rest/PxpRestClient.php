<?php
/***
 Name: PxpRestClient
 Description: Allow connections to RESTFUL services
 Autor:	Kplian (JRR) based on https://bitbucket.org/gonzalo123/gam_http/overview
 Fecha:	30/06/2010
 */
class PxpRestClient
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
    static public function connect($host, $base_url='', $port = 80, $protocol = self::HTTP)
    {    	
        return new self($host, $base_url, $port, $protocol);
    }    
    protected function __construct($host, $base_url='', $port, $protocol)
    {    	
    	if ( !function_exists('sys_get_temp_dir'))
			$this->_cookie_file = "/tmp/cookie_" . uniqid('pxp') . ".txt";
		else 
			$this->_cookie_file = sys_get_temp_dir() . "/cookie_" . uniqid('pxp') . ".txt";			
    	
    	if (is_readable($this->_cookie_file))
    		unlink($this->_cookie_file);     
        $this->_host     = $host;
        $this->_port     = $port;
        $this->_protocol = $protocol;
		$this->_base_url = $base_url;		
    }
    
    public function setCredentialsPxp($user, $pass)
    {
    	
    	if (!extension_loaded('mcrypt')) {			
		    throw new Exception('El modulo mcrypt no esta instalado en el cliente REST. No es posible realizar una petición REST en este momento', 2);			 
		}
		
    	$prefix = uniqid('pxp');
    	$this->_pxp = true;
		$this->_pass = md5($pass);
		
        $this->_user = $this->fnEncrypt($prefix . '$$' . $user, $this->_pass);
		
		$this->addHeader("Pxp-user: $user");
        $this->_pass = $this->fnEncrypt($prefix . '$$' . $this->_pass, $this->_pass);
		
        return $this;
    }
	
	public function setCredentials($user, $pass)
    {
        $this->_user = $user;
        $this->_pass = $pass;
        return $this;
    }
	
	private function fnEncrypt($sValue, $sSecretKey)
	{
	    return rtrim(
	        base64_encode(
	            mcrypt_encrypt(
	                MCRYPT_RIJNDAEL_256,
	                $sSecretKey, $sValue, 
	                MCRYPT_MODE_ECB, 
	                mcrypt_create_iv(
	                    mcrypt_get_iv_size(
	                        MCRYPT_RIJNDAEL_256, 
	                        MCRYPT_MODE_ECB
	                    ), 
	                    MCRYPT_RAND)
	                )
	            ), "\0"
	        );
	}
	
	private function fnDecrypt($sValue, $sSecretKey)
	{
	    return rtrim(
	        mcrypt_decrypt(
	            MCRYPT_RIJNDAEL_256, 
	            $sSecretKey, 
	            base64_decode($sValue), 
	            MCRYPT_MODE_ECB,
	            mcrypt_create_iv(
	                mcrypt_get_iv_size(
	                    MCRYPT_RIJNDAEL_256,
	                    MCRYPT_MODE_ECB
	                ), 
	                MCRYPT_RAND
	            )
	        ), "\0"
	    );
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
    public function doPost($url, $params=array())
    {
        return $this->_exec(self::POST, $this->_url($url), $params);
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

    /**
     * Builds absolute url 
     *
     * @param unknown_type $url
     * @return unknown
     */
    private function _url($url=null)
    {    	
    	return "{$this->_protocol}://{$this->_host}:{$this->_port}/{$this->_base_url}{$url}";
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
    private function _exec($type, $url, $params = array())
    {
        $headers = $this->_headers;
		$s = curl_init();
        
        if(!is_null($this->_user) && ($this->_first_connection || $this->_error_number == 1)){        	
           	curl_setopt($s, CURLOPT_USERPWD, $this->_user.':'.$this->_pass);
			$this->_first_connection = false;
        }
        switch ($type) {
            case self::DELETE:
                curl_setopt($s, CURLOPT_URL, $url . '?' . http_build_query($params));
                curl_setopt($s, CURLOPT_CUSTOMREQUEST, self::DELETE);
                break;
            case self::PUT:
                curl_setopt($s, CURLOPT_URL, $url);
                curl_setopt($s, CURLOPT_CUSTOMREQUEST, self::PUT);
                curl_setopt($s, CURLOPT_POSTFIELDS, $params);
                break;
            case self::POST:
                curl_setopt($s, CURLOPT_URL,$url);
                curl_setopt($s, CURLOPT_POST, true);
                curl_setopt($s, CURLOPT_POSTFIELDS, $params);
                break;
            case self::GET:
                curl_setopt($s, CURLOPT_URL, $url . '?' . http_build_query($params));
				
                break;
        }
        curl_setopt($s,CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($s, CURLOPT_RETURNTRANSFER, true);
		//curl_setopt($s, CURLOPT_HEADER, true);
        curl_setopt($s, CURLOPT_HTTPHEADER, $headers);
		curl_setopt ($s, CURLOPT_COOKIEJAR, $this->_cookie_file);		
		curl_setopt ($s, CURLOPT_COOKIEFILE, $this->_cookie_file);
        curl_setopt($s, CURLINFO_HEADER_OUT, true);

		
        $_out = curl_exec($s);
		
		
        $status = curl_getinfo($s, CURLINFO_HTTP_CODE);
        $information = curl_getinfo($s);
        //echo $url."   ".$status;
        //exit;
        //var_dump($information);
        //exit;
        curl_close($s);
		
        switch ($status) {
            case self::HTTP_OK:
				$this->_error_number = 0;				
            case self::HTTP_CREATED:
				$this->_error_number = 0;					
            case self::HTTP_ACEPTED:
				$this->_error_number = 0;					
                $out = $_out;
                break;
            default:
				if ($this->_error_number == 0 && $this->_pxp && strpos($_out, 'No hay una sesion')) {
					$this->_error_number++;
					$this->_exec($type, $url, $params);
				}									
                $out = $_out;
				break;               
        }
		
        return $out;
    }      
}
?>