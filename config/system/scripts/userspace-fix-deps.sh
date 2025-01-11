#!/bin/bash

## This is a second patch after the greetd workaround to reapply pip packages that somehow did not get applied to /usr/bin.
### They will be symlinked in the /usr/local/bin instead.
ln -s /usr/lib/python3.13/site-packages/pywal/pywal /usr/local/bin/pywal
ln -s /usr/lib/python3.13/site-packages/screeninfo/screeninfo /usr/local/bin/screeninfo


exit 0
