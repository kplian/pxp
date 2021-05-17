<?php

/**
 * FCM simple server side implementation in PHP
 *
 * @author Valvarado base Abhishek
 */
class Fcm
{
    private $ServerKey;
    private $url;

    public function __construct()
    {
        $this->url = $_SESSION["FIREBASE_URL"];
        $this->ServerKey = $_SESSION["FIREBASE_SERVER_KEY"];
    }

    /**
     * @return string
     */
    public function getTo()
    {
        return $this->to;
    }

    /**
     * @param string $to
     */
    public function setTo($to)
    {
        $this->to = $to;
    }

    /**
     * @return string
     */
    public function getRegistrationIds()
    {
        return $this->registrationIds;
    }

    /**
     * @param string $registrationIds
     */
    public function setRegistrationIds($registrationIds)
    {
        $this->registrationIds = $registrationIds;
    }

    /**
     * @return mixed
     */
    public function getTopic()
    {
        return $this->topic;
    }

    /**
     * @param mixed $topic
     */
    public function setTopic($topic)
    {
        $this->topic = $topic;
    }

    /**
     * @return string
     */
    public function getBody()
    {
        return $this->body;
    }

    /**
     * @param string $body
     */
    public function setBody($body)
    {
        $this->body = $body;
    }

    /**
     * @return string
     */
    public function getTitle()
    {
        return $this->title;
    }

    /**
     * @param string $title
     */
    public function setTitle($title)
    {
        $this->title = $title;
    }

    /**
     * @return array
     */
    public function getData()
    {
        return $this->data;
    }

    /**
     * @param array $data
     */
    public function setData($data)
    {
        $this->data = $data;
    }

    function send()
    {
        $headers = array(
            'Authorization: key=' . $this->ServerKey,
            'Content-Type: application/json',
        );
        $notification = array(
            "to" => $this->getTo(),
            "notification" => array(
                'title' => $this->getTitle(),
                "body" => $this->getBody(),
                "content_available" => true,
                "priority" => "high",
                "sound" => "default",
                "color" => "green",
                "vibrate" => 1
            ),
            "data" => $this->getData()
        );

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $this->url);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($notification));

        $result = curl_exec($ch);
        if ($result === false) {
            die('Curl failed: ' . curl_error($ch));
        }
        curl_close($ch);

        return $result;
    }
}
