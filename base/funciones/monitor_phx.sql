CREATE OR REPLACE FUNCTION pxp.monitor_phx (
  integer
)
RETURNS integer
AS '/usr/local/lib/phx.so', 'monitor_phx'
    LANGUAGE c STRICT;
--
-- Definition for function trigger_usuario (OID = 304916) : 
--
