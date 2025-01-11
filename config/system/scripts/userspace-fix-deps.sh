#!/bin/bash

## This is a second patch after the greetd workaround to reapply pip packages that somehow did not get applied to /usr/bin.
### They will be symlinked in the /usr/local/bin instead.
ln -s /usr/local/bin/pywal /usr/lib/python3.13/site-packages/pywal/pywal
ln -s /usr/local/bin/screeninfo /usr/lib/python3.13/site-packages/screeninfo/screeninfo


exit 0
