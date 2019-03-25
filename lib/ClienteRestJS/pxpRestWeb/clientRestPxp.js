// ┌────────────────────────────────────────────────────────────────────┐ \\
// │ Favio Figueroa Penarrieta - JavaScript Library                     │
// ├────────────────────────────────────────────────────────────────────┤ \\
// │ Copyright © 2014 Disydes (http://disydes.com)                      │
// ├────────────────────────────────────────────────────────────────────┤ \\
// │ Vista para automatizar cualquier front end basado en jQuery        │ plugin para hacer peticiones ajax
// └────────────────────────────────────────────────────────────────────┘ \\

(function ($) {

    clientRestPxp = {



        //_host_completo: "192.168.12.50/kerp/",
        _host_completo: "cms.kplian.com",
        _protocol : "http",
        //_host : '192.168.12.50',
        _host : 'cms.kplian.com',
        _base_url : '',
       // _port : '80/kerp',
        _port : '80',
        _user : null,
        _pass : null,
        _pxp : false,
        _request_number : 1,
        _first_connection : true,
        _error_number : 0,
        _cookie_file : '',

        _connMultiple : false,
        _headers : {},

        HTTP  : 'http',
        HTTPS : 'https',



        _url:function(url)
        {
            var resp =this._protocol+"://"+config.ruta_servicio+"/"+url;
            return resp;
        },

        setCredentialsPxp:function(user, pass){
            this.pxp = true;
            this.pass = pass;
            this.user = user;
        },

        /**
         * setHeaders
         *
         * @param array $headers
         * @return Http
         */
        addHeader: function(headers){
           // Ext.apply(this._headers, headers);
            $.extend(this._headers, headers);
            return this;
        },
        /**
         * setHeaders
         *
         * @param array $headers
         * @return Http
         */
        setHeaders : function(headers)
        {
            this._headers = headers;
            return this;
        },

        /**
         * setHeaders
         *
         * @param array $headers
         * @return Http
         */
        getHeaders : function(headers)
        {
            return this._headers;

        },

        genHeaders : function(){
            var prefix = this.uniqid('pxp');
            this.pxp = true;
            this._user = this.fnEncrypt(prefix + '$$' + this.user, this.pass);
            console.log("base",this._user)
            // this._pass = this.fnEncrypt(prefix + '$$' + this.pass, this.pass);

            this.addHeader({"Pxp-user":this.user});
            this.addHeader({"Php-Auth-User":this._user});
            //this.addHeader({"Php-Auth-Pw":this._pass});

            console.log('this._user',this._user)
            //console.log('this._pass',this._pass)

            return this._headers
        },


        fnEncrypt: function($sValue, $sSecretKey){

            return Base64.encode(mcrypt.Encrypt($sValue,undefined,$sSecretKey,'rijndael-256','ecb'));
        },

        uniqid: function (prefix, more_entropy) {
            //  discuss at: http://phpjs.org/functions/uniqid/
            // original by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
            //  revised by: Kankrelune (http://www.webfaktory.info/)
            //        note: Uses an internal counter (in php_js global) to avoid collision
            //        test: skip
            //   example 1: uniqid();
            //   returns 1: 'a30285b160c14'
            //   example 2: uniqid('foo');
            //   returns 2: 'fooa30285b1cd361'
            //   example 3: uniqid('bar', true);
            //   returns 3: 'bara20285b23dfd1.31879087'

            if (typeof prefix === 'undefined') {
                prefix = '';
            }

            var retId;
            var formatSeed = function(seed, reqWidth) {
                seed = parseInt(seed, 10)
                    .toString(16); // to hex str
                if (reqWidth < seed.length) { // so long we split
                    return seed.slice(seed.length - reqWidth);
                }
                if (reqWidth > seed.length) { // so short we pad
                    return Array(1 + (reqWidth - seed.length))
                            .join('0') + seed;
                }
                return seed;
            };

            // BEGIN REDUNDANT
            if (!this.php_js) {
                this.php_js = {};
            }
            // END REDUNDANT
            if (!this.php_js.uniqidSeed) { // init seed with big random int
                this.php_js.uniqidSeed = Math.floor(Math.random() * 0x75bcd15);
            }
            this.php_js.uniqidSeed++;

            retId = prefix; // start with prefix, add current milliseconds hex string
            retId += formatSeed(parseInt(new Date()
                .getTime() / 1000, 10), 8);
            retId += formatSeed(this.php_js.uniqidSeed, 5); // add seed hex string
            if (more_entropy) {
                // for more entropy we add a float lower to 10
                retId += (Math.random() * 10)
                    .toFixed(8)
                    .toString();
            }

            return retId;
        }

    };


})
(jQuery);