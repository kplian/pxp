<?php
/***
Name: PxpRestClient
Description: Allow connections to RESTFUL services
Autor:	Kplian (JRR) based on https://bitbucket.org/gonzalo123/gam_http/overview
Fecha:	30/06/2010
 */
class NetOBRestClient
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
        return "{$this->_protocol}://{$this->_host}/{$this->_base_url}{$url}";
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


        switch ($type) {
            case self::DELETE:
                curl_setopt($s, CURLOPT_URL, $url . '?' . http_build_query($params));
                curl_setopt($s, CURLOPT_CUSTOMREQUEST, self::DELETE);
                break;
            case self::PUT:
                curl_setopt($s, CURLOPT_URL, $url);
                curl_setopt($s, CURLOPT_CUSTOMREQUEST, self::PUT);
                curl_setopt($s, CURLOPT_POSTFIELDS, json_encode($params));
                break;
            case self::POST:
                curl_setopt($s, CURLOPT_URL, $url);
                curl_setopt($s, CURLOPT_POST, true);
                curl_setopt($s, CURLOPT_POSTFIELDS, json_encode($params));
                break;
            case self::GET:
                curl_setopt($s, CURLOPT_URL, $url . '?' . http_build_query($params));

                break;
        }

        curl_setopt($s, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($s, CURLOPT_HTTPHEADER, array('Content-Type: application/json',
            'Content-Length: ' . strlen(json_encode($params))));

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