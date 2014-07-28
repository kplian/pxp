#include "postgres.h"
#include <string.h>
#include "fmgr.h"
#include "utils/geo_decls.h"
#include <stdio.h>

#ifdef PG_MODULE_MAGIC
PG_MODULE_MAGIC;
#endif

/* by value */

PG_FUNCTION_INFO_V1(monitor_phx);

Datum
monitor_phx(PG_FUNCTION_ARGS)
{
    int32   arg = PG_GETARG_INT32(0);
    system("sudo /usr/local/lib/./phxbd.sh");
        PG_RETURN_INT32(arg);
}

